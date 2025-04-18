import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:snakegame/components/snake_part.dart';

import '../common/game_constants.dart';

class SnakeBorder extends SnakePart with CollisionCallbacks {
  SnakeBorder(super.to);

  @override
  void onLoad() {
    add(RectangleHitbox(
        size: Vector2(GameConstants.snakeSize, GameConstants.snakeSize),
        collisionType: CollisionType.passive
    ));
  }
}