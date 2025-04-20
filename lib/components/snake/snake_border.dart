import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:snakegame/components/snake/snake_part.dart';

import '../../common/game_constants.dart';

class SnakeBorder extends SnakePart with CollisionCallbacks {
  SnakeBorder(super.to, super.mySize);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    anchor = Anchor.center;

    add(RectangleHitbox(
        //TODO хитбокс не по центру
        size: Vector2.all(GameConstants.snakeSize * scale.x),
        collisionType: CollisionType.passive
    ));

    size = mySize;
  }
}