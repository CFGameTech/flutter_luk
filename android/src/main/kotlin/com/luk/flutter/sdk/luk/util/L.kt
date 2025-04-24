package com.luk.flutter.sdk.luk.util

import com.luk.flutter.sdk.luk.api.ILogger

object L : ILogger {
    override fun info(tag: String, msg: String) {
        android.util.Log.i(tag, msg)
    }

    override fun debug(tag: String, msg: String) {
        android.util.Log.d(tag, msg)
    }

    override fun error(tag: String, msg: String) {

    }

    override fun warn(tag: String, msg: String) {

    }

}