import 'dart:ui';

import 'package:flame/components.dart';

import '../../common/game_constants.dart';

class SnakePart extends PositionComponent {
  SnakePart(this.to);

  Vector2 to;

  @override
  void render(Canvas canvas) {
    final paint = Paint()..color = const Color(0xFFfcc45c);
    canvas.drawCircle(Offset(0, 0), GameConstants.snakeSize / 2, paint);
    // canvas.drawRect(
    //   Rect.fromLTWH(0, 0, GameConstants.snakeSize, GameConstants.snakeSize),
    //   paint,
    // );
  }
}