import 'package:luk/api/i_game_rtc_callback.dart';


class GameRTCCallback implements IGameRTCCallback {


  @override
  void onCFGamePullOtherRTC(String uid, bool pull) {
    // TODO: implement onCFGamePullOtherRTC
    print("onCFGamePullOtherRTC call");
  }

  @override
  void onCFGamePushSelfRTC(bool push) {
    // TODO: implement onCFGamePushSelfRTC
    print("onCFGamePushSelfRTC call");
  }
}
