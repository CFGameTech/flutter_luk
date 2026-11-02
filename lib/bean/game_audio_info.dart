class GameAudioInfo {
  String url = "";
  String name = "";
  String type = "";



  GameAudioInfo(
      this.url, this.name, this.type);

  static GameAudioInfo fromMap(dynamic args) {
    GameAudioInfo info = GameAudioInfo( "", "", "");
    info.url = (args["url"] as String?) ?? "";
    info.name = (args["name"] as String?) ?? "";
    info.type = (args["type"] as String?) ?? "";
    return info;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["url"] = url;
    map["name"] = name;
    map["type"] = type;

    return map;
  }
}
