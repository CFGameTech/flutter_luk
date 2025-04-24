import 'package:luk/bean/result_bean.dart';

class ResultUtil {
  ResultUtil._();

  static ResultBean getResult(dynamic args) {
    if (args is Map) {
      int code = args["code"] as int;
      String msg = args["msg"] as String;
      Map data = (args["data"] as Map?) ?? {};
      return ResultBean(code, msg, data);
    }
    return ResultBean(-1, "参数错误！", {});
  }
}
