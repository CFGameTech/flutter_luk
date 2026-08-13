package com.luk.flutter.sdk.luk

import android.app.Activity
import android.os.Handler
import android.os.Looper
import com.luk.flutter.sdk.luk.api.CFGame
import com.luk.flutter.sdk.luk.api.CFLoginCallback
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.lang.ref.WeakReference
import java.util.concurrent.atomic.AtomicBoolean
/** LukPlugin */
class LukPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {

    private var channel: MethodChannel? = null
    private var activityRef: WeakReference<Activity>? = null
    private var isInitialized = AtomicBoolean(false)

    companion object {

        const val TAG = "LukPlugin"

        private var instanceRef: WeakReference<LukPlugin>? = null
        private val handler = Handler(Looper.getMainLooper())

        /**
         * 给flutter发送数据
         */
        fun callFlutter(
            method: String,
            args: HashMap<String, Any> = java.util.HashMap(),
            callback: Result? = null
        ) {
            // 需要在主线程调用flutter
            handler.post {
                val plugin = instanceRef?.get()
                if (plugin != null && plugin.channel != null) {
                    plugin.channel?.invokeMethod(method, args, callback)
                } else {
                }
            }
        }
    }


    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {

        if(!isInitialized.getAndSet(true)) {
            channel = MethodChannel(flutterPluginBinding.binaryMessenger, "luk")
            channel?.setMethodCallHandler(this)
            instanceRef =  WeakReference(this)

            flutterPluginBinding.platformViewRegistry.registerViewFactory(
                "luk/luk_game_view",
                LukPlatformViewFactory
            )
        }
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            //sdk初始化
            "setupSdk" -> {    toSetup(call, result)    }
            //用户登录
            "setUserInfo" -> {  toLogin(call, result)   }
            //获取游戏列表
            "getGameList" -> {  toGetGameList(result)   }
            //切换到后台
            "onPause" -> {  toPauseGame()   }
            //回到前台
            "onResume" -> {  toResumeGame()  }
            //销毁游戏
            "onDestroy" -> {    toDestroyGame() }
            //刷新用户数据
            "refreshUserInfo" -> {  CFGame.refreshUserInfo()    }
            //开始游戏
            "gameStart" -> {    CFGame.gameStart()  }
            //踢人
            "playerRemoveWithUid" -> {
                val data = call.arguments as HashMap<*, *>
                val uid = data["uid"] as String?
                CFGame.playerRemoveWithUid(uid ?: "")
            }
            //设置背景音乐
            "gameBackgroundMusicSet" -> {
                val data = call.arguments as HashMap<*, *>
                val mode = data["mode"] as Boolean?
                CFGame.gameBackgroundMusicSet(mode ?: false)
            }

            "gameSoundSet" -> {
                val data = call.arguments as HashMap<*, *>
                val mode = data["mode"] as Boolean?
                CFGame.gameSoundSet(mode ?: false)
            }

            "terminateGame" -> {
                CFGame.terminateGame()
            }

            "joinGame" -> {
                val data = call.arguments as HashMap<*, *>
                val position = data["position"] as Int?
                CFGame.joinGame(position ?: 0)
            }

            "quitGame" -> {
                CFGame.quitGame()
            }

            "setPlayerRole" -> {
                val data = call.arguments as HashMap<*, *>
                val role = data["role"] as Int?
                CFGame.setPlayerRole(role == 1)
            }

            "pauseGame" -> {
                CFGame.pauseGame()
            }

            "playGame" -> {
                CFGame.playGame()
            }

            "preloadGameList" -> {
                try {
                    val data = call.arguments as HashMap<*, *>
                    val gameIdList = data["gameIdList"] as List<Int>?
                    CFGame.preloadGameList(gameIdList)
                } catch (e: Exception) {
                    e.printStackTrace()
                }
            }

            "cancelPreloadGame" -> {
                try {
                    val data = call.arguments as HashMap<*, *>
                    val gameIdList = data["gameIdList"] as List<Int>?
                    CFGame.cancelPreloadGame(gameIdList)
                } catch (e: Exception) {
                    e.printStackTrace()
                }
            }

            "releaseSDK" -> {
                CFGame.releaseSDK()
            }

            "sentExtToGame" -> {
                val data = call.arguments as HashMap<*, *>
                val ext = data["ext"] as String?
                CFGame.sentExtToGame(ext)
            }

            "showCloseButton" -> {
                val data = call.arguments as HashMap<*, *>
                val isShow = data["isShow"] as Boolean?
                CFGame.showCloseButton(isShow ?: false)
            }

            "setLanguage" -> {
                val data = call.arguments as HashMap<*, *>
                val language = data["language"] as String?
                CFGame.setLanguage(language)
            }

            "gameReload" -> {
                CFGame.gameReload()
            }

            "setGameVoicePath" -> {
                val data = call.arguments as HashMap<*, *>
                val path = data["path"] as String?
                CFGame.setGameVoicePath(path)
            }

            "appNotifyStateChange" -> {
                val data = call.arguments as HashMap<*, *>
                val state = data["state"] as String?
                val dataJson = data["dataJson"] as String?
                CFGame.appNotifyStateChange(state, dataJson)
            }

            else -> {
                result.notImplemented()
            }
        }
    }

    private fun toDestroyGame() {
        LukPlatformViewFactory.onDestroy()
    }

    private fun toResumeGame() {
        LukPlatformViewFactory.onResume()
    }

    private fun toPauseGame() {
        LukPlatformViewFactory.onPause()
    }

    private fun toGetGameList(result: Result) {
        CFGame.getGameList {
            if (it?.isNotEmpty() == true) {
                val list = ArrayList<HashMap<String, Any>>()
                for (game in it) {
                    val infoMap = HashMap<String, Any>()
                    infoMap["g_id"] = game.g_id
                    infoMap["g_icon"] = game.g_icon
                    infoMap["g_name"] = game.g_name
                    infoMap["g_url"] = game.g_url
                    infoMap["g_zip_url"] = game.g_zip_url
                    infoMap["screen_half"] = game.screen_half
                    list.add(infoMap)
                }
                result.success(list)
            } else {
                result.success(ArrayList<HashMap<String, Any>>())
            }
        }
    }

    private fun toLogin(
        call: MethodCall,
        result: Result
    ) {
        val data = call.arguments as HashMap<*, *>
        val uid = data["uid"] as String
        val code = data["code"] as String
        CFLoginCallback.loginResult = result
        CFGame.setUserInfo(uid, code)
    }

    private fun toSetup(
        call: MethodCall,
        result: Result
    ) {
        val data = call.arguments as HashMap<*, *>
        val appId = data["appId"] as Int
        val language = (data["language"] as String?) ?: "zh_CN"
        val area = (data["area"] as String?) ?: "cn"
        val isProduct = data["isProduct"] as Boolean
        CFGame.initSdk(requireActivity().application, appId, isProduct, language, area)
        result.success(0)
    }

    private fun requireActivity(): Activity {
        val act = activityRef?.get() ?: throw RuntimeException("activity not found!")
        return act
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
//        channel.setMethodCallHandler(null)
//        channel?.setMethodCallHandler(null)
//        channel = null
//        instanceRef?.clear()
//        instanceRef = null
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activityRef = WeakReference(binding.activity)
    }

    override fun onDetachedFromActivityForConfigChanges() {

    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activityRef = WeakReference(binding.activity)
    }

    override fun onDetachedFromActivity() {
        activityRef?.clear()
        activityRef = null
    }
}
