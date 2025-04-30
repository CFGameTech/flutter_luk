package com.luk.flutter.sdk.luk.api

import com.luk.flutter.sdk.luk.LukPlugin
import com.luk.flutter.sdk.luk.util.L

object CFGamePreloadCallback : com.cftech.gamelibrary.CFGameSDK.ICFPreloadGameCallback {

    const val TAG = "CFGamePreloadCallback"

    override fun onPreLoadGameSuccess(gid: String?, state: Int) {
        L.info(TAG, "onPreLoadGameSuccess(),gid:$gid,state:$state")
        val params: HashMap<String, Any> = HashMap()
        params["gid"] = gid ?: ""
        params["state"] = state
        LukPlugin.callFlutter("onPreLoadGameSuccess", params)
    }
}