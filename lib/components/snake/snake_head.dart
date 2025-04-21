import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:snakegame/components/map/border_tile.dart';
import 'package:snakegame/components/snake/snake.dart';
import 'package:snakegame/components/snake/snake_border.dart';
import 'package:snakegame/components/snake/snake_part.dart';
import 'package:snakegame/components/yummy.dart';
import 'package:snakegame/helpers/logger_service.dart';

class SnakeHead extends SnakePart with CollisionCallbacks {
  SnakeHead(super.to, super.mySize, this.snake, this.onYummyEaten);

  late final Snake snake;
  late final void Function(SpriteComponent yummy) onYummyEaten;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    size = mySize;

    sprite = await game.loadSprite("snake_head.png");

    final originalSize = sprite!.originalSize;

    priority = 1;

    final fixedHeight = mySize.x;
    final scaleFactor = fixedHeight / originalSize.y;
    final width = originalSize.x * scaleFactor;

    size = Vector2(width, fixedHeight);

    anchor = Anchor.center;

    add(CircleHitbox(
      position: Vector2(size.x * 0.1, size.x * 0.2),
      radius: size.x * 0.25,
      collisionType: CollisionType.active,
    ));
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is BorderTile) {
      deathSnake();
    } else if (other is SnakeBorder) {
      deathSnake();
    } else if (other is Yummy) {
      snake.addBorderPart();
      onYummyEaten(other);
    }
  }

  void deathSnake() {
    GameLogger().i("death");
    snake.speed = 0;
    game.router.pushReplacementNamed('menu');
  }
}
