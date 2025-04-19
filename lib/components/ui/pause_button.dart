import 'dart:ui';
import 'package:flame/components.dart';
import 'package:snakegame/common/game_constants.dart';
import 'package:snakegame/components/ui/simple_button.dart';
import 'package:snakegame/snake_game.dart';

class PauseButton extends SimpleButton with HasGameReference<SnakeGame> {
  PauseButton()
      : super(
    Path()
      ..moveTo(14, 10)
      ..lineTo(14, 30)
      ..moveTo(26, 10)
      ..lineTo(26, 30),
    position: Vector2(100, GameConstants.mapY / 4),
  );

  bool isPaused = false;

  @override
  void action() {
    if (isPaused) {
      game.router.pop();
    } else {
      game.router.pushNamed('pause');
    }
    isPaused = !isPaused;
  }
}
