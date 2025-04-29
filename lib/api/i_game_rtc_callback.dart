/// RTC相关业务回调
abstract class IGameRTCCallback {
  /// 推本地的流
  void onCFGamePushSelfRTC(bool push){}

  /// 拉远端的流
  void onCFGamePullOtherRTC(String uid,bool pull){}
}
