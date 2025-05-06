package com.luk.flutter.sdk.luk

import android.content.Context
import com.cftech.gamelibrary.CFGameSDK
import com.cftech.gamelibrary.module.CFGameList
import com.luk.flutter.sdk.luk.view.LukPlatformView
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import com.luk.flutter.sdk.luk.util.L

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
    var creationArgs: Map<*, *>? = null //初始化参数
    var gameInfo: CFGameList.GameInfo? = null    //游戏信息
    private var roomId: String = "" //房间id
    private const val TAG = "LukPlatformViewFactory"

    fun getCreationRoomId(): String {
        roomId = creationArgs?.get("roomId")?.toString() ?: ""
        return roomId
    }

    fun isCreationRoomOwner(): Boolean {
        return creationArgs?.get("isRoomOwner") == true
    }

    fun getWindowSafeArea(): CFGameSDK.CFRect {
        val left = creationArgs?.get("left") as Int
        val top = creationArgs?.get("top") as Int
        val right = creationArgs?.get("right") as Int
        val bottom = creationArgs?.get("bottom") as Int
        val scaleMinLimit = (creationArgs?.get("scaleMinLimit")?.toString() ?: "0.0").toFloat()
        val ret = CFGameSDK.CFRect(left, top, right, bottom, scaleMinLimit)
        return ret
    }

    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        val creationParams = args as Map<*, *>
        val roomId = creationParams["roomId"]?.toString() ?: ""
        val gameInfo = CFGameList.GameInfo()
        gameInfo.g_id = creationParams["g_id"] as Int
        gameInfo.g_url = creationParams["g_url"] as String
        gameInfo.g_zip_url = creationParams["g_zip_url"] as String
        gameInfo.g_icon = creationParams["g_icon"] as String
        gameInfo.g_name = creationParams["g_name"] as String
        gameInfo.screen_half = creationParams["screen_half"] as Int
        if (LukPlatformViewFactory.gameInfo != null
            && gameView != null
            && LukPlatformViewFactory.gameInfo?.g_id == gameInfo.g_id
            && LukPlatformViewFactory.gameInfo?.g_url == gameInfo.g_url
            && roomId == this.roomId
        ) { //满足条件(已经加载过游戏，并且是同一个房间的同一个游戏)则从挂起状态恢复
            L.info(
                TAG,
                "resume the same game instance!, gameId:${gameInfo.g_id},roomId:${roomId},url:${gameInfo.g_url}"
            )
            gameView?.onResume()
            gameStatus = GameViewStatus.OnResumed
        } else {    //否则重新创建
            L.info(TAG, "new game instance!, gameId:${gameInfo.g_id},roomId:${roomId},url:${gameInfo.g_url}")
            gameView?.destroy()
            LukPlatformViewFactory.gameInfo = gameInfo
            creationArgs = creationParams
            gameView = LukPlatformView(context.applicationContext, creationParams)
            gameStatus = GameViewStatus.OnCreated
            gameView?.loadGame(gameInfo.g_id, gameInfo.g_url)
            gameStatus = GameViewStatus.OnResumed
        }
        return gameView!!
    }
    fun onResume() {
        L.info(TAG, "onResume()")
        if (gameStatus == GameViewStatus.OnPaused) {
            gameView?.onResume()
            gameStatus = GameViewStatus.OnResumed
        } else {
            L.warn(TAG, "illegal state！cannot call onResume() when current state is not OnPaused!")
        }
    }

    fun onPause() {
        L.info(TAG, "onPause()")
        if (gameStatus == GameViewStatus.OnResumed) {
            gameView?.onPause()
            gameStatus = GameViewStatus.OnPaused
        } else {
            L.warn(TAG, "illegal state！cannot call onPause() when current state is not OnResumed!")
        }
    }

    fun onDestroy() {
        L.info(TAG, "onDestroy()")
        gameView?.destroy()
        gameView = null
        gameInfo = null
        creationArgs = null
        roomId = ""
        gameStatus = GameViewStatus.OnDestroyed
    }
}