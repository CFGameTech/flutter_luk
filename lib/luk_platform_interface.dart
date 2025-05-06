import 'package:luk/api/i_game_biz_callback.dart';
import 'package:luk/api/i_game_life_callback.dart';
import 'package:luk/api/i_game_logger.dart';
import 'package:luk/api/i_game_rtc_callback.dart';
import 'package:luk/api/i_login_callback.dart';
import 'package:luk/api/i_preload_game_callback.dart';
import 'package:luk/api/i_report_stats_event_callback.dart';
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

  void setRTCCallback(IGameRTCCallback callback) {
    throw UnimplementedError('setRTCCallback() has not been implemented.');
  }

  void refreshUserInfo() {
    throw UnimplementedError('refreshUserInfo() has not been implemented.');
  }

  void gameStart() {
    throw UnimplementedError('gameStart() has not been implemented.');
  }

  void playerRemoveWithUid(String uid) {
    throw UnimplementedError('playerRemoveWithUid() has not been implemented.');
  }

  void gameBackgroundMusicSet(bool mode) {
    throw UnimplementedError('gameBackgroundMusicSet() has not been implemented.');
  }

  void gameSoundSet(bool mode) {
    throw UnimplementedError('gameSoundSet() has not been implemented.');
  }

  void terminateGame() {
    throw UnimplementedError('terminateGame() has not been implemented.');
  }

  void joinGame(int position) {
    throw UnimplementedError('joinGame() has not been implemented.');
  }

  void quitGame() {
    throw UnimplementedError('quitGame() has not been implemented.');
  }

  void setPlayerRole(int role) {
    throw UnimplementedError('setPlayerRole() has not been implemented.');
  }

  void pauseGame() {
    throw UnimplementedError('pauseGame() has not been implemented.');
  }

  void playGame() {
    throw UnimplementedError('playGame() has not been implemented.');
  }

  void preloadGameList(List<int> gameIdList) {
    throw UnimplementedError('preloadGameList() has not been implemented.');
  }

  void setPreloadGameCallback(IPreloadGameCallback callback) {
    throw UnimplementedError('setPreloadGameCallback() has not been implemented.');
  }

  void cancelPreloadGame(List<int> gameIdList) {
    throw UnimplementedError('cancelPreloadGame() has not been implemented.');
  }

  void releaseSDK() {
    throw UnimplementedError('releaseSDK() has not been implemented.');
  }

  void sentExtToGame(String ext) {
    throw UnimplementedError('sentExtToGame() has not been implemented.');
  }

  void showCloseButton(bool isShow) {
    throw UnimplementedError('showCloseButton() has not been implemented.');
  }

  void setLanguage(String language) {
    throw UnimplementedError('setLanguage() has not been implemented.');
  }

  void gameReload() {
    throw UnimplementedError('gameReload() has not been implemented.');
  }

  void setReportStatsEventListener(IReportStatsEventCallback callback) {
    throw UnimplementedError('setReportStatsEventListener() has not been implemented.');
  }

  void setGameVoicePath(String path) {
    throw UnimplementedError('setGameVoicePath() has not been implemented.');
  }

  void appNotifyStateChange(String state, String dataJson) {
    throw UnimplementedError('appNotifyStateChange() has not been implemented.');
  }
}
