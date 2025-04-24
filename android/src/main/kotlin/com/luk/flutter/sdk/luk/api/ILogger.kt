package com.luk.flutter.sdk.luk.api

interface ILogger {

    fun info(tag: String, msg: String)

    fun debug(tag: String, msg: String)

    fun error(tag: String, msg: String)

    fun warn(tag: String, msg: String)

}