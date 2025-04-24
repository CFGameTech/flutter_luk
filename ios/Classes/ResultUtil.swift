//
//  ResultUtil.swift
//  Pods
//
//  Created by wys on 2025/4/22.
//

class ResultUtil:NSObject {
    
    public static func buildResult(code:Int32,msg:String,data:Any?) -> [String: Any]{
        var map: [String: Any] = ["code": code, "msg": msg]
        if let d = data {
            map["data"] = d
        }
        return map
    }
    
}
