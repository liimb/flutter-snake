import 'dart:ui';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import '../../snake_game.dart';

class BorderTile extends PositionComponent with HasGameReference<SnakeGame> {
  BorderTile(Rect rect)
      : super(
    position: Vector2(rect.left, rect.top),
    size: Vector2(rect.width, rect.height),
  );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(RectangleHitbox(collisionType: CollisionType.passive));
  }
}