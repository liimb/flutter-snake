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
    'yummies/coffee_tea.png',
    'yummies/eggs_brown.png',
    'yummies/eggs_fried.png',
    'yummies/eggs_overeasy.png',
    'yummies/eggs_scrambled.png',
    'yummies/eggs_softboiled.png',
    'yummies/eggs_white.png',
    'yummies/fruit_apple.png',
    'yummies/fruit_apple-slice.png',
    'yummies/fruit_banana.png',
    'yummies/fruit_blueberry.png',
    'yummies/fruit_cherry.png',
    'yummies/fruit_grape_red.png',
    'yummies/fruit_greengrape.png',
    'yummies/fruit_kiwi.png',
    'yummies/fruit_lemon.png',
    'yummies/fruit_lime.png',
    'yummies/fruit_orange.png',
    'yummies/fruit_orange_slice.png',
    'yummies/fruit_peach.png',
    'yummies/fruit_strawberry.png',
    'yummies/fruit_watermelon.png',
    'yummies/fruit_watermelon_slice.png',
    'yummies/icecream_1scoop.png',
    'yummies/icecream_2scoops.png',
    'yummies/icecream_3scoops.png',
    'yummies/jam_blueberry.png',
    'yummies/jam_grape.png',
    'yummies/jam_kiwi.png',
    'yummies/jam_peach.png',
    'yummies/jam_strawberry.png',
    'yummies/onigiri_1.png',
    'yummies/onigiri_2.png',
    'yummies/onigiri_3.png',
    'yummies/onigiri_4.png',
    'yummies/onigiri_5.png',
    'yummies/pastry_baguette.png',
    'yummies/pastry_bread.png',
    'yummies/pastry_brioche.png',
    'yummies/pastry_croissant.png',
    'yummies/pastry_pretzel.png',
    'yummies/popsicle_blue.png',
    'yummies/popsicle_green.png',
    'yummies/popsicle_pink.png',
    'yummies/popsicle_red.png',
    'yummies/popsicle_yellow.png',
    'yummies/soda_coke.png',
    'yummies/soda_fanta.png',
    'yummies/soda_pepsi.png',
    'yummies/soda_sprite.png',
    'yummies/soymilk_almond.png',
    'yummies/soymilk_banana.png',
    'yummies/soymilk_choco.png',
    'yummies/soymilk_chocomint.png',
    'yummies/soymilk_coffee.png',
    'yummies/soymilk_mango.png',
    'yummies/soymilk_match.png',
    'yummies/soymilk_peach.png',
    'yummies/soymilk_soy.png',
    'yummies/soymilk_strawberry.png',
    'yummies/vegetable_bellpepper_green.png',
    'yummies/vegetable_bellpepper_red.png',
    'yummies/vegetable_bellpepper_yellow.png',
    'yummies/vegetable_carrot.png',
    'yummies/vegetable_corn.png',
    'yummies/vegetable_cucumber.png',
    'yummies/vegetable_eggplant.png',
    'yummies/vegetable_garlic.png',
    'yummies/vegetable_ginger.png',
    'yummies/vegetable_jalapeno.png',
    'yummies/vegetable_onion.png',
    'yummies/vegetable_potato.png',
    'yummies/vegetable_pumpkin.png',
    'yummies/vegetable_tomato.png'
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