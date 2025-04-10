import 'package:flame/components.dart';
import 'package:snakegame/ui/tile_map.dart';
import '../../snake_game.dart';

class GameScreen extends World with HasGameReference<SnakeGame> {

  @override
  Future<void> onLoad() async {
    addAll([
      TileMap(game, boardSize: Vector2(1000, 1000))
    ]);

  }
}