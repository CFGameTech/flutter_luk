package com.luk.flutter.sdk.luk.view

import android.annotation.SuppressLint
import android.content.Context
import android.view.View
import com.cftech.gamelibrary.view.webview.CFGWebView
import com.luk.flutter.sdk.luk.GameViewStatus
import com.luk.flutter.sdk.luk.LukPlatformViewFactory
import com.luk.flutter.sdk.luk.util.L
import io.flutter.plugin.platform.PlatformView

/**
 * 自定义platformView桥接原生sdk的相关业务逻辑
 */
@SuppressLint("ViewConstructor")
class LukPlatformView(p0: Context?, private val args: Map<*, *>) : CFGWebView(p0),
    PlatformView {

    private val TAG = "LukPlatformView"

    override fun getView(): View {
        return this
    }

    override fun dispose() {
        L.info(TAG, "dispose()")
    }

}