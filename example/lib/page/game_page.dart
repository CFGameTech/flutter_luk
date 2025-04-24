import 'package:flutter/material.dart';
import 'package:luk/bean/game_info.dart';
import 'package:luk/luk.dart';
import 'package:luk/view/luk_game_controller.dart';
import 'package:luk/view/luk_game_view.dart';
import 'package:luk_example/sheet/game_list_sheet.dart';

/// 游戏页
class GamePage extends StatefulWidget {
  final GameInfo gameInfo;

  const GamePage({super.key, required this.gameInfo});

  @override
  State<StatefulWidget> createState() {
    return _GamePageState();
  }
}

class _GamePageState extends State<GamePage> {
  late LukGameController _gameController;
  late GameInfo _gameInfo;

  @override
  void initState() {
    super.initState();
    _gameInfo = widget.gameInfo;
    _gameController = LukGameController(
        initGameInfo: _gameInfo, roomId: "200016", isRoomOwner: true);
  }

  @override
  void dispose() {
    super.dispose();
    _gameController.onPause(); //小游戏视图挂起
    _gameController.onDispose(); //释放flutter相关资源
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          LukGameView(
            controller: _gameController,
          ),
          Positioned(
              top: 50,
              right: 32,
              child: GestureDetector(
                onTap: () {
                  // 仅销毁游戏视图，不执行业务逻辑
                  _gameController.onDestroy();
                  Navigator.pop(context);
                },
                child: Container(
                  width: 120,
                  height: 45,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(23)),
                  child: const Center(
                    child: Text(
                      "退出游戏",
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ),
                ),
              )),
          Positioned(
              top: 50,
              right: 180,
              child: GestureDetector(
                onTap: () {
                  _showGameList();
                },
                child: Container(
                  width: 120,
                  height: 45,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(23)),
                  child: const Center(
                    child: Text(
                      "游戏列表",
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  /// 弹出游戏列表
  void _showGameList() async {
    // 获取游戏列表
    List<GameInfo> gameList = await Luk.instance.getGameList();
    if (gameList.isNotEmpty) {
      var result = await _showGameListSheet(gameList);
      if (result != null && result is GameInfo) {
        _gameController.loadGame(result);
      }
    }
  }

  Future<dynamic> _showGameListSheet(List<GameInfo> gameList) async {
    dynamic result = await showModalBottomSheet(
        context: context,
        useRootNavigator: false,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return GameListSheet(
            gameList: gameList,
          );
        });
    return result;
  }
}
