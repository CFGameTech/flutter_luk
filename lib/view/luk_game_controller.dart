import 'package:luk/bean/game_info.dart';
import 'package:luk/luk.dart';

class LukGameController {
  GameInfo? initGameInfo;
  bool isRoomOwner;
  String roomId;

  List<void Function(GameInfo initGameInfo)>? _onGameChangedCallbacks = [];

  LukGameController(
      {required this.initGameInfo,
      required this.isRoomOwner,
      required this.roomId});

  /// 添加一个监听器
  void addOnGameChangedCallback(void Function(GameInfo initGameInfo) callback) {
    _onGameChangedCallbacks?.add(callback);
  }

  /// 移除监听器
  void removeOnGameChangedCallback(
      void Function(GameInfo initGameInfo) callback) {
    _onGameChangedCallbacks?.remove(callback);
  }

  /// 加载小游戏
  void loadGame(GameInfo gameInfo) {
    initGameInfo = gameInfo;
    for (var element in (_onGameChangedCallbacks ?? [])) {
      element(gameInfo);
    }
  }

  /// 切换到后台
  void onPause() {
    Luk.instance.onPause();
  }

  /// 回到前台
  void onResume() {
    Luk.instance.onResume();
  }

  /// 销毁游戏视图（不会调用其余业务逻辑）
  void onDestroy() {
    Luk.instance.onDestroy();
  }

  /// 释放flutter资源
  void onDispose() {
    _onGameChangedCallbacks?.clear();
    initGameInfo = null;
    _onGameChangedCallbacks = null;
  }
}
