//
//  CFGameView.swift
//  Pods
//
//  Created by wys on 2025/4/21.
//

import UIKit
import Flutter
import CFGameSDK

public class LukGameView : NSObject, FlutterPlatformView {
    
    let cfgView:UIView
    var uiViewController:UIViewController
    
    init(_ frame: CGRect, viewId: Int64, gameModel: CFGameModel, userId: String, userCode: String, registrarInstance : FlutterPluginRegistrar) {

        uiViewController = UIViewController()
        cfgView = UIView(frame:frame)
        super.init()

        CFGameSDK.createGameWebView(withGameId: Int32(gameModel.g_id), url: gameModel.g_url, size: frame.size, userId:userId, userCode:userCode) { [weak self] vc in
             guard let self = self else { return }

            self.uiViewController = vc
            cfgView.addSubview(vc.view)
            print("createGameWebView success")
        }  onFailure: { [weak self]  (code, msg) in
            // 失败处理
            print("createGameWebView fail code:\(code),msg:\(msg)")
//            result(FlutterError(code: "\(code)", message: msg, details: nil))


        }

//        cfgView = uiViewController.view
//        super.init()
    }
    
    public func view() -> UIView {
       return cfgView
    }
    
}
