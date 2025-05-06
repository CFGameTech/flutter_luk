package com.luk.flutter.sdk.luk.api

import com.cftech.gamelibrary.CFGameSDK
import com.luk.flutter.sdk.luk.LukPlugin
import com.luk.flutter.sdk.luk.api.CFGamePreloadCallback.TAG
import com.luk.flutter.sdk.luk.util.L

object CFReportStatsEventCallback : CFGameSDK.ICFReportStatsEventCallback {
    override fun onReportStatsEvent(event: String?, code: Int, msg: String?) {
        L.info(TAG, "onReportStatsEvent(),event:$event,code:$code,msg:$msg")
        val params: HashMap<String, Any> = HashMap()
        params["event"] = event ?: ""
        params["msg"] = msg ?: ""
        params["code"] = code
        LukPlugin.callFlutter("onReportStatsEvent", params)
    }
}