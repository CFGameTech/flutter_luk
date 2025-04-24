//
//  CFGameSDKStateDefines.h
//  CFGameSDK
//
//  Created by YQ_Mac on 2025/2/13.
//

#ifndef CFGameSDKStateDefines_h
#define CFGameSDKStateDefines_h

#pragma mark - 游戏控制指令
//  测试
static NSString *cf_app_call_hello = @"cf_app_call_hello";
//  加入状态
static NSString *cf_app_call_join = @"cf_app_call_join";
//  准备状态
static NSString *cf_app_call_ready = @"cf_app_call_ready";
//  游戏状态
static NSString *cf_app_call_playing = @"cf_app_call_playing";
//  设置房主
static NSString *cf_app_call_set_owner = @"cf_app_call_set_owner";
//  踢人
static NSString *cf_app_call_kick = @"cf_app_call_kick";
//  设置游戏的音量
static NSString *cf_app_call_set_volume = @"cf_app_call_set_volume";
//  通知游戏重连
static NSString *cf_app_call_reconnect = @"cf_app_call_reconnect";
//  获取当前游戏状态
static NSString *cf_app_call_get_game_state = @"cf_app_call_get_game_state";
//  获取玩家当前状态
static NSString *cf_app_call_get_player_state = @"cf_app_call_get_player_state";
//  替换货币图标
static NSString *cf_app_call_change_money_icon = @"cf_app_call_change_money_icon";



#pragma mark - 游戏状态上报
//  测试状态
static NSString *cf_game_call_hello = @"cf_game_call_hello";
//  公屏消息
static NSString *cf_game_call_game_public_message = @"cf_game_call_game_public_message";
//  游戏结算状态
static NSString *cf_game_call_game_settle = @"cf_game_call_game_settle";
//  加入游戏按钮点击状态
static NSString *cf_game_call_game_click_join_btn = @"cf_game_call_game_click_join_btn";
//  取消加入（退出）游戏状态
static NSString *cf_game_call_game_click_cancel_join_btn = @"cf_game_call_game_click_cancel_join_btn";
//  准备按钮点击状态
static NSString *cf_game_call_game_click_ready_btn = @"cf_game_call_game_click_ready_btn";
//  准备按钮点击取消状态
static NSString *cf_game_call_game_click_cancel_ready_btn = @"cf_game_call_game_click_cancel_ready_btn";
//  开始游戏按钮点击状态
static NSString *cf_game_call_game_click_start_btn = @"cf_game_call_game_click_start_btn";
//  游戏状态
static NSString *cf_game_call_game_state = @"cf_game_call_game_state";
//  结算界面关闭按钮点击状态
static NSString *cf_game_call_game_click_game_settle_close_btn = @"cf_game_call_game_click_game_settle_close_btn";
//  结算界面再来一局按钮点击状态
static NSString *cf_game_call_game_click_game_settle_again_btn = @"cf_game_call_game_click_game_settle_again_btn";
//  游戏重连三次失败后回调给SDK
static NSString *cf_game_call_game_disconnect = @"cf_game_call_game_disconnect";
//  帮助按钮点击状态
static NSString *cf_game_call_game_click_help_btn = @"cf_game_call_game_click_help_btn";


#pragma mark - 玩家状态上报
//  加入状态
static NSString *cf_game_call_player_in = @"cf_game_call_player_in";
//  准备状态
static NSString *cf_game_call_player_ready = @"cf_game_call_player_ready";
//  玩家游戏状态
static NSString *cf_game_call_player_state = @"cf_game_call_player_state";
//  游戏通知app点击玩家头像
static NSString *cf_game_call_player_click_game_player_icon = @"cf_game_call_player_click_game_player_icon";



#endif
