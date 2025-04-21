import 'dart:math';

import 'package:flame/components.dart';
import 'package:snakegame/snake_game.dart';

class SnakePart extends SpriteComponent with HasGameReference<SnakeGame> {
  SnakePart(this.to, this.mySize);

  Vector2 to;
  Vector2 mySize;

  double currentAngle = 0.0;
  double targetAngle = 0.0;

  final angleSpeed = 10;


  @override
  Future<void> onLoad() async {
    super.onLoad();

    sprite = await game.loadSprite("snake_part.png");
    size = mySize;
    anchor = Anchor.center;
  }

  @override
  void update(double dt) {
    super.update(dt);

    currentAngle = interpolateAngle(currentAngle, targetAngle, dt * angleSpeed);
    angle = currentAngle;
    if((angle - currentAngle).abs() <= 1) {
      angle = currentAngle;
    }
  }

  double interpolateAngle(double current, double target, double t) {
    double difference = (target - current + pi) % (2 * pi) - pi;
    return current + difference * t;
  }
}
