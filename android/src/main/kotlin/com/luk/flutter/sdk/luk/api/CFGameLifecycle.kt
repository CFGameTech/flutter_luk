package com.luk.flutter.sdk.luk.api

import com.cftech.gamelibrary.CFGameSDK.ICFGameLifecycle
import com.luk.flutter.sdk.luk.LukPlugin
import com.luk.flutter.sdk.luk.util.L
import io.flutter.plugin.common.MethodChannel.Result

object CFGameLifecycle : ICFGameLifecycle {

    private const val TAG = "CFGameLifecycle"

    private var canJoinGame = false     //是否可以直接加入游戏

    override fun onGameLoadFail() {
        L.info(TAG, "onGameLoadFail()")
        LukPlugin.callFlutter("onGameLoadFail")
    }

    override fun onPreJoinGame(p0: String?, p1: Int): Boolean {
        L.info(TAG, "onPreJoinGame(),p0:$p0, p1:$p1,canJoinGame:$canJoinGame")
        if (!canJoinGame) {
            val params: HashMap<String, Any> = HashMap()
            params["uid"] = p0 ?: ""
            params["seatIndex"] = p1
            LukPlugin.callFlutter("onPreJoinGame", params, object : Result {
                override fun success(result: Any?) {
                    if (result == true) {
                        canJoinGame = true
                        CFGame.joinGame(p1)
                    }
                }

                override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {

                }

                override fun notImplemented() {

                }
            })
        } else {
            canJoinGame = false
            return true
        }
        return canJoinGame
    }

    override fun onGamePrepare(p0: String?) {
        L.info(TAG, "onGamePrepare(),p0:$p0")
        val params: HashMap<String, Any> = HashMap()
        params["uid"] = p0 ?: ""
        LukPlugin.callFlutter("onGamePrepare", params)
    }

    override fun onCancelPrepare(p0: String?) {
        L.info(TAG, "onCancelPrepare(),p0:$p0")
        val params: HashMap<String, Any> = HashMap()
        params["uid"] = p0 ?: ""
        LukPlugin.callFlutter("onCancelPrepare", params)
    }

    override fun onGameOver() {
        L.info(TAG, "onGameOver()")
        LukPlugin.callFlutter("onGameOver")
    }

    override fun onGameDidFinishLoad() {
        L.info(TAG, "onGameDidFinishLoad()")
        LukPlugin.callFlutter("onGameDidFinishLoad")
    }

    override fun onSeatAvatarTouch(p0: String?, p1: Int) {
        L.info(TAG, "onSeatAvatarTouch(),p0:$p0,p1:$p1")
        val params: HashMap<String, Any> = HashMap()
        params["uid"] = p0 ?: ""
        params["seatIndex"] = p1
        LukPlugin.callFlutter("onSeatAvatarTouch", params)
    }

    override fun onGameStateChangeState(state: String, dataJson: String?) {
        val params: HashMap<String, Any> = HashMap()
        params["state"] = state
        params["dataJson"] = dataJson ?: "{}"
        LukPlugin.callFlutter("onGameStateChangeState", params)
    }

    override fun onPlayerStateChangeState(uid: String, state: String, dataJson: String?) {
        val params: HashMap<String, Any> = HashMap()
        params["uid"] = uid
        params["state"] = state
        params["dataJson"] = dataJson ?: "{}"
        LukPlugin.callFlutter("onPlayerStateChangeState", params)
    }

    override fun onGamePurchaseResult(p0: Int, p1: String?) {
        L.info(TAG, "onGamePurchaseResult(),p0:$p0,p1:$p1")
        val params: HashMap<String, Any> = HashMap()
        params["code"] = p0
        params["orderId"] = p1 ?: ""
        LukPlugin.callFlutter("onGamePurchaseResult", params)
    }

    override fun onGameMusicStartPlay(musicId: Int, musicUrl: String, isLoop: Boolean): Int {
        val params: HashMap<String, Any> = HashMap()
        params["musicId"] = musicId
        params["musicUrl"] = musicUrl
        params["isLoop"] = isLoop
        LukPlugin.callFlutter("onGameMusicStartPlay", params)
        return 0
    }

    override fun onGameMusicStopPlay(musicId: Int): Int {
        val params: HashMap<String, Any> = HashMap()
        params["musicId"] = musicId
        LukPlugin.callFlutter("onGameMusicStopPlay", params)
        return 0
    }

    override fun onGameEffectSoundStartPlay(soundId: Int, soundUrl: String, isLoop: Boolean): Int {
        val params: HashMap<String, Any> = HashMap()
        params["soundId"] = soundId
        params["soundUrl"] = soundUrl
        params["isLoop"] = isLoop
        LukPlugin.callFlutter("onGameEffectSoundStartPlay", params)
        return 0
    }

    override fun onGameEffectSoundStopPlay(effectId: Int): Int {
        val params: HashMap<String, Any> = HashMap()
        params["effectId"] = effectId
        LukPlugin.callFlutter("onGameEffectSoundStopPlay", params)
        return 0
    }
}