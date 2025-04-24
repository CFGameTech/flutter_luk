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


typedef void(^GetGameListSuccessBlk)(NSArray<CFGameModel *> * __nonnull gameList);
typedef void(^GetGameListFailureBlk)(int code ,NSString * __nonnull msg);


@protocol CFGameSDKDelegate <NSObject>

@required



/**
 *
 * Returns：当前用户所在的房间号，如果没有互动玩法可直接返回空字符串
 */
- (NSString *_Nullable)onGetCurrentRoomId;
/**
 *
 * Returns：如果平台无需指定游戏管理员可直接返回false
 */
- (BOOL)onIsRoomOwner;
/**
 *
 * Returns：游戏视图的安全区域，若无要求可返回null
 */
- (CFGameEdgeInsets)onWindowSafeArea;

@optional

/**
    页面关闭回调
 */
- (void)onGamePageClose;

/**
 *
 * sdk回调渠道方，拉起渠道方的充值页面
 */
- (void)openChargePage;

/**
 *  游戏预加载成功返回游戏id
 */
- (void)onPreLoadGameSuccess:(NSInteger)gid gameState:(GameState)state;

/**
    设置统计上报回调
 */
- (void)reportStatsEvent:(NSString *_Nullable)event Code:(long)code Msg:(NSString *_Nullable)msg;

@end


@protocol CFGameSDKLoginDelegate <NSObject>

@required

/**
 *
 * 用户登录成功回调
 */
- (void)onLoginSuccess;

/**
 *
 * 用户登录失败回调
 */
- (void)onLoginFailCode:(int)code message:(NSString *__nonnull)msg;


@optional

/**
 *
 * token 更新后回调，接入方通常无需关注此接口
 */
- (void)onRefreshToken:(NSString *__nonnull)token;

@end

@protocol CFGameLifeCycleDelegate <NSObject>
@required

/**
 *
 * 游戏加载失败
 */
- (void)onGameLoadFail;

/**
    游戏加载完毕
 */
- (void)gameDidFinishLoad;

/**
 *
 * 用户自动上麦加入游戏
 */
- (BOOL)onPreJoinGame:(NSString *_Nonnull)uid seatIndex:(NSInteger)seatIndex;


/**
 *
 * 用户准备游戏
 */
- (void)onGamePrepare:(NSString *__nonnull)uid;

/**
 *
 * 用户取消准备
 */
- (void)onCancelPrepare:(NSString *__nonnull)uid;

/**
 *
 * 用户点击用户头像
 */
- (void)onSeatAvatarTouch:(NSString *__nonnull)uid seatIndex:(NSInteger)index;


/**
 *
 *  购买结果回调
 */
- (void)onGamePurchaseResult:(int)code OrderId:(NSString *__nonnull)orderId;


/**
 *
 *   音乐播放回调
 */
- (int)onGameMusicStartPlay:(int)musicId musicUrl:(NSString *__nonnull)musicUrl isLoop:(BOOL)isLoop;
/**
 *
 *   音乐停止播放回调
 */
- (int)onGameMusicStopPlay:(int)musicId;
/**
 *
 *   音效播放回调
 */
- (int)onGameEffectSoundStartPlay:(int)soundId soundUrl:(NSString *__nonnull)soundUrl isLoop:(BOOL)isLoop;
/**
 *
 *   音乐停止播放回调
 */
- (int)onGameEffectSoundStopPlay:(int)effectId;



/**
 *
 * 游戏结束
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
 * @param userId   用户id
 * @param state    状态码
 * @param dataJson 参数
 */
-(void)onPlayerStateChangeState:(NSString *_Nonnull)uid state:(NSString*_Nonnull)state dataJson:(NSString*_Nullable)dataJson;

@end


@protocol CFGameSDKRTCDelegate <NSObject>
@required


/**
    推自己的流
 */
- (BOOL)onCFGamePushSelfRTC:(BOOL)push;
/**
    拉取uid的流
 */
- (BOOL)onCFGamePullOtherRTC:(NSString *__nonnull)uid pull:(BOOL)pull;

@end




NS_ASSUME_NONNULL_BEGIN

@interface CFGameSDK : NSObject
/**
    sdk日志打印接口
    logMsg : 日志msg
 
 */

+ (void)cfGameSDKLog:(void(^)(NSString *logMsg))handler;


/*
 *  @param app : UIApplication 当前application
 *  @param appId : 创发提供的appId
 *  @param appKey : 创发提供的appKey
 */
+(void)setUpSDKWithApplication:(UIApplication *)app appId:(NSString *)appId language:(NSString *)language area:(NSString *)area isProduct:(BOOL)isProduct;


/*
 *  @param userId : 接入方的用户id
 *  @param userCode : 接入方的用户code,用于创发向接入方校验用户的合法性
 */
+(void)setUserInfo:(NSString *)userId code:(NSString *)userCode loginCallBack:(id<CFGameSDKLoginDelegate>)loginCallBack;


/*
 *  拉起游戏列表弹窗
 */
+(void)showGameList;

/*
 *  获取游戏列表
 */
+(void)getGameListWithSuccess:(GetGameListSuccessBlk)successBlk failure:(GetGameListFailureBlk)failBlk;


/**
    游戏预加载
 */
+(void)preloadGameWithList:(NSArray<NSNumber *> *)arr;


/**
    游戏预加载加载取消
 */
+(void)cancelPreloadGame:(NSArray<NSNumber *> *)arr;

/*
 *  加载半屏游戏
 *  @param gameId : 游戏id
 *  @url   url : 游戏url
 */
+(void)loadHalfWindowGame:(NSString *)gameId url:(NSString *)url;

/*
 *  加载全屏游戏
 *  @param gameId : 游戏id
 *  @url   url : 游戏url
 */
+(void)loadFullWindowGame:(NSString *)gameId url:(NSString *)url;


/*
 *  获取返回一个带有webview游戏页面的ViewController 用于自定义展示
 */
+(UIViewController *)createGameWebViewWithUrl:(NSString *)gameUrl gameId:(int)gameId size:(CGSize)size;




/*
    上报透传参数 extString : 透传参数 (传字符串类型，内容由平台自定义)
 
 */

+(void)sentExtToGame:(NSString *)extString;

/**
    是否显示关闭按钮
 */
+(void)showCloseButton:(BOOL)isShow;



/*
 *  销毁游戏窗口
 */
+(void)finishGameWindow;

/*
 *  强制结束游戏
 */
+(void)terminateGame;

/*
 *  加入当前游戏
 *  @param position : 位置
 */
+(void)joinGame:(NSInteger)position;

/*
 *  通过js通知游戏刷新用户资产信息
 */
+(void)refreshUserInfo;

/*
 *  开始游戏
 */
+(void)gameStart;

/*
 *  退出游戏
 */
+(void)quitGame;



/*
 *  设置游戏声音文件路径
 */
+ (void)setGameVoicePath:(NSString *)path;

/**
    踢人
 @param uid 用户id
 */

+(void)playerRemoveWithUid:(NSString *)uid;

/**
    打开/关闭 背景音乐
    @param mode  YES 开 NO 关
 */
+(void)gameBackgroundMusicSet:(BOOL)mode;

/**
    打开/关闭音效
 @param mode YES 开 NO 关
 */
+(void)gameSoundSet:(BOOL)mode;

/*
*  设置玩家角色
*  @param role 房主传 1 非房主0
*/
+ (void)setPlayerRole:(NSInteger)role;


/**
    获取日志路径
 */
+ (NSString *)getLogFilePath;


/**
    语言设置
 */
+ (void)setLanguage:(NSString *)language;

/**
    暂停游戏
 */
+ (void)gamePause;

/**
    继续游戏，用于结束暂停游戏状态
 */
+ (void)gamePlay;

/**
    重新加载游戏
 */
+ (void)gameReload;



/**
    APP 发送命令到游戏端
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


@end

NS_ASSUME_NONNULL_END
