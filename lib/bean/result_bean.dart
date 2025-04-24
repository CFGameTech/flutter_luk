class ResultBean {
  int code = -1;
  String msg = "";
  Map data = {};

  ResultBean(this.code, this.msg, this.data);

  bool isSuccess() {
    return code == 0;
  }
}
