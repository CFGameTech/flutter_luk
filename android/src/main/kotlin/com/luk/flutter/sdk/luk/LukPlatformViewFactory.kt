package com.luk.flutter.sdk.luk

import android.content.Context
import com.cftech.gamelibrary.CFGameSDK
import com.cftech.gamelibrary.module.CFGameList
import com.luk.flutter.sdk.luk.view.LukPlatformView
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

/**
 * 视图状态机
 */
enum class GameViewStatus {
    OnCreated,
    OnResumed,
    OnPaused,
    OnDestroyed
}

/**
 * 视图工厂
 */
object LukPlatformViewFactory : PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    var gameStatus: GameViewStatus = GameViewStatus.OnDestroyed     //游戏状态
    var gameView: LukPlatformView? = null   //游戏视图
    var creationArgs: Map<String?, Any>? = null //初始化参数
    var gameInfo: CFGameList.GameInfo? = null    //游戏信息
    private const val TAG = "LukPlatformViewFactory"

    fun getCreationRoomId(): String {
        return creationArgs?.get("roomId")?.toString() ?: ""
    }

    fun isCreationRoomOwner(): Boolean {
        return creationArgs?.get("isRoomOwner") == true
    }

    fun getWindowSafeArea(): CFGameSDK.CFRect {
        val left = creationArgs?.get("left") as Int
        val top = creationArgs?.get("top") as Int
        val right = creationArgs?.get("right") as Int
        val bottom = creationArgs?.get("bottom") as Int
        val scaleMinLimit = creationArgs?.get("scaleMinLimit") as Float
        val ret = CFGameSDK.CFRect(left, top, right, bottom, scaleMinLimit)
        return ret
    }

    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        val creationParams = args as Map<String?, Any>
        val gameInfo = CFGameList.GameInfo()
        gameInfo.g_id = creationParams["g_id"] as Int
        gameInfo.g_url = creationParams["g_url"] as String
        gameInfo.g_zip_url = creationParams["g_zip_url"] as String
        gameInfo.g_icon = creationParams["g_icon"] as String
        gameInfo.g_name = creationParams["g_name"] as String
        gameInfo.screen_half = creationParams["screen_half"] as Int
        if (LukPlatformViewFactory.gameInfo != null && gameView != null && LukPlatformViewFactory.gameInfo?.g_id == gameInfo.g_id) {
            gameView?.onResume()
            gameStatus = GameViewStatus.OnResumed
        } else {
            gameView?.destroy()
            gameView = LukPlatformView(context.applicationContext, creationParams)
            creationArgs = creationParams
            gameStatus = GameViewStatus.OnCreated
            gameView?.loadGame(gameInfo.g_id, gameInfo.g_url)
            gameStatus = GameViewStatus.OnResumed
        }
        LukPlatformViewFactory.gameInfo = gameInfo
        return gameView!!
    }
}