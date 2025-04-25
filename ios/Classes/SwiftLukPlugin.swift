import Flutter
import UIKit
import CFGameSDK

public class SwiftLukPlugin: NSObject, FlutterPlugin {
    
    static var gameViewFactory: LukGameViewFactory?
    static var channel:FlutterMethodChannel?
    private var pendingResult: FlutterResult?
    private var canJoinGame:Bool = false
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        channel = FlutterMethodChannel(name: "luk", binaryMessenger: registrar.messenger())
        let instance = SwiftLukPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel!)
        let viewFactory = LukGameViewFactory(registrarInstance: registrar)
        gameViewFactory = viewFactory;
        registrar.register(viewFactory, withId: "luk/luk_game_view")
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "setupSdk": // sdk初始化
            guard let args = call.arguments as? [String: Any],
                  let appId = args["appId"] as? Int,
                  let language = args["language"] as? String,
                  let area = args["area"] as? String,
                  let isProduct = args["isProduct"] as? Bool else {
                result(ResultUtil.buildResult(code: -1, msg: "params illegale!", data: nil))
                return
            }
            CFGameSDK.setUpWith(UIApplication.shared, appId: "\(appId)", language: language, area: area, isProduct: isProduct)
            // SDK 代理
            CFGameSDK.setBizCallback(self)
            // 游戏状态代理
            CFGameSDK.setCFGameLifecycleCallback(self)
            // 可选 RTC 相关代理
            CFGameSDK.setRTCCallback(self)
            // sdk日志输出
            CFGameSDK.cfGameSDKLog { msg in
                let map: [String: Any] = ["tag":"CFGameLog", "msg": msg]
                SwiftLukPlugin.channel?.invokeMethod("onInfo", arguments: map)
            }
            result(0)
        case "setUserInfo": // 用户登录
            guard let args = call.arguments as? [String: Any],
                  let uid = args["uid"] as? String else {
                result(FlutterError(code: "INVALID_ARGUMENTS", message: "Missing or invalid arguments for setUserInfo", details: nil))
                return
            }
            let code = args["code"] as? String ?? ""
            // 👇 暂存result
            self.pendingResult = result
            CFGameSDK.setUserInfo(uid, code: code, loginCallBack: self)
        case "getGameList": //获取游戏列表
            CFGameSDK.getGameList { gameList in
                let list = gameList.map { game in
                    return [
                        "g_id": game.g_id,
                        "g_icon": game.g_icon,
                        "g_name": game.g_name,
                        "g_url": game.g_url,
                        "g_zip_url": "",
                        "screen_half": 0
                    ]
                }
                result(list)
            } failure: { code, msg in
                result(FlutterError(code: "\(code)", message: msg, details: nil))
            }
            
        case "onPause": // 切换到后台
            if SwiftLukPlugin.gameViewFactory?.lukGameView != nil {
                CFGameSDK.gamePause()
            }
            // 暂停游戏
            result(nil)
        case "onResume": // 回到前台
            // 恢复游戏
            CFGameSDK.gamePlay()
            result(nil)
        case "onDestroy":
            // 销毁游戏
            CFGameSDK.finishGameWindow()
            SwiftLukPlugin.gameViewFactory?.lukGameView = nil
            SwiftLukPlugin.gameViewFactory?.gameModel = nil
            result(nil)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
}

extension SwiftLukPlugin: CFGameSDKLoginDelegate {
    
    /**
     *
     * 用户登录成功回调
     */
    public func onLoginSuccess() {
        print("onLoginSuccess")
        
        if let result = pendingResult {
            let map: [String: Any] = ["code": 0, "msg": ""]
            result(map)
            pendingResult = nil
        }
        SwiftLukPlugin.channel?.invokeMethod("onLoginSuccess", arguments: nil)
    }
    
    /**
     *
     * 用户登录失败回调
     */
    public func onLoginFailCode(_ code: Int32, message msg: String) {
        print("onLoginFailCode code:'\(code) msg:\(msg)")
        if let result = pendingResult {
            let map: [String: Any] = ["code": code, "msg": msg]
            result(map)
        }
        pendingResult = nil
        let map: [String: Any] = ["code": code, "msg":msg]
        SwiftLukPlugin.channel?.invokeMethod("onLoginFail", arguments: map)
    }
    
    /**
     * token刷新
     */
    public func onRefreshToken(_ token: String) {
        let map: [String: Any] = ["token": token]
        SwiftLukPlugin.channel?.invokeMethod("onRefreshToken", arguments: map)
    }
}

extension SwiftLukPlugin: CFGameSDKDelegate {
    /**
     *
     * Returns：当前用户所在的房间号，如果没有互动玩法可直接返回空字符串
     */
    public func onGetCurrentRoomId() -> String? {
        return SwiftLukPlugin.gameViewFactory?.roomId;
    }
    /**
     *
     * Returns：如果平台无需指定游戏管理员可直接返回false
     */
    public func onIsRoomOwner() -> Bool {
        return SwiftLukPlugin.gameViewFactory?.isRoomOwner ?? false
    }
    /**
     *
     * Returns：游戏视图的安全区域，若无要求可返回null
     */
    public func onWindowSafeArea() -> CFGameEdgeInsets {
        return SwiftLukPlugin.gameViewFactory?.safeArea ?? CFGameEdgeInsets.init()
    }
}

extension SwiftLukPlugin: CFGameLifeCycleDelegate {
    
    /**
     *
     * 游戏加载失败
     */
    public func onGameLoadFail() {
        SwiftLukPlugin.channel?.invokeMethod("onGameLoadFail", arguments: nil)
    }

    /**
        游戏加载完毕
     */
    public func gameDidFinishLoad() {
        SwiftLukPlugin.channel?.invokeMethod("gameDidFinishLoad", arguments: nil)
    }

    /**
     *
     * 用户自动上麦加入游戏
     */
    public func onPreJoinGame(_ uid: String, seatIndex: Int) -> Bool {
        if (!canJoinGame) {
            let map: [String: Any] = ["uid": uid, "seatIndex": seatIndex]
            SwiftLukPlugin.channel?.invokeMethod("onPreJoinGame", arguments: map, result: {(result)-> Void in
                let r = result as? Bool ?? false
                if(r){
                    self.canJoinGame = true
                    CFGameSDK.joinGame(seatIndex)
                }
            })
            return false
        } else {
            canJoinGame = false
            return true
        }
    }


    /**
     *
     * 用户准备游戏
     */
    public func onGamePrepare(_ uid: String) {
        let map: [String: Any] = ["uid": uid]
        SwiftLukPlugin.channel?.invokeMethod("onGamePrepare", arguments: map)
    }

    /**
     *
     * 用户取消准备
     */
    public func onCancelPrepare(_ uid: String) {
        let map: [String: Any] = ["uid": uid]
        SwiftLukPlugin.channel?.invokeMethod("onCancelPrepare", arguments: map)
    }

    /**
     *
     * 用户点击用户头像
     */
    public func onSeatAvatarTouch(_ uid: String, seatIndex index: Int) {
        let map: [String: Any] = ["uid": uid, "seatIndex": index]
        SwiftLukPlugin.channel?.invokeMethod("onSeatAvatarTouch", arguments: map)
    }


    /**
     *
     *  购买结果回调
     */
    public func onGamePurchaseResult(_ code: Int32, orderId: String) {
        let map: [String: Any] = ["code": code, "orderId": orderId]
        SwiftLukPlugin.channel?.invokeMethod("onGamePurchaseResult", arguments: map)
    }


    /**
     *
     *   音乐播放回调
     */
    public func onGameMusicStartPlay(_ musicId: Int32, musicUrl: String, isLoop: Bool) -> Int32 {
        let map: [String: Any] = ["musicId": musicId, "musicUrl": musicUrl,"isLoop":isLoop]
        SwiftLukPlugin.channel?.invokeMethod("onGameMusicStartPlay", arguments: map)
        return 0
    }
    /**
     *
     *   音乐停止播放回调
     */
    public func onGameMusicStopPlay(_ musicId: Int32) -> Int32 {
        let map: [String: Any] = ["musicId": musicId]
        SwiftLukPlugin.channel?.invokeMethod("onGameMusicStopPlay", arguments: map)
        return 0
    }
    /**
     *
     *   音效播放回调
     */
    public func onGameEffectSoundStartPlay(_ soundId: Int32, soundUrl: String, isLoop: Bool) -> Int32 {
        let map: [String: Any] = ["soundId": soundId,"soundUrl":soundUrl,"isLoop":isLoop]
        SwiftLukPlugin.channel?.invokeMethod("onGameEffectSoundStartPlay", arguments: map)
        return 0
    }
    /**
     *
     *   音乐停止播放回调
     */
    public func onGameEffectSoundStopPlay(_ effectId: Int32) -> Int32 {
        let map: [String: Any] = ["effectId": effectId]
        SwiftLukPlugin.channel?.invokeMethod("onGameEffectSoundStopPlay", arguments: map)
        return 0
    }


    /**
     *
     * 游戏结束
     */
    public func onGameOver() {
        SwiftLukPlugin.channel?.invokeMethod("onGameOver", arguments: nil)
    }


    /**
     * 游戏状态变化
     * @param state     状态码
     * @param dataJson  参数
     */
    public func onGameStateChangeState(_ state: String, dataJson: String?) {
        let map: [String: Any] = ["state": state,"dataJson":dataJson ?? "{}"]
        SwiftLukPlugin.channel?.invokeMethod("onGameStateChangeState", arguments: map)
    }


    /**
     * 游戏玩家状态变化
     * @param userId   用户id
     * @param state    状态码
     * @param dataJson 参数
     */
    public func onPlayerStateChangeState(_ uid: String, state: String, dataJson: String?) {
        let map: [String: Any] = ["uid": uid,"state": state, "dataJson":dataJson ?? "{}"]
        SwiftLukPlugin.channel?.invokeMethod("onPlayerStateChangeState", arguments: map)
    }
}

extension SwiftLukPlugin: CFGameSDKRTCDelegate {
    /**
        推自己的流
     */
    public func onCFGamePushSelfRTC(_ push: Bool) -> Bool {
        print("onCFGamePushSelfRTC push:\(push)")
        let map: [String: Any] = ["push": push]
        SwiftLukPlugin.channel?.invokeMethod("onCFGamePushSelfRTC", arguments: map)

        return true;
    }
    /**
        拉取uid的流
     */
    public func onCFGamePullOtherRTC(_ uid: String, pull: Bool) -> Bool {
        print("onCFGamePullOtherRTC uid:\(uid) pull:\(pull)")
        let map: [String: Any] = ["uid": uid,"pull": pull]
        SwiftLukPlugin.channel?.invokeMethod("onCFGamePullOtherRTC", arguments: map)

        return true;
    }
}
