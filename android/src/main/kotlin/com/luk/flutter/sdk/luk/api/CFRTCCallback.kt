package com.luk.flutter.sdk.luk.api

import com.cftech.gamelibrary.CFGameSDK.ICFRTCCallback
import com.luk.flutter.sdk.luk.util.L
import com.luk.flutter.sdk.luk.LukPlugin


object CFRTCCallback : ICFRTCCallback {
    private const val TAG = "CFRTCCallback"
    override fun onCFGamePushSelfRTC(p0: Boolean): Boolean {
        L.info(TAG, "onCFGamePushSelfRTC(),p0:$p0")
        val params: HashMap<String, Any> = HashMap()
        params["push"] = p0
        LukPlugin.callFlutter("onCFGamePushSelfRTC", params)
        return true

    }

    override fun onCFGamePullOtherRTC(p0: String?, p1: Boolean): Boolean {
        L.info(TAG, "onCFGamePullOtherRTC(),p0:$p0,p1:$p1")
        val params: HashMap<String, Any> = HashMap()
        params["uid"] = p0 ?: ""
        params["pull"] = p1
        LukPlugin.callFlutter("onCFGamePullOtherRTC", params)
        return true

    }
}