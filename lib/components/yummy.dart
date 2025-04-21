import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:snakegame/common/game_constants.dart';
import 'package:snakegame/components/snake/snake_border.dart';
import 'package:snakegame/components/snake/snake_head.dart';
import 'package:snakegame/snake_game.dart';

class Yummy extends SpriteComponent with HasGameReference<SnakeGame>, CollisionCallbacks {
  Yummy(Vector2 position)
      : super(
    position: position,
    size: Vector2.all(GameConstants.snakeSize),
  );

  static final List<String> spritePaths = [
    'yummies/boba_coffee.png',
    'yummies/boba_mango.png',
    'yummies/boba_matcha.png',
    'yummies/boba_milktea.png',
    'yummies/boba_strawberry.png',
    'yummies/boba_taro.png',
    'yummies/boba_thai.png',
    'yummies/cake_cheese.png',
    'yummies/cake_chocolate.png',
    'yummies/cake_matcha.png',
    'yummies/cake_redvelvet.png',
    'yummies/canned_soup.png',
    'yummies/cheese_blue.png',
    'yummies/cheese_camembert.png',
    'yummies/cheese_gouda.png',
    'yummies/cheese_mozzarella.png',
    'yummies/coffee_darkroast.png',
    'yummies/coffee_espresso.png',
    'yummies/coffee_foam.png',
    'yummies/coffee_greentea.png',
    'yummies/coffee_lightroast.png',
    'yummies/coffee_mediumroast.png',
    'yummies/coffee_milkjug.png',
    'yummies/coffee_mocha.png',
    'yummies/coffee_raw.png',
    'yummies/coffee_tea.png'
  ];

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    anchor = Anchor.center;
    position += size / 2;
    sprite = game.getRandomYummySprite();

    final inset = GameConstants.snakeSize / 4;

    final hitboxSize = GameConstants.snakeSize - inset * 3;

    final hitboxPosition = Vector2.all(inset);

    add(
      CircleHitbox(collisionType: CollisionType.passive, radius: hitboxSize, position: hitboxPosition)
    );
  }

  double time = 0.0;

  @override
  void update(double dt) {
    super.update(dt);
    time += dt;
    final scaleFactor = 1.0 + 0.25 * sin(time * 3);
    scale = Vector2.all(scaleFactor);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if(other is SnakeHead) {
      removeFromParent();
    } else if (other is SnakeBorder) {
      
    }
  }
}