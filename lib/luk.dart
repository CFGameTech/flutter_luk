import 'package:luk/api/i_game_biz_callback.dart';
import 'package:luk/api/i_game_life_callback.dart';
import 'package:luk/api/i_game_logger.dart';
import 'package:luk/api/i_login_callback.dart';
import 'package:luk/api/i_game_rtc_callback.dart';
import 'package:luk/api/i_preload_game_callback.dart';
import 'package:luk/api/i_report_stats_event_callback.dart';

import 'package:luk/bean/game_info.dart';

import 'luk_platform_interface.dart';

class Luk {
  const Luk._();

  static const instance = Luk._();

  /// 设置游戏业务回调
  void setGameBizCallback(IGameBizCallback callback) {
    LukPlatform.instance.setGameBizCallback(callback);
  }

  /// 游戏生命周期回调
  void setGameLifeCallback(IGameLifeCallback callback) {
    LukPlatform.instance.setGameLifeCallback(callback);
  }

  /// 设置sdk日志输出器
  void setGameLogger(IGameLogger logger) {
    LukPlatform.instance.setGameLogger(logger);
  }

  /// 登录回调
  void setLoginCallback(ILoginCallback callback) {
    LukPlatform.instance.setLoginCallback(callback);
  }

  /// RTC回调
  void setRTCCallback(IGameRTCCallback callback){
    LukPlatform.instance.setRTCCallback(callback);
  }


  /// sdk初始化
  Future setupSdk({required int appId, required String language, required String area, required bool isProduct}) {
    return LukPlatform.instance.setupSdk(appId: appId, language: language, area: area, isProduct: isProduct);
  }

  /// 设置用户信息（登录）
  Future<bool> setUserInfo({required String uid, required String verifyCode}) {
    return LukPlatform.instance.setUserInfo(uid: uid, verifyCode: verifyCode);
  }

  /// 加载游戏列表
  Future<List<GameInfo>> getGameList() async {
    return LukPlatform.instance.getGameList();
  }

  /// 游戏切换到后台
  void onPause() {
    LukPlatform.instance.onPause();
  }

  /// 游戏回到前台
  void onResume() {
    LukPlatform.instance.onResume();
  }

  /// 销毁游戏视图
  void onDestroy() {
    LukPlatform.instance.onDestroy();
  }

  /// 刷新用户信息
  void refreshUserInfo() {
    LukPlatform.instance.refreshUserInfo();
  }

  /// 开始游戏（接入方可在游戏准备阶段通过调用此接口开始游戏）
  void gameStart() {
    LukPlatform.instance.gameStart();
  }

  /// 接入方可在游戏准备阶段通过调用此接口将玩家从游戏踢出。
  void playerRemoveWithUid(String uid) {
    LukPlatform.instance.playerRemoveWithUid(uid);
  }

  /// 接入方可在游戏准备阶段通过调用此接口将玩家从游戏踢出。
  /// [mode] true:关闭背景音乐 false:打开背景音乐
  void gameBackgroundMusicSet(bool mode) {
    LukPlatform.instance.gameBackgroundMusicSet(mode);
  }

  /// 接入方可通过调用此接口关闭游戏音效。
  /// [mode] true:关闭音效 false:打开音效
  void gameSoundSet(bool mode) {
    LukPlatform.instance.gameSoundSet(mode);
  }

  /// 接入方可通过调用终止游戏，强制停止当前游戏，一般在房主销毁游戏房使用。
  void terminateGame() {
    LukPlatform.instance.terminateGame();
  }

  /// 接入方可在游戏准备阶段通过调用此接口加入游戏。
  /// [position] 加入游戏的位置，0 随机加入 大于 0 即为指定位置
  void joinGame(int position) {
    LukPlatform.instance.joinGame(position);
  }

  /// 接入方可通过调用退出游戏,用户退出游戏时使用，不会销毁房间，仅退出当前用户。
  void quitGame() {
    LukPlatform.instance.quitGame();
  }

  /// 接入方可以调该方法改变玩家角色。
  /// [role] 玩家角色 1 为房主，0 为普通玩家
  void setPlayerRole(int role) {
    LukPlatform.instance.setPlayerRole(role);
  }

  /// 接入方可通过调用该方法暂停游戏，只适用于可以暂停的游戏(注意和onPause方法要区分清楚)。
  void pauseGame() {
    LukPlatform.instance.pauseGame();
  }

  /// 接入方可通过调用该方法继续游戏，用于结束暂停游戏状态。跟gameStart()方法有区别，注意区分
  void playGame() {
    LukPlatform.instance.playGame();
  }

  /// 预加载游戏。
  /// [gameIdList]需要预加载的游戏id列表
  /// 加载的结果将通过IPreloadGameCallback回调
  void preloadGameList(List<int> gameIdList) {
    LukPlatform.instance.preloadGameList(gameIdList);
  }

  /// 设置预加载游戏结果回调
  void setPreloadGameCallback(IPreloadGameCallback callback) {
    LukPlatform.instance.setPreloadGameCallback(callback);
  }

  /// 取消预加载。
  /// [gameIdList]需要取消预加载的游戏id列表
  void cancelPreloadGame(List<int> gameIdList) {
    LukPlatform.instance.cancelPreloadGame(gameIdList);
  }

  /// 释放 LUK SDK 的所有资源。
  void releaseSDK() {
    LukPlatform.instance.releaseSDK();
  }

  /// 透传参数上报。（需要在拉起游戏前传入）
  void sentExtToGame(String ext) {
    LukPlatform.instance.sentExtToGame(ext);
  }

  /// 接入方可以调该方法显示游戏关闭按钮，点击该按钮后将通过onGamePageClose回调通知到接入方，需要再拉起游戏前调用
  /// [isShow] ture 显示，false 不显示
  void showCloseButton(bool isShow) {
    LukPlatform.instance.showCloseButton(isShow);
  }

  /// 接入方可以调该方法修改游戏显示语言，需要在拉起游戏前调用
  /// [language] 语言代码，具体可参照【多语言代码表】
  void setLanguage(String language) {
    LukPlatform.instance.setLanguage(language);
  }

  /// 接入方可以调该方法重新加载游戏
  void gameReload() {
    LukPlatform.instance.gameReload();
  }

  /// 接入方可以调该方法获取网络请求状态
  void setReportStatsEventListener(IReportStatsEventCallback callback) {
    LukPlatform.instance.setReportStatsEventListener(callback);
  }

  /// 通过调用该接口，传入存放游戏音效的服务器地址
  void setGameVoicePath(String path) {
    LukPlatform.instance.setGameVoicePath(path);
  }

  /// SDK发送指令到游戏。关于state字段SDK内部已经定义好字符串常量，在CFGameSDKState类中
  /// 参考：https://wiki.luk.live/docs/client-api/app_notify
  void appNotifyStateChange(String state, String dataJson) {
    LukPlatform.instance.appNotifyStateChange(state, dataJson);
  }
}
