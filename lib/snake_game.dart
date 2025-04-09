import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:snakegame/ui/screens/game_screen.dart';
import 'package:snakegame/ui/screens/menu_screen.dart';

class SnakeGame extends FlameGame with TapDetector {
  late final RouterComponent router;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(
      router = RouterComponent(
        routes: {
          'menu': Route(MenuScreen.new),
          'game': WorldRoute(GameScreen.new),
        },
        initialRoute: 'menu',
      ),
    );
  }
}