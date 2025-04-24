import 'package:luk/api/i_game_logger.dart';

class GameLogger implements IGameLogger {
  @override
  void onDebug(String tag, String msg) {}

  @override
  void onError(String tag, String msg) {}

  @override
  void onInfo(String tag, String msg) {}

  @override
  void onWarn(String tag, String msg) {}
}
