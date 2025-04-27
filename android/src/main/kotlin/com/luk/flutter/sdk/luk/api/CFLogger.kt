package com.luk.flutter.sdk.luk.api

import com.cftech.gamelibrary.CFGameSDK
import com.luk.flutter.sdk.luk.util.L

object CFLogger : CFGameSDK.ICFLogger {
    override fun onDebug(p0: String?, p1: String?) {
        if (p0 != null && p1 != null) {
            L.debug(p0, p1)
        }
    }

    override fun onInfo(p0: String?, p1: String?) {
        if (p0 != null && p1 != null) {
            L.info(p0, p1)
        }
    }

    override fun onWarn(p0: String?, p1: String?) {
        if (p0 != null && p1 != null) {
            L.warn(p0, p1)
        }
    }

    override fun onError(p0: String?, p1: String?) {
        if (p0 != null && p1 != null) {
            L.error(p0, p1)
        }
    }
}