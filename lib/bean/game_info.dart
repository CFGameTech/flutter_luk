class GameInfo {
  int id = 0;
  String name = "";
  String icon = "";
  String url = "";
  String zipUrl = "";
  int screenHalf = 0;

  GameInfo(
      this.id, this.name, this.icon, this.url, this.zipUrl, this.screenHalf);

  static GameInfo fromMap(dynamic args) {
    GameInfo info = GameInfo(0, "", "", "", "", 0);
    info.id = (args["g_id"] as int?) ?? 0;
    info.name = (args["g_name"] as String?) ?? "";
    info.icon = (args["g_icon"] as String?) ?? "";
    info.url = (args["g_url"] as String?) ?? "";
    info.zipUrl = (args["g_zip_url"] as String?) ?? "";
    info.screenHalf = (args["screen_half"] as int?) ?? 0;
    return info;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["g_id"] = id;
    map["g_name"] = name;
    map["g_icon"] = icon;
    map["g_url"] = url;
    map["g_zip_url"] = zipUrl;
    map["screen_half"] = screenHalf;
    return map;
  }
}
