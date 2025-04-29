/// 小游戏的生命周期相关方法回调
abstract class IGameLifeCallback {
  /// 游戏加载失败
  void onGameLoadFail(){}

  /// 预加入游戏
  bool onPreJoinGame(String uid, int seatIndex){
    return true;
  }

  /// 准备就绪
  void onGamePrepare(String uid){}

  /// 取消准备
  void onCancelPrepare(String uid){}

  /// 游戏结束
  void onGameOver(){}

  /// 游戏加载结束
  void onGameDidFinishLoad(){}

  /// 点击游戏中的玩家头像
  void onSeatAvatarTouch(String uid, int seatIndex){}

  /// 游戏内购买结果回调
  void onGamePurchaseResult(int code, String orderId){}

  void onGameStateChangeState(String state, String dataJson){}

  void onPlayerStateChangeState(String uid, String state, String dataJson){}

  void onGameMusicStartPlay(int musicId, String musicUrl, bool isLoop){}

  void onGameMusicStopPlay(int musicId){}

  void onGameEffectSoundStartPlay(int soundId, String soundUrl, bool isLoop){}

  void onGameEffectSoundStopPlay(int effectId){}
}

