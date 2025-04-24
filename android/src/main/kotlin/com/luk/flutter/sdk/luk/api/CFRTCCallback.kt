package com.luk.flutter.sdk.luk.api

import com.cftech.gamelibrary.CFGameSDK.ICFRTCCallback
import com.luk.flutter.sdk.luk.util.L

object CFRTCCallback : ICFRTCCallback {
    private const val TAG = "CFRTCCallback"
    override fun onCFGamePushSelfRTC(p0: Boolean): Boolean {
        L.info(TAG, "onCFGamePushSelfRTC(),p0:$p0")
        return false
    }

    override fun onCFGamePullOtherRTC(p0: String?, p1: Boolean): Boolean {
        L.info(TAG, "onCFGamePullOtherRTC(),p0:$p0,p1:$p1")
        return false
    }
}