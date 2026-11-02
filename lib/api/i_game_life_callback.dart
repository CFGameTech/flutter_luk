/// 小游戏的生命周期相关方法回调
abstract class IGameLifeCallback {
  /// 游戏加载失败
  void onGameLoadFail(){}

  /// 预加入游戏
  bool onPreJoinGame(String uid, int seatIndex){
    return true;
  }

  bool onCanStartGame(String uid){
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

  ///  游戏状态回调
  void onGameStateChangeState(String state, String dataJson){}

  /// 玩家状态回调
  void onPlayerStateChangeState(String uid, String state, String dataJson){}

  /// 游戏音乐播放回调
  void onGameMusicStartPlay(int musicId, String musicUrl, bool isLoop){}

  /// 游戏音乐停止回调
  void onGameMusicStopPlay(int musicId){}


  /// 游戏音效播放回调
  void onGameEffectSoundStartPlay(int soundId, String soundUrl, bool isLoop){}

  /// 游戏音效停止回调
  void onGameEffectSoundStopPlay(int effectId){}

  /// 游戏截图回调
  void onGameScreenShotBaseData(String base64String, String dataJson) {}
}

