/// 接入方可以调该方法获取网络请求状态
abstract class IReportStatsEventCallback {
  /// 回调参数说明：
  /// [event] ： String  事件名称
  /// [code]  ： int     状态码 0 为成功 其他为失败
  /// [msg]   ： String  描述
  void onReportStatsEvent(String event, int code, String msg);
}
