package com.luk.flutter.sdk.luk.api

import com.cftech.gamelibrary.CFGameSDK
import com.luk.flutter.sdk.luk.LukPlugin
import com.luk.flutter.sdk.luk.util.L
import com.luk.flutter.sdk.luk.util.ResultUtil
import io.flutter.plugin.common.MethodChannel

object CFLoginCallback : CFGameSDK.ICFLoginCallback {

    private const val TAG = "CFLoginCallback"

    var loginResult: MethodChannel.Result? = null

    override fun onLoginSuccess() {
        L.info(TAG, "onLoginSuccess()")
        loginResult?.success(ResultUtil.buildResult(0, "登录成功"))
        loginResult = null
        LukPlugin.callFlutter("onLoginSuccess")
    }

    override fun onLoginFail(p0: Int, p1: String?) {
        L.info(TAG, "onLoginFail()，code:$p0, msg:$p1")
        loginResult?.success(ResultUtil.buildResult(p0, p1 ?: "发生未知错误"))
        loginResult = null
        val params: HashMap<String, Any> = HashMap()
        params["code"] = p0
        params["msg"] = p1 ?: ""
        LukPlugin.callFlutter("onLoginFail", params)
    }

    override fun onRefreshToken(p0: String?) {
        L.info(TAG, "onRefreshToken(), token:$p0")
        val params: HashMap<String, Any> = HashMap()
        params["token"] = p0 ?: ""
        LukPlugin.callFlutter("onRefreshToken", params)
    }
}