//
//  CFGameSDK.h
//  CFGameSDK
//
//  Created by YQ_Mac on 2024/9/5.
//


#import <CFGameSDK/CFGameModel.h>
#import <UIKit/UIKit.h>
#import <CFGameSDK/CFGameSDKStateDefines.h>


typedef struct {
    CGFloat top;
    CGFloat left;
    CGFloat bottom;
    CGFloat right;
    CGFloat minScaleLimit;
} CFGameEdgeInsets;

typedef enum : NSUInteger {
    GameDownloadingComplete = 1,
    GameAlreadyExist = 2,
} GameState;


typedef void(^GetGameListSuccessBlock)(NSArray<CFGameModel *> * __nonnull gameList);
typedef void(^GetGameAudioListBlock)(NSArray<CFGameAudioInfo *> * _Nullable audioList);
typedef void(^SDKOnFailureBlock)(int code ,NSString * __nonnull msg);
typedef void(^SDKOnSuccessBlock)(void);

@protocol CFGameSDKDelegate <NSObject>
@required

/**
 *  房间id设置接口
 *  return 当前用户所在的房间号，如果没有互动玩法可直接返回空字符串
 */
- (NSString *_Nullable)onGetCurrentRoomId;


/**
 *  是否房主设置接口
 *  return 如果平台无需指定游戏管理员可直接返回false
 */
- (BOOL)onIsRoomOwner;


/**
 *  游戏安全区设置接口
 *  return 游戏视图的安全区域 (参数详情查看结构体CFGameEdgeInsets)
 */
- (CFGameEdgeInsets)onWindowSafeArea;


/**
 *  游戏参数配置接口
 *  @param dataJson 游戏返回的游戏参数字段（json格式）
 *  @return 需要设置的游戏参数字段（json格式）
 */
- (NSString *_Nullable)onGetGameConfig:(NSString *_Nullable)dataJson;


/**
 *  页面关闭回调（游戏通知app需要关闭游戏界面）
 */
- (void)onGamePageClose;


/**
 *  拉起渠道方的充值页面回调
 */
- (void)openChargePage;


/**
 *   打开平台页面回调
 *   @param path 路径
 *   @param data 参数
 */
- (void)openPlatformPage:(NSString *_Nonnull)path data:(NSString *_Nullable)data;


/**
 *  游戏预加载成功返回游戏id
 *  @param gid 加载完成的游戏id
 *  @param state 完成状态
 */
- (void)onPreLoadGameSuccess:(NSInteger)gid gameState:(GameState)state;


/**
 *  设置统计上报回调
 */
- (void)reportStatsEvent:(NSString *_Nullable)event Code:(long)code Msg:(NSString *_Nullable)msg;

@end


@protocol CFGameLifeCycleDelegate <NSObject>
@required


/**
 *  游戏加载失败
 */
- (void)onGameLoadFail;


/**
 *  游戏加载完毕
 */
- (void)gameDidFinishLoad;


/**
 *  用户自动上麦加入游戏
 *  @param uid 用户id
 *  @param seatIndex 座位号
 *  @return 是否允许上麦
 */
- (BOOL)onPreJoinGame:(NSString *_Nonnull)uid seatIndex:(NSInteger)seatIndex;


/**
 *  用户是否允许开始游戏
 *  @param uid 用户id
 *  @return 是否允许开始游戏
 */
- (BOOL)onCanStartGame:(NSString *_Nonnull)uid;


/**
 *  用户准备游戏
 *  @param uid 用户id
 */
- (void)onGamePrepare:(NSString *__nonnull)uid;


/**
 *  用户取消准备
 *  @param uid 用户id
 */
- (void)onCancelPrepare:(NSString *__nonnull)uid;


/**
 *  用户点击用户头像
 *  @param uid 被点击的用户id
 *  @param index 被点击用户的座位号
 */
- (void)onSeatAvatarTouch:(NSString *__nonnull)uid seatIndex:(NSInteger)index;


/**
 *  购买结果回调
 *  @param code 状态码
 *  @param orderId 订单id
 */
- (void)onGamePurchaseResult:(int)code OrderId:(NSString *__nonnull)orderId;


/**
 *  音乐播放回调
 *  @param musicId 音乐id
 *  @param musicUrl 音乐路径
 *  @param isLoop 是否循环
 *  @return 是否成功
 */
- (int)onGameMusicStartPlay:(int)musicId musicUrl:(NSString *__nonnull)musicUrl isLoop:(BOOL)isLoop;


/**
 *  音乐停止播放回调
 *  @param musicId 停止播放的音乐id
 *  @return 是否成功
 */
- (int)onGameMusicStopPlay:(int)musicId;


/**
 *  音效播放回调
 */
- (int)onGameEffectSoundStartPlay:(int)soundId soundUrl:(NSString *__nonnull)soundUrl isLoop:(BOOL)isLoop;


/**
 *  音乐停止播放回调
 *  @param effectId 音效id
 */
- (int)onGameEffectSoundStopPlay:(int)effectId;


/**
 *
 * 游戏结束回调
 */
- (void)onGameOver;


/**
 * 游戏状态变化
 * @param state     状态码
 * @param dataJson  参数
 */
-(void)onGameStateChangeState:(NSString *_Nonnull)state dataJson:(NSString *_Nullable)dataJson;


/**
 * 游戏玩家状态变化
 * @param uid   用户id
 * @param state    状态码
 * @param dataJson 参数
 */
-(void)onPlayerStateChangeState:(NSString *_Nonnull)uid state:(NSString*_Nonnull)state dataJson:(NSString*_Nullable)dataJson;


/**
 *  游戏截图回调
 *
 */
- (void)onGameScreenShotBaseData:(NSString *_Nullable)base64String dataJson:(NSString *_Nullable)dataJson;


@end


@protocol CFGameSDKRTCDelegate <NSObject>
@required


/**
 *   推自己的流
 */
- (BOOL)onCFGamePushSelfRTC:(BOOL)push;


/**
 *  拉取uid的流
 */
- (BOOL)onCFGamePullOtherRTC:(NSString *__nonnull)uid pull:(BOOL)pull;

@end




NS_ASSUME_NONNULL_BEGIN

@interface CFGameSDK : NSObject


/**
 *   sdk日志打印接口
 *   logMsg : 日志msg
 */
+ (void)cfGameSDKLog:(void(^)(NSString *logMsg))handler;


/**
 *  sdk初始化方法
 *  @param model 初始化model，详细参数查看CFGameInitSDKModel
 */
+(void)setUpSDKWithModel:(CFGameInitSDKModel *)model onSuccess:(SDKOnSuccessBlock)success onFailure:(SDKOnFailureBlock)failure;


/**
 *  获取游戏列表
 */
+(void)getGameListWithSuccess:(GetGameListSuccessBlock)success failure:(SDKOnFailureBlock)failure;


/**
 *   游戏预加载
 */
+(void)preloadGameWithList:(NSArray<NSNumber *> *)arr;


/**
 * 游戏预加载加载取消
 */
+(void)cancelPreloadGame:(NSArray<NSNumber *> *)arr;


/**
 *  获取游戏音频列表
 *  @param gid 游戏id
 */
+(void)getGameAudioList:(int)gid onSuccess:(GetGameAudioListBlock)success onFailure:(SDKOnFailureBlock)failure;


/**
 *  拉起游戏列表弹窗
 *  @param userId 用户id
 *  @param code 用户code
 */
+(void)showGameListDialog:(UIViewController *)vc userId:(NSString *)userId userCode:(NSString *)code onSuccess:(SDKOnSuccessBlock)success onFailure:(SDKOnFailureBlock)failure;


/**
 *  加载半屏游戏
 *  @param gameId : 游戏id
 *  @param url : 游戏url
 *  @param userId 用户id
 *  @param code 用户code
 */
+(void)startHalfWindowGame:(UIViewController *)vc gameId:(int)gameId url:(NSString *)url userId:(NSString *)userId userCode:(NSString *)code onSuccess:(SDKOnSuccessBlock)success onFailure:(SDKOnFailureBlock)failure;


/**
 *  加载全屏游戏
 *  @param gameId : 游戏id
 *  @param url : 游戏url

 */
+(void)startFullWindowGame:(UIViewController *)vc gameId:(int)gameId url:(NSString *)url userId:(NSString *)userId userCode:(NSString *)code onSuccess:(SDKOnSuccessBlock)success onFailure:(SDKOnFailureBlock)failure;


/**
 *  获取返回一个带有webview游戏页面的ViewController 用于自定义展示
 *  @param gameId : 游戏id
 *  @param url : 游戏url
 *  @param userId 用户id
 *  @param code 用户code
 */
+(void)createGameWebViewWithGameId:(int)gameId url:(NSString *)url size:(CGSize)size userId:(NSString *)userId userCode:(NSString *)code onSuccess:(void(^)(UIViewController *vc))success onFailure:(SDKOnFailureBlock)failure;


/**
 *  更新用户code
 *  @param code 用户code
 */
+ (void)updateUserCode:(NSString *)code onSuccess:(SDKOnSuccessBlock)success onFailure:(SDKOnFailureBlock)failure;



/**
 *   上报透传参数
 *   @param extString : 透传参数 (传字符串类型，内容由平台自定义)
 */

+(void)sentExtToGame:(NSString *)extString;


/**
 *   是否显示关闭按钮
 */
+(void)showCloseButton:(BOOL)isShow;


/**
 *  销毁游戏窗口
 */
+(void)finishGameWindow;


/**
 *  强制结束游戏
 */
+(void)terminateGame;


/**
 *  加入当前游戏
 *  @param position : 位置
 */
+(void)joinGame:(NSInteger)position;


/**
 *  通过js通知游戏刷新用户资产信息
 */
+(void)refreshUserInfo;


/**
 *  开始游戏
 */
+(void)gameStart;


/**
 *  退出游戏
 */
+(void)quitGame;


/**
 *  踢人
 *  @param uid 被踢用户id
 */
+(void)playerRemoveWithUid:(NSString *)uid;


/**
 *  打开/关闭 背景音乐
 *  @param mode  YES 开 NO 关
 */
+(void)gameBackgroundMusicSet:(BOOL)mode;


/**
 *  打开/关闭音效
 *  @param mode YES 开 NO 关
 */
+(void)gameSoundSet:(BOOL)mode;


/**
 *  设置玩家角色
 *  @param role 房主传 1 非房主0
 */
+ (void)setPlayerRole:(NSInteger)role;


/**
 *  获取日志路径
 *  @return 日志存放路径
 */
+ (NSString *)getLogFilePath;


/**
 *  语言设置
 *  @param language 语言代码
 */
+ (void)setLanguage:(NSString *)language;

/**
 *  暂停游戏
 */
+ (void)gamePause;

/**
 *  继续游戏，用于结束暂停游戏状态
 */
+ (void)gamePlay;

/**
 *  重新加载游戏
 */
+ (void)gameReload;



/**
 *  APP 发送命令到游戏端
 *  @param state 指令
 *  @param dataJson 参数
 */

+ (void)appNotifyStateChange:(const NSString *)state dataJson:(NSString *)dataJson;



/*
 *  设置接入方回调
 */
+(void)setBizCallback:(id<CFGameSDKDelegate>)callback;


/*
 *  设置CFGame LifeCycle回调
 */
+(void)setCFGameLifecycleCallback:(id<CFGameLifeCycleDelegate>)callback;


/*
 *  设置RTC回调
 */
+(void)setRTCCallback:(id<CFGameSDKRTCDelegate>)callback;



/*
 * 释放sdk
 */
+(void)releaseSDK;


/*
 * 获取当前版本号
 */
+ (NSString *)sdkVersion;


/*
 *   是否允许SDK控制Category
 */
- (void)setEnableAudioSessionCategory:(BOOL)enable;


/*
 *  是否允许SDK控制Session
 */
- (void)setEnableAudioSessionActive:(BOOL)enable;

@end

NS_ASSUME_NONNULL_END
