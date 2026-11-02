//
//  CFGameModel.h
//  Tofee
//
//  Created by mac on 2023/7/9.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CFGameModel : NSObject

// 游戏id
@property (nonatomic,assign) int g_id;
// 游戏名称
@property (nonatomic,copy) NSString *g_name;
// 游戏icon
@property (nonatomic,copy) NSString *g_icon;
// 游戏地址
@property (nonatomic,copy) NSString *g_url;

@end


@interface CFGameAudioInfo : NSObject

// 音频路径
@property (nonatomic,copy) NSString *url;
// 音频名称
@property (nonatomic,copy) NSString *name;
// 音频格式
@property (nonatomic,copy) NSString *type;



@end




@interface CFGameInitSDKModel : NSObject

//  当前application
@property (nonatomic, nonnull) UIApplication *app;
//  appId
@property (nonatomic, assign) int appId;
//  appKey
@property (nonatomic, copy, nonnull) NSString *appKey;
//  游戏语言
@property (nonatomic,copy,nonnull) NSString *language;
//  发布地区
@property (nonatomic,copy,nonnull) NSString *area;
//  是否正式环境
@property (nonatomic,assign) BOOL isProduct;
//  是否需要播放游戏声音
@property (nonatomic,assign) BOOL isGameSoundPlay;



@end



NS_ASSUME_NONNULL_END
