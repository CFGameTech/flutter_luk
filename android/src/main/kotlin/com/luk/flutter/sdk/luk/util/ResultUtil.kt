package com.luk.flutter.sdk.luk.util


object ResultUtil {

    fun buildResult(
        code: Int,
        msg: String,
        data: HashMap<String, Any> = java.util.HashMap()
    ): HashMap<String, Any> {
        val result = HashMap<String, Any>()
        result["code"] = code
        result["msg"] = msg
        result["data"] = data
        return result
    }

}