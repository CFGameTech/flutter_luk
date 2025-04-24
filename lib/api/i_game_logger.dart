/// 日志记录
abstract class IGameLogger {
  void onDebug(String tag, String msg);

  void onInfo(String tag, String msg);

  void onWarn(String tag, String msg);

  void onError(String tag, String msg);
}
