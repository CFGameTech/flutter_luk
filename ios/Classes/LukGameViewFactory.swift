//
//  LukGameViewFactory.swift
//  Pods
//
//  Created by wys on 2025/4/21.
//

import UIKit
import Flutter
import CFGameSDK

public class LukGameViewFactory : NSObject, FlutterPlatformViewFactory {
    var registrarInstance : FlutterPluginRegistrar
    var lukGameView:LukGameView?
    var gameModel:CFGameModel?
    var roomId:String?
    var isRoomOwner:Bool = false
    var safeArea:CFGameEdgeInsets? = nil
   
   init(registrarInstance : FlutterPluginRegistrar) {
      self.registrarInstance = registrarInstance
      super.init()
   }
   
   public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
      return FlutterStandardMessageCodec.sharedInstance()
   }
   
   public func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
       let gameModel:CFGameModel = CFGameModel()
       var roomId:String = ""
       var isRoomOwner:Bool = false
       var left:CGFloat = 0
       var top:CGFloat = 0
       var right:CGFloat = 0
       var bottom:CGFloat = 0
       var minScaleLimit:CGFloat = 0
       if let params = args as? [String: Any] {
           gameModel.g_url = params["g_url"] as? String ?? ""
           gameModel.g_id =  params["g_id"] as? Int ?? 0
           gameModel.g_icon = params["g_icon"] as? String ?? ""
           roomId = params["roomId"] as? String ?? ""
           isRoomOwner = params["isRoomOwner"] as? Bool ?? false
           left =  params["left"] as? CGFloat ?? 0
           top =  params["top"] as? CGFloat ?? 0
           right =  params["right"] as? CGFloat ?? 0
           bottom =  params["bottom"] as? CGFloat ?? 0
           minScaleLimit =  params["minScaleLimit"] as? CGFloat ?? 0
       }
       
       if let m = self.gameModel, let v = lukGameView  {
           // 游戏没有变化
           if m.g_id == gameModel.g_id && m.g_url == gameModel.g_url && roomId == self.roomId {
               return v
           } else { //销毁已有的游戏实例重新创建
               CFGameSDK.finishGameWindow()
           }
       }
       if left > 0 || top > 0 || right > 0 || bottom > 0 || minScaleLimit > 0 {
           self.safeArea = CFGameEdgeInsets.init(top: top, left: left, bottom: bottom, right: right, minScaleLimit: minScaleLimit)
       } else {
           self.safeArea = nil
       }
       self.roomId = roomId
       self.isRoomOwner = isRoomOwner
       self.gameModel = gameModel
       let view = LukGameView(frame, viewId: viewId, gameModel: gameModel, registrarInstance: registrarInstance)
       lukGameView = view
      return view
   }
}

