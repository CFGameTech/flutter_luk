package com.luk.flutter.sdk.luk.api

import com.cftech.gamelibrary.CFGameSDK
import com.luk.flutter.sdk.luk.LukPlugin
import com.luk.flutter.sdk.luk.util.L
import com.luk.flutter.sdk.luk.util.ResultUtil
import io.flutter.plugin.common.MethodChannel

object CFSDKInitCallback : CFGameSDK.ICFSDKCallback {

    private const val TAG = "CFSDKInitCallback"

    var initResult: MethodChannel.Result? = null

    override fun onSuccess(){
        L.info(TAG, "SDK init on Success()")
        initResult?.success(ResultUtil.buildResult(0, "初始化成功"))
        initResult = null
        LukPlugin.callFlutter("onSDKInitSuccess")
    }


    override fun onError(p0: Int, p1: String?){
        L.info(TAG, "SDK init on Error()，code:$p0, msg:$p1")
        initResult?.success(ResultUtil.buildResult(p0, p1 ?: "初始化失败"))
        initResult = null
        val params: HashMap<String, Any> = HashMap()
        params["code"] = p0
        params["msg"] = p1 ?: ""
        LukPlugin.callFlutter("onSDKInitFail", params)
    }
}
