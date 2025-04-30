import 'package:luk/api/i_game_biz_callback.dart';
import 'package:luk/api/i_game_life_callback.dart';
import 'package:luk/api/i_game_logger.dart';
import 'package:luk/api/i_login_callback.dart';
import 'package:luk/api/i_game_rtc_callback.dart';
import 'package:luk/bean/game_info.dart';
import 'package:luk/api/i_preload_game_callback.dart';


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

}
