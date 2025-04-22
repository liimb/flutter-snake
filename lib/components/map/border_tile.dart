import 'dart:ui';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import '../../snake_game.dart';

class BorderTile extends SpriteComponent with HasGameReference<SnakeGame> {
  BorderTile(Rect rect)
      : super(
    position: Vector2(rect.left, rect.top),
    size: Vector2(rect.width, rect.height),
  );

  // final String mySprite;
  // final double myAngle;

  static final List<String> topPaths = [
    'border/stone.png',
    //'border/stone2.png'
  ];

  @override
  Future<void> onLoad() async {
    super.onLoad();
    //TODO лучше бы сделать границу покрасивее
    sprite = await game.loadSprite(topPaths[0]);

    add(RectangleHitbox(collisionType: CollisionType.passive));
  }
}


