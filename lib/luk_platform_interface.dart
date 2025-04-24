import 'package:luk/api/i_game_biz_callback.dart';
import 'package:luk/api/i_game_life_callback.dart';
import 'package:luk/api/i_game_logger.dart';
import 'package:luk/api/i_login_callback.dart';
import 'package:luk/bean/game_info.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'luk_method_channel.dart';

abstract class LukPlatform extends PlatformInterface {
  LukPlatform() : super(token: _token);

  static final Object _token = Object();

  static LukPlatform _instance = MethodChannelLuk();

  static LukPlatform get instance => _instance;

  static set instance(LukPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future setupSdk({required int appId, required String language, required String area, required bool isProduct}) {
    throw UnimplementedError('setupSdk() has not been implemented.');
  }

  Future<bool> setUserInfo({required String uid, required String verifyCode}) {
    throw UnimplementedError('setUserInfo() has not been implemented.');
  }

  Future<List<GameInfo>> getGameList() {
    throw UnimplementedError('getGameList() has not been implemented.');
  }

  void loadGame({required int gameId, required String url}) {
    throw UnimplementedError('loadGame() has not been implemented.');
  }

  void onPause() {
    throw UnimplementedError('onPause() has not been implemented.');
  }

  void onResume() {
    throw UnimplementedError('onResume() has not been implemented.');
  }

  void onDestroy() {
    throw UnimplementedError('onDestroy() has not been implemented.');
  }

  void setGameBizCallback(IGameBizCallback callback) {
    throw UnimplementedError('setGameBizCallback() has not been implemented.');
  }

  void setGameLifeCallback(IGameLifeCallback callback) {
    throw UnimplementedError('setGameLifeCallback() has not been implemented.');
  }

  void setGameLogger(IGameLogger logger) {
    throw UnimplementedError('setGameLogger() has not been implemented.');
  }

  void setLoginCallback(ILoginCallback callback) {
    throw UnimplementedError('setLoginCallback() has not been implemented.');
  }
}
