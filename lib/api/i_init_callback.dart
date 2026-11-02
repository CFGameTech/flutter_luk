/// 初始化相关回调
abstract class ISDKInitCallback {
  void onSuccess(){}
  void onFail(int code, String msg){}
}
