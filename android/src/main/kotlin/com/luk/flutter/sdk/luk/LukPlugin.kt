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

/** LukPlugin */
class LukPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {

    companion object {
        lateinit var channel: MethodChannel
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
                channel.invokeMethod(method, args, callback)
            }
        }
    }

    private var activityRef: WeakReference<Activity>? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "luk")
        channel.setMethodCallHandler(this)
        flutterPluginBinding.platformViewRegistry.registerViewFactory(
            "luk/luk_game_view",
            LukPlatformViewFactory
        )
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "setupSdk" -> {    //sdk初始化
                toSetup(call, result)
            }
            "setUserInfo" -> {  //用户登录
                toLogin(call, result)
            }
            "getGameList" -> {  //获取游戏列表
                toGetGameList(result)
            }
            "onPause" -> {  //切换到后台
                toPauseGame()
            }
            "onResume" -> { //回到前台
                toResumeGame()
            }
            "onDestroy" -> {    //销毁游戏
                toDestroyGame()
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    private fun toDestroyGame() {
        LukPlatformViewFactory.gameView?.destroy()
        LukPlatformViewFactory.gameView = null
        LukPlatformViewFactory.gameInfo = null
        LukPlatformViewFactory.creationArgs = null
        LukPlatformViewFactory.gameStatus = GameViewStatus.OnDestroyed
    }

    private fun toResumeGame() {
        if (LukPlatformViewFactory.gameStatus == GameViewStatus.OnPaused) {
            LukPlatformViewFactory.gameView?.onResume()
            LukPlatformViewFactory.gameStatus = GameViewStatus.OnResumed
        }
    }

    private fun toPauseGame() {
        if (LukPlatformViewFactory.gameStatus == GameViewStatus.OnResumed) {
            LukPlatformViewFactory.gameView?.onPause()
            LukPlatformViewFactory.gameStatus = GameViewStatus.OnPaused
        }
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
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activityRef = WeakReference(binding.activity)
    }

    override fun onDetachedFromActivityForConfigChanges() {

    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {

    }

    override fun onDetachedFromActivity() {

    }
}
