import 'package:luk/api/i_game_life_callback.dart';

class GameLifeCallback implements IGameLifeCallback {
  @override
  void onCancelPrepare(String uid) {}

  @override
  void onGameDidFinishLoad() {}

  @override
  void onGameLoadFail() {}

  @override
  void onGameOver() {}

  @override
  void onGamePrepare(String uid) {}

  @override
  void onGamePurchaseResult(int code, String orderId) {}

  @override
  bool onPreJoinGame(String uid, int seatIndex) {
    return true;
  }

  @override
  void onSeatAvatarTouch(String uid, int seatIndex) {}

  @override
  void onGameEffectSoundStartPlay(int soundId, String soundUrl, bool isLoop) {}

  @override
  void onGameEffectSoundStopPlay(int effectId) {}

  @override
  void onGameMusicStartPlay(int musicId, String musicUrl, bool isLoop) {}

  @override
  void onGameMusicStopPlay(int musicId) {}

  @override
  void onGameStateChangeState(String state, String dataJson) {}

  @override
  void onPlayerStateChangeState(String uid, String state, String dataJson) {}
}
