/// 加载游戏相关回调
abstract class IGameLoadCallback {
  void onSuccess(){}
  void onFail(int code, String msg){}
}
