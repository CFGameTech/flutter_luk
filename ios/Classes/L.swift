//
//  L.swift
//  Pods
//
//  Created by wys on 2025/4/25.
//

public class L {
    
    public static func info(tag:String, msg:String){
        let map: [String: Any] = ["tag":"LUK:\(tag)", "msg": msg]
        SwiftLukPlugin.channel?.invokeMethod("onInfo", arguments: map)
    }
    
    public static func debug(tag:String, msg:String){
        let map: [String: Any] = ["tag":"LUK:\(tag)", "msg": msg]
        SwiftLukPlugin.channel?.invokeMethod("onDebug", arguments: map)
    }
    
    public static func warn(tag:String, msg:String){
        let map: [String: Any] = ["tag":"LUK:\(tag)", "msg": msg]
        SwiftLukPlugin.channel?.invokeMethod("onWarn", arguments: map)
    }
    
    public static func error(tag:String, msg:String){
        let map: [String: Any] = ["tag":"LUK:\(tag)", "msg": msg]
        SwiftLukPlugin.channel?.invokeMethod("onError", arguments: map)
    }
    
}
