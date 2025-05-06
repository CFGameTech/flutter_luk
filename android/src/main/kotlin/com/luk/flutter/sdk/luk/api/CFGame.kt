package com.luk.flutter.sdk.luk.api

import android.app.Application
import com.cftech.gamelibrary.CFGameSDK
import com.cftech.gamelibrary.interfaces.ICFGameListCallback
import com.cftech.gamelibrary.module.CFGameList
import com.luk.flutter.sdk.luk.util.L

object CFGame {

    private const val TAG = "CFGame"

    fun initSdk(
        application: Application,
        appId: Int,
        isProduct: Boolean = true,
        language: String = "zh_CN",
        area: String = "cn"
    ) {
        L.info(TAG, "initSdk(),appId:$appId,isProduct:$isProduct,language:$language,area$area")

        CFGameSDK.initSDK(application, appId, language, area, isProduct)
        //业务回调监听：该监听会影响游戏的正常运行，因此必须设置。只需设置一次即可
        CFGameSDK.setBizCallback(CFBizCallback)
        //游戏状态监听：在游戏启动后，SDK 会通过游戏状态监听通知接入方各种游戏状态。
        CFGameSDK.setCFGameLifecycle(CFGameLifecycle)
        //可选 RTC 相关监听：如果您的游戏需要语音功能（如：“谁是卧底”），您需要实现该回调。
        CFGameSDK.setRTCCallback(CFRTCCallback)
        // 隐藏游戏里面的右上角的关闭按钮（不配置可用后台控制）
//        CFGameSDK.showCloseButton(false)
        //日志输出
        CFGameSDK.setLogger(CFLogger)
        // 网络状态监听
//        CFGameSDK.setReportStatsEventListener(CFReportStatsEventCallback)
    }

    /**
     * 设置用户信息（app用户登录成功之后调用）
     */
    fun setUserInfo(uid: String, code: String) {
        L.info(TAG, "setUserInfo(),uid:$uid,code:$code")
        //登录回调监听：设置用户信息后，才能打开游戏界面，因此需要关注登录是否成功。登录监听应在调用 setUserInfo 方法时同时设置。
        CFGameSDK.setUserInfo(uid, code, CFLoginCallback)
    }

    /**
     * 获取小游戏列表(必须在用户登录成功之后调用)
     */
    fun getGameList(callback: ((MutableList<CFGameList.GameInfo>?) -> Unit)) {
        CFGameSDK.getGameList(object : ICFGameListCallback {
            override fun onSuccess(p0: MutableList<CFGameList.GameInfo>?) {
                L.info(TAG, "getGameList(), success! list size:${p0?.size}")
                callback(p0)
            }

            override fun onError(p0: Int, p1: String?) {
                L.error(TAG, "getGameList(), error! code:$p0,msg:$p1")
                callback(null)
            }
        })
    }

    /**
     * 加入游戏
     */
    fun joinGame(position: Int) {
        L.info(TAG, "joinGame(), position:$position")
        CFGameSDK.GameLifecycleApi.joinGame(position)
    }

    /**
     * 可通过调用退出游戏,用户退出游戏时使用，不会销毁房间，仅退出当前用户。
     */
    fun quitGame() {
        L.info(TAG, "quitGame()")
        CFGameSDK.GameLifecycleApi.quitGame()
    }

    /**
     * 可通过调用终止游戏，强制停止当前游戏，一般在房主销毁游戏房使用。
     */
    fun terminateGame() {
        L.info(TAG, "terminateGame()")
        CFGameSDK.GameLifecycleApi.terminateGame()
    }

    /**
     * 设置当前用户是否是游戏管理权限拥有者
     */
    fun setPlayerRole(isGameOwner: Boolean) {
        L.info(TAG, "setPlayerRole(),isGameOwner:$isGameOwner")
        if (isGameOwner) {
            CFGameSDK.GameLifecycleApi.setPlayerRole(1)
        } else {
            CFGameSDK.GameLifecycleApi.setPlayerRole(0)
        }
    }

    fun refreshUserInfo() {
        L.info(TAG, "refreshUserInfo")
        CFGameSDK.refreshUserInfo()
    }

    fun gameStart() {
        L.info(TAG, "gameStart")
        CFGameSDK.GameLifecycleApi.gameStart()
    }

    fun playerRemoveWithUid(uid: String) {
        L.info(TAG, "removePlayerWithUid(),uid:$uid")
        CFGameSDK.GameLifecycleApi.playerRemoveWithUid(uid)
    }

    fun gameBackgroundMusicSet(mode: Boolean) {
        L.info(TAG, "gameBackgroundMusicSet(),mode:${mode}")
        CFGameSDK.GameLifecycleApi.gameBackgroundMusicSet(mode)
    }

    fun gameSoundSet(mode: Boolean) {
        L.info(TAG, "gameSoundSet(),mode:${mode}")
        CFGameSDK.GameLifecycleApi.gameSoundSet(mode)
    }

    fun pauseGame() {
        L.info(TAG, "pauseGame()")
        CFGameSDK.GameLifecycleApi.pauseGame()
    }

    fun playGame() {
        L.info(TAG, "playGame()")
        CFGameSDK.GameLifecycleApi.playGame()
    }

    fun preloadGameList(gameIdList: List<Int>?) {
        L.info(TAG, "preloadGameList(),gameIdList size:${gameIdList?.size}")
        if (gameIdList?.isNotEmpty() == true) {
            val longList: List<Long> = gameIdList.map { it.toLong() }
            CFGameSDK.preloadGameList(longList, CFGamePreloadCallback)
        }
    }

    fun cancelPreloadGame(gameIdList: List<Int>?) {
        L.info(TAG, "cancelPreloadGame(),gameIdList size:${gameIdList?.size}")
        if (gameIdList?.isNotEmpty() == true) {
            val longList: List<Long> = gameIdList.map { it.toLong() }
            CFGameSDK.cancelPreloadGame(longList)
        }
    }

    fun releaseSDK() {
        L.info(TAG, "releaseSDK()")
        CFGameSDK.releaseSDK()
    }

    fun sentExtToGame(ext: String?) {
        L.info(TAG, "sentExtToGame(),ext is not empty? -> ${ext?.isNotEmpty()}")
        if (ext?.isNotEmpty() == true) {
            CFGameSDK.sentExtToGame(ext)
        }
    }

    fun showCloseButton(isShow: Boolean) {
        L.info(TAG, "showCloseButton(),isShow:$isShow")
        CFGameSDK.showCloseButton(isShow)
    }

    fun setLanguage(language: String?) {
        L.info(TAG, "setLanguage(),language:$language")
        if (language?.isNotEmpty() == true) {
            CFGameSDK.setLanguage(language)
        }
    }

    fun gameReload() {
        L.info(TAG, "gameReload()")
        CFGameSDK.gameReload()
    }

    fun setGameVoicePath(path: String?) {
        L.info(TAG, "setGameVoicePath(),path:$path")
        if (path?.isNotEmpty() == true) {
            CFGameSDK.setGameVoicePath(path)
        }
    }

    fun appNotifyStateChange(state: String?, dataJson: String?) {
        L.info(TAG, "appNotifyStateChange(),state:$state,dataJson:$dataJson")
        if (state?.isNotEmpty() == true) {
            CFGameSDK.appNotifyStateChange(state, dataJson ?: "{}")
        }
    }


}