import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:luk/bean/game_info.dart';
import 'package:luk/luk.dart';
import 'package:luk_example/api/game_biz_callback.dart';
import 'package:luk_example/api/game_life_callback.dart';
import 'package:luk_example/api/game_logger.dart';
import 'package:luk_example/page/game_page.dart';
import 'package:luk_example/sheet/game_list_sheet.dart';

/// demo首页
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  bool? _loginSuccess; //是否登录成功
  final List<GameInfo> _gameList = []; //游戏列表

  @override
  void initState() {
    super.initState();
    _initSdk(); // sdk初始化等相关操作
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// sdk初始化
  void _initSdk() async {
    Luk.instance.setGameBizCallback(GameBizCallback());
    Luk.instance.setGameLifeCallback(GameLifeCallback());
    Luk.instance.setGameLogger(GameLogger());
    // sdk初始化
    await Luk.instance.setupSdk(appId: 1013140, language: "zh_CN", area: "cn", isProduct: true);
    // 用户登录
    _loginSuccess = await Luk.instance.setUserInfo(uid: "123456", verifyCode: "");
    setState(() {});
    // 获取游戏列表
    List<GameInfo> list = await Luk.instance.getGameList();
    if (list.isNotEmpty) {
      _gameList.addAll(list);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loginSuccess == true
          ? Center(
              child: GestureDetector(
                onTap: () {
                  _showGameList(context);
                },
                child: Container(
                  width: 220,
                  height: 45,
                  decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(23)),
                  child: const Center(
                    child: Text(
                      "点击查看游戏列表",
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ),
                ),
              ),
            )
          : Center(
              child: Text(_loginSuccess == null ? "登录中..." : "登录失败！"),
            ),
    );
  }

  /// 弹出游戏列表
  void _showGameList(BuildContext context) async {
    if (_gameList.isNotEmpty) {
      dynamic result = await showModalBottomSheet(
          context: context,
          useRootNavigator: false,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return GameListSheet(
              gameList: _gameList,
            );
          });
      if (result != null && result is GameInfo) {
        //选中了某个游戏
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return GamePage(
            gameInfo: result,
          );
        }));
      }
    } else if (_loginSuccess != true) {
      Fluttertoast.showToast(msg: "未执行登录或登录失败！");
    } else {
      Fluttertoast.showToast(msg: "游戏列表为空！");
    }
  }
}
