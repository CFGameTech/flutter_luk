/// 登录相关回调
abstract class ILoginCallback {
  void onLoginSuccess(){}

  void onLoginFail(int code, String msg){}

  void onRefreshToken(String token){}
}
