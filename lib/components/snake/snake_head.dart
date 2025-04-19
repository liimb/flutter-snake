import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:snakegame/common/game_constants.dart';
import 'package:snakegame/components/map/border_tile.dart';
import 'package:snakegame/components/snake/snake.dart';
import 'package:snakegame/components/snake/snake_border.dart';
import 'package:snakegame/components/snake/snake_part.dart';
import 'package:snakegame/components/yummy.dart';
import 'package:snakegame/helpers/logger_service.dart';
import 'package:snakegame/snake_game.dart';

class SnakeHead extends SnakePart with CollisionCallbacks, HasGameReference<SnakeGame> {
  SnakeHead(super.to, this.snake, this.onYummyEaten);

  late final Snake snake;
  late final void Function(SpriteComponent yummy) onYummyEaten;

  @override
  void onLoad() {
    final inset = GameConstants.snakeSize / 4;
    final hitboxSize = Vector2(
      GameConstants.snakeSize - inset * 2,
      GameConstants.snakeSize - inset * 2,
    );

    final hitboxPosition = Vector2(inset, inset);

    // add(RectangleHitbox(
    //   position: hitboxPosition,
    //   size: hitboxSize,
    //   collisionType: CollisionType.active,
    // ));

    add(
      CircleHitbox(collisionType: CollisionType.active, radius: hitboxSize.x / 2, anchor: Anchor.center)
    );
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
    //snake.speed = 0;
    game.router.pushReplacementNamed('menu');
  }
}