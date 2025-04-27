class GameSafeArea {
  final int left;
  final int top;
  final int right;
  final int bottom;
  final double scaleMinLimit;

  const GameSafeArea(
      {required this.left, required this.top, required this.right, required this.bottom, required this.scaleMinLimit});
}
