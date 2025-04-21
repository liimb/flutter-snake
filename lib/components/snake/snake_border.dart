import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:snakegame/components/snake/snake_part.dart';

class SnakeBorder extends SnakePart with CollisionCallbacks {
  SnakeBorder(super.to, super.mySize);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    anchor = Anchor.center;
    size = mySize;

    add(CircleHitbox(
        position: Vector2(size.x * 0.1, size.x * 0.1),
        radius: size.x * 0.4,
        collisionType: CollisionType.passive
    ));
  }
}
