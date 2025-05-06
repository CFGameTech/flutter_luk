import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:luk/api/i_game_biz_callback.dart';
import 'package:luk/api/i_game_life_callback.dart';
import 'package:luk/api/i_game_logger.dart';
import 'package:luk/api/i_login_callback.dart';
import 'package:luk/api/i_game_rtc_callback.dart';
import 'package:luk/api/i_preload_game_callback.dart';
import 'package:luk/api/i_report_stats_event_callback.dart';
import 'package:luk/bean/game_info.dart';
import 'package:luk/util/result_util.dart';

import 'luk_platform_interface.dart';

/// An implementation of [LukPlatform] that uses method channels.
class MethodChannelLuk extends LukPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('luk');

  IGameBizCallback? gameBizCallback;
  IGameLifeCallback? gameLifeCallback;
  IGameLogger? logger;
  ILoginCallback? loginCallback;
  IGameRTCCallback? rtcCallback;
  IPreloadGameCallback? preloadGameCallback;
  IReportStatsEventCallback? statsEventCallback;

  MethodChannelLuk() {
    methodChannel.setMethodCallHandler((call) async {
      switch (call.method) {
        case "onOpenChargePage":
          gameBizCallback?.onOpenChargePage();
          break;
        case "onGamePageClose":
          gameBizCallback?.onGamePageClose();
          break;
        case "onGameLoadFail":
          gameLifeCallback?.onGameLoadFail();
          break;
        case "onPreJoinGame":
          var uid = call.arguments["uid"] as String?;
          var seatIndex = call.arguments["seatIndex"] as int?;
          return gameLifeCallback?.onPreJoinGame(uid ?? "", seatIndex ?? -1) ?? true;
        case "onGamePrepare":
          var uid = call.arguments["uid"] as String?;
          gameLifeCallback?.onGamePrepare(uid ?? "");
          break;
        case "onCancelPrepare":
          var uid = call.arguments["uid"] as String?;
          gameLifeCallback?.onCancelPrepare(uid ?? "");
          break;
        case "onGameOver":
          gameLifeCallback?.onGameOver();
          break;
        case "onGameDidFinishLoad":
          gameLifeCallback?.onGameDidFinishLoad();
          break;
        case "onSeatAvatarTouch":
          var uid = call.arguments["uid"] as String?;
          var seatIndex = call.arguments["seatIndex"] as int?;
          gameLifeCallback?.onSeatAvatarTouch(uid ?? "", seatIndex ?? -1);
          break;
        case "onGamePurchaseResult":
          var code = call.arguments["code"] as int?;
          var orderId = call.arguments["orderId"] as String?;
          gameLifeCallback?.onGamePurchaseResult(code ?? -1, orderId ?? "");
          break;
        case "onDebug":
          var tag = call.arguments["tag"] as String?;
          var msg = call.arguments["msg"] as String?;
          logger?.onDebug(tag ?? "", msg ?? "");
          break;
        case "onInfo":
          var tag = call.arguments["tag"] as String?;
          var msg = call.arguments["msg"] as String?;
          logger?.onInfo(tag ?? "", msg ?? "");
          break;
        case "onWarn":
          var tag = call.arguments["tag"] as String?;
          var msg = call.arguments["msg"] as String?;
          logger?.onWarn(tag ?? "", msg ?? "");
          break;
        case "onError":
          var tag = call.arguments["tag"] as String?;
          var msg = call.arguments["msg"] as String?;
          logger?.onError(tag ?? "", msg ?? "");
          break;
        case "onGameStateChangeState":
          var state = call.arguments["state"] as String?;
          var dataJson = call.arguments["dataJson"] as String?;
          gameLifeCallback?.onGameStateChangeState(state ?? "", dataJson ?? "{}");
          break;
        case "onPlayerStateChangeState":
          var uid = call.arguments["uid"] as String?;
          var state = call.arguments["state"] as String?;
          var dataJson = call.arguments["dataJson"] as String?;
          gameLifeCallback?.onPlayerStateChangeState(uid ?? "", state ?? "", dataJson ?? "{}");
          break;
        case "onGameMusicStartPlay":
          var musicId = call.arguments["musicId"] as int?;
          var musicUrl = call.arguments["musicUrl"] as String?;
          var isLoop = call.arguments["isLoop"] as bool?;
          gameLifeCallback?.onGameMusicStartPlay(musicId ?? 0, musicUrl ?? "", isLoop ?? false);
          break;
        case "onGameMusicStopPlay":
          var musicId = call.arguments["musicId"] as int?;
          gameLifeCallback?.onGameMusicStopPlay(musicId ?? 0);
          break;
        case "onGameEffectSoundStartPlay":
          var musicId = call.arguments["soundId"] as int?;
          var soundUrl = call.arguments["soundUrl"] as String?;
          var isLoop = call.arguments["isLoop"] as bool?;
          gameLifeCallback?.onGameEffectSoundStartPlay(musicId ?? 0, soundUrl ?? "", isLoop ?? false);
          break;
        case "onGameEffectSoundStopPlay":
          var effectId = call.arguments["effectId"] as int?;
          gameLifeCallback?.onGameEffectSoundStopPlay(effectId ?? 0);
          break;
        case "onLoginSuccess":
          loginCallback?.onLoginSuccess();
          break;
        case "onLoginFail":
          var code = call.arguments["code"] as int?;
          var msg = call.arguments["msg"] as String?;
          loginCallback?.onLoginFail(code ?? -1, msg ?? "");
          break;
        case "onRefreshToken":
          var token = call.arguments["token"] as String?;
          loginCallback?.onRefreshToken(token ?? "");
          break;
        case "onCFGamePushSelfRTC":
          var push = call.arguments["push"] as bool?;
          rtcCallback?.onCFGamePushSelfRTC(push ?? false);
          break;
        case "onCFGamePullOtherRTC":
          var uid = call.arguments["uid"] as String?;
          var pull = call.arguments["pull"] as bool?;
          rtcCallback?.onCFGamePullOtherRTC(uid ?? "", pull ?? false);
          break;
        case "onPreLoadGameSuccess":
          var gid = call.arguments["gid"] as String?;
          var state = call.arguments["state"] as int?;
          preloadGameCallback?.onPreLoadGameSuccess(gid ?? "", state ?? -1);
          break;
        case "onReportStatsEvent":
          var event = call.arguments["event"] as String?;
          var code = call.arguments["code"] as int?;
          var msg = call.arguments["msg"] as String?;
          statsEventCallback?.onReportStatsEvent(event ?? "", code ?? -1, msg ?? "");
          break;
      }
      return 0;
    });
  }

  @override
  Future setupSdk({required int appId, required String language, required String area, required bool isProduct}) {
    return methodChannel
        .invokeMethod("setupSdk", {"appId": appId, "language": language, "area": area, "isProduct": isProduct});
  }

  @override
  Future<bool> setUserInfo({required String uid, required String verifyCode}) async {
    dynamic result = await methodChannel.invokeMethod("setUserInfo", {"uid": uid, "code": verifyCode});
    return ResultUtil.getResult(result).isSuccess();
  }

  @override
  Future<List<GameInfo>> getGameList() async {
    dynamic result = await methodChannel.invokeMethod("getGameList");
    if (result is List) {
      List<GameInfo> list = [];
      for (Map item in result) {
        list.add(GameInfo.fromMap(item));
      }
      return list;
    }
    return [];
  }

  @override
  void loadGame({required int gameId, required String url}) {
    methodChannel.invokeMethod("loadGame", {"gameId": gameId, "url": url});
  }

  @override
  void onPause() {
    methodChannel.invokeMethod("onPause");
  }

  @override
  void onResume() {
    methodChannel.invokeMethod("onResume");
  }

  @override
  void onDestroy() {
    methodChannel.invokeMethod("onDestroy");
  }

  @override
  void setGameBizCallback(IGameBizCallback callback) {
    gameBizCallback = callback;
  }

  @override
  void setGameLifeCallback(IGameLifeCallback callback) {
    gameLifeCallback = callback;
  }

  @override
  void setGameLogger(IGameLogger logger) {
    this.logger = logger;
  }

  @override
  void setLoginCallback(ILoginCallback callback) {
    loginCallback = callback;
  }

  @override
  void setRTCCallback(IGameRTCCallback callback) {
    rtcCallback = callback;
  }

  @override
  void refreshUserInfo() {
    methodChannel.invokeMethod("refreshUserInfo");
  }

  @override
  void gameStart() {
    methodChannel.invokeMethod("gameStart");
  }

  @override
  void playerRemoveWithUid(String uid) {
    methodChannel.invokeMethod("playerRemoveWithUid", {
      "uid": uid,
    });
  }

  @override
  void gameBackgroundMusicSet(bool mode) {
    methodChannel.invokeMethod("gameBackgroundMusicSet", {
      "mode": mode,
    });
  }

  @override
  void gameSoundSet(bool mode) {
    methodChannel.invokeMethod("gameSoundSet", {
      "mode": mode,
    });
  }

  @override
  void terminateGame() {
    methodChannel.invokeMethod("terminateGame");
  }

  @override
  void joinGame(int position) {
    methodChannel.invokeMethod("joinGame", {
      "position": position,
    });
  }

  @override
  void quitGame() {
    methodChannel.invokeMethod("quitGame");
  }

  @override
  void setPlayerRole(int role) {
    methodChannel.invokeMethod("setPlayerRole", {
      "role": role,
    });
  }

  @override
  void pauseGame() {
    methodChannel.invokeMethod("pauseGame");
  }

  @override
  void playGame() {
    methodChannel.invokeMethod("playGame");
  }

  @override
  void preloadGameList(List<int> gameIdList) {
    methodChannel.invokeMethod("preloadGameList", {
      "gameIdList": gameIdList,
    });
  }

  @override
  void setPreloadGameCallback(IPreloadGameCallback callback) {
    preloadGameCallback = callback;
  }

  @override
  void cancelPreloadGame(List<int> gameIdList) {
    methodChannel.invokeMethod("cancelPreloadGame", {
      "gameIdList": gameIdList,
    });
  }

  @override
  void releaseSDK() {
    methodChannel.invokeMethod("releaseSDK");
  }

  @override
  void sentExtToGame(String ext) {
    methodChannel.invokeMethod("sentExtToGame", {
      "ext": ext,
    });
  }

  @override
  void showCloseButton(bool isShow) {
    methodChannel.invokeMethod("showCloseButton", {
      "isShow": isShow,
    });
  }

  @override
  void setLanguage(String language) {
    methodChannel.invokeMethod("setLanguage", {
      "language": language,
    });
  }

  @override
  void gameReload() {
    methodChannel.invokeMethod("gameReload");
  }

  @override
  void setReportStatsEventListener(IReportStatsEventCallback callback) {
    statsEventCallback = callback;
  }

  @override
  void setGameVoicePath(String path) {
    methodChannel.invokeMethod("setGameVoicePath", {
      "path": path,
    });
  }

  @override
  void appNotifyStateChange(String state, String dataJson) {
    methodChannel.invokeMethod("appNotifyStateChange", {
      "state": state,
      "dataJson": dataJson,
    });
  }
}
