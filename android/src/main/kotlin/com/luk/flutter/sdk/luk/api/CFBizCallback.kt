package com.luk.flutter.sdk.luk.api

import com.cftech.gamelibrary.CFGameSDK
import com.cftech.gamelibrary.CFGameSDK.ICFBizCallback
import com.luk.flutter.sdk.luk.LukPlatformViewFactory
import com.luk.flutter.sdk.luk.util.L

object CFBizCallback : ICFBizCallback {

    private const val TAG = "CFBizCallback"

    override fun onOpenChargePage() {
        L.info(TAG, "onOpenChargePage()")
    }

    override fun onGetCurrentRoomId(): String {
        return LukPlatformViewFactory.getCreationRoomId()
    }

    override fun onIsRoomOwner(): Boolean {
        return LukPlatformViewFactory.isCreationRoomOwner()
    }

    override fun onWindowSafeArea(): CFGameSDK.CFRect {
        L.info(TAG, "onWindowSafeArea()")
        return LukPlatformViewFactory.getWindowSafeArea()
    }

    override fun onGamePageClose() {
        L.info(TAG, "onOpenChargePage()")
    }
}