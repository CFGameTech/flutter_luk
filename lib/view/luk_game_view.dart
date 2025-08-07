import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:luk/bean/game_info.dart';
import 'package:luk/bean/game_safe_area.dart';
import 'package:luk/view/luk_game_controller.dart';

class LukGameView extends StatefulWidget {
  final LukGameController controller;
  final GameSafeArea gameSafeArea;

  const LukGameView(
      {super.key,
      required this.controller,
      this.gameSafeArea = const GameSafeArea(left: 0, top: 0, right: 0, bottom: 0, scaleMinLimit: 0.0)});

  @override
  State<StatefulWidget> createState() {
    return _LukGameViewState();
  }
}

class _LukGameViewState extends State<LukGameView> {
  static const String viewType = 'luk/luk_game_view';
  GameInfo? _gameInfo;
  Map<String, dynamic> creationParams = <String, dynamic>{};

  @override
  void initState() {
    super.initState();
    widget.controller.addOnGameChangedCallback((initGameInfo) async {
      if (initGameInfo.id == _gameInfo?.id && initGameInfo.url == _gameInfo?.url) {
        // 同一个游戏不需要重复切换
        return;
      }
      _gameInfo = null;
      setState(() {});
      await Future.delayed(const Duration(milliseconds: 100));
      _gameInfo = initGameInfo;
      creationParams["roomId"] = widget.controller.roomId;
      creationParams["isRoomOwner"] = widget.controller.isRoomOwner;
      creationParams["left"] = widget.gameSafeArea.left;
      creationParams["top"] = widget.gameSafeArea.top;
      creationParams["right"] = widget.gameSafeArea.right;
      creationParams["bottom"] = widget.gameSafeArea.bottom;
      creationParams["scaleMinLimit"] = widget.gameSafeArea.scaleMinLimit;
      if (widget.controller.initGameInfo != null) {}
      var gameInfo = initGameInfo.toMap();
      for (String key in gameInfo.keys) {
        creationParams[key] = gameInfo[key];
      }
      setState(() {});
    });
    var initGameInfo = widget.controller.initGameInfo;
    if (initGameInfo != null) {
      widget.controller.loadGame(initGameInfo);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_gameInfo == null) {
      return Container();
    }
    if (Platform.isAndroid) {
      return PlatformViewLink(
        viewType: viewType,
        surfaceFactory: (context, controller) {
          return AndroidViewSurface(
            controller: controller as AndroidViewController,
            gestureRecognizers: const {
              Factory<OneSequenceGestureRecognizer>(
                LongPressGestureRecognizer.new,
              )
            },
            hitTestBehavior: PlatformViewHitTestBehavior.opaque,
          );
        },
        onCreatePlatformView: (params) {
          return PlatformViewsService.initExpensiveAndroidView(
            id: params.id,
            viewType: viewType,
            layoutDirection: TextDirection.ltr,
            creationParams: creationParams,
            creationParamsCodec: const StandardMessageCodec(),
            onFocus: () {
              params.onFocusChanged(true);
            },
          )
            ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
            ..create();
        },
      );
    } else if (Platform.isIOS) {
      return UiKitView(
        viewType: viewType,
        creationParams: creationParams,
        creationParamsCodec: const StandardMessageCodec(),
        onPlatformViewCreated: (id) {},
      );
    } else {
      return const Center(
        child: Text("暂不支持该平台"),
      );
    }
  }
}
