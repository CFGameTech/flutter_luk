package com.luk.flutter.sdk.luk.api

import com.cftech.gamelibrary.CFGameSDK
import com.cftech.gamelibrary.CFGameSDK.ICFBizCallback
import com.luk.flutter.sdk.luk.LukPlatformViewFactory
import com.luk.flutter.sdk.luk.util.L
import com.luk.flutter.sdk.luk.LukPlugin

object CFBizCallback : ICFBizCallback {

    private const val TAG = "CFBizCallback"

    override fun onOpenChargePage() {
        L.info(TAG, "onOpenChargePage()")
        LukPlugin.callFlutter("onOpenChargePage")
    }

    override fun onGetCurrentRoomId(): String {
        val roomId = LukPlatformViewFactory.getCreationRoomId()
        L.info(TAG, "onGetCurrentRoomId(),roomId:$roomId")
        return roomId
    }

    override fun onIsRoomOwner(): Boolean {
        val isRoomOwner = LukPlatformViewFactory.isCreationRoomOwner()
        L.info(TAG, "onIsRoomOwner(),isRoomOwner:$isRoomOwner")
        return isRoomOwner
    }

    override fun onWindowSafeArea(): CFGameSDK.CFRect {
        val safeArea = LukPlatformViewFactory.getWindowSafeArea()
        L.info(
            TAG,
            "onWindowSafeArea(),left:${safeArea.left},top:${safeArea.top},right:${safeArea.right},bottom:${safeArea.bottom},scaleMinLimit:${safeArea.scaleMinLimit}"
        )
        return safeArea
    }

    override fun onGamePageClose() {
        L.info(TAG, "onGamePageClose()")
        LukPlugin.callFlutter("onGamePageClose")

    }

    override fun onOpenShopPage(p0: String){
        L.info(TAG,"onOpenShopPage")
    }
}