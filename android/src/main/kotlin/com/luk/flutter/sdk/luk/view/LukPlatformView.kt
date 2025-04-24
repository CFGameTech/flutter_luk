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
class LukPlatformView(p0: Context?, private val args: Map<String?, Any>?) : CFGWebView(p0),
    PlatformView {

    private val TAG = "LukPlatformView"

    override fun getView(): View {
        return this
    }

    override fun dispose() {
        L.info(TAG, "dispose()")
    }

//    fun loadGame() {
//        val data = args!!
//        val gameId = data["g_id"] as Int
//        val url = data["g_url"] as String
//        //视图创建或者是游戏变化的时候重新加载
//        if (LukPlatformViewFactory.gameStatus == GameViewStatus.OnCreated
//            || gameId != LukPlatformViewFactory.gameId
//            || url != LukPlatformViewFactory.gameUrl
//        ) {
//            if (LukPlatformViewFactory.gameView != null) {
//                LukPlatformViewFactory.gameView?.loadGame(gameId, url)
//                LukPlatformViewFactory.gameId = gameId
//                LukPlatformViewFactory.gameUrl = url
//                LukPlatformViewFactory.gameStatus = GameViewStatus.OnResumed
//            }
//        } else if (LukPlatformViewFactory.gameStatus == GameViewStatus.OnPaused) {  //游戏已暂停的话，就设为继续状态
//            LukPlatformViewFactory.gameView?.onResume()
//            LukPlatformViewFactory.gameStatus = GameViewStatus.OnResumed
//        } else {
//            // do nothing!
//        }
//    }

}