import 'dart:ui';
import 'package:flame/components.dart';
import 'package:snakegame/common/game_constants.dart';
import 'package:snakegame/components/ui/simple_button.dart';
import 'package:snakegame/snake_game.dart';

class BackButton extends SimpleButton with HasGameReference<SnakeGame> {
  BackButton()
      : super(
    Path()
      ..moveTo(22, 8)
      ..lineTo(10, 20)
      ..lineTo(22, 32)
      ..moveTo(12, 20)
      ..lineTo(34, 20),
    position: Vector2.all(GameConstants.mapY / 4),
  );

  @override
  void action() => game.router.pushReplacementNamed("menu");
}