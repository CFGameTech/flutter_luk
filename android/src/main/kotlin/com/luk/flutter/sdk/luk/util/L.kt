package com.luk.flutter.sdk.luk.util

import com.luk.flutter.sdk.luk.LukPlugin
import com.luk.flutter.sdk.luk.api.ILogger

object L : ILogger {
    override fun info(tag: String, msg: String) {
        val fixTag = "LUK:$tag"
        android.util.Log.i(fixTag, msg)
        val params: HashMap<String, Any> = HashMap()
        params["tag"] = fixTag
        params["msg"] = msg
        LukPlugin.callFlutter("onInfo", params)

    }

    override fun debug(tag: String, msg: String) {
        val fixTag = "LUK:$tag"
        android.util.Log.d(tag, msg)
        val params: HashMap<String, Any> = HashMap()
        params["tag"] = fixTag
        params["msg"] = msg
        LukPlugin.callFlutter("onDebug", params)
    }

    override fun error(tag: String, msg: String) {
        val fixTag = "LUK:$tag"
        android.util.Log.e(tag, msg)
        val params: HashMap<String, Any> = HashMap()
        params["tag"] = fixTag
        params["msg"] = msg
        LukPlugin.callFlutter("onError", params)
    }

    override fun warn(tag: String, msg: String) {
        val fixTag = "LUK:$tag"
        android.util.Log.w(tag, msg)
        val params: HashMap<String, Any> = HashMap()
        params["tag"] = fixTag
        params["msg"] = msg
        LukPlugin.callFlutter("onWarn", params)
    }

}