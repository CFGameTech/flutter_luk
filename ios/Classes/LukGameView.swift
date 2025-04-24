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
    let uiViewController:UIViewController
    
    init(_ frame: CGRect, viewId: Int64, gameModel: CFGameModel, registrarInstance : FlutterPluginRegistrar) {
        uiViewController = CFGameSDK.createGameWebView(withUrl: gameModel.g_url, gameId: Int32(gameModel.g_id), size: frame.size)
        cfgView = uiViewController.view
       super.init()
    }
    
    public func view() -> UIView {
       return cfgView
    }
    
}
