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

  // final String mySprite;
  // final double myAngle;

  // static final List<String> topPaths = [
  //   //'border/stone.png',
  //   //'border/stone2.png'
  // ];

  @override
  Future<void> onLoad() async {
    // super.onLoad();
    // sprite = await game.loadSprite('ground/tile094.png');
    //
    // final topSprite = await game.loadSprite(mySprite);
    //
    // final overlay = SpriteComponent(
    //   anchor: Anchor.center,
    //   sprite: topSprite,
    //   angle: myAngle,
    //   size: size,
    //   //position: Vector2.zero(),
    // );
    //
    // add(overlay);

    add(RectangleHitbox(collisionType: CollisionType.passive));
  }
}


