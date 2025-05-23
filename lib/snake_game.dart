import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:snakegame/components/yummy.dart';
import 'package:snakegame/ui/screens/game_screen.dart';
import 'package:snakegame/ui/screens/lose_screen.dart';
import 'package:snakegame/ui/screens/menu_screen.dart';
import 'package:snakegame/ui/screens/authors_screen.dart';
import 'package:snakegame/ui/screens/pause_screen.dart';

import 'components/map/standart_tile.dart';
import 'helpers/logger_service.dart';

class SnakeGame extends FlameGame with TapDetector, HasCollisionDetection {
  late final RouterComponent router;

  late final List<Sprite> groundSprites;
  late final List<Sprite> yummySprites;
  late final List<Sprite> uiSprites;
  static final _random = Random();

  int score = 0;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    if(debugMode) {
      add(FpsTextComponent(position: Vector2(20, 20)));
    }

    add(
      router = RouterComponent(
        routes: {
          'menu': Route(MenuScreen.new, maintainState: false),
          'game': WorldRoute(() {GameLogger().i("game screen in route");return GameScreen();}, maintainState: false),
          'pause': Route(PauseScreen.new),
          'lose': Route(() => LoseScreen(score), maintainState: false),
          'authors': Route(AuthorScreen.new),
        },
        initialRoute: 'menu',
      ),
    );

    //await _loadAllAssets();
  }

  Future<void> loadAllAssets() async {
    GameLogger().i("Loading all game assets...");

    groundSprites = await Future.wait(
      StandartTile.spritePaths.map((path) => loadSprite(path)),
    );

    yummySprites = await Future.wait(
      Yummy.spritePaths.map((path) => loadSprite(path)),
    );

    uiSprites = await Future.wait(
      [
        'ui/authors_button.png',
        'ui/play_button.png',
        'ui/background_menu.png',
        'ui/pause_background.png',
        'icons/heart.png',
        'ui/pause_button.png',
        'ui/home_button.png',
        'ui/replay_button.png',
        'ui/back_button.png',
        'ui/game_button.png',
      ].map((path) => loadSprite(path))
    );

    GameLogger().i("All assets loaded");
  }

  Sprite getRandomGroundSprite() {
    return groundSprites[_random.nextInt(groundSprites.length)];
  }

  Sprite getRandomYummySprite() {
    return yummySprites[_random.nextInt(yummySprites.length)];
  }

  void restartGame() {
    world.removeFromParent();
    world = GameScreen();
  }
}
