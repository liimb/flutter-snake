import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:snakegame/components/snake.dart';
import 'package:snakegame/helpers/logger_service.dart';
import 'package:snakegame/ui/tile_map.dart';
import '../../components/SnakeDirection.dart';
import '../../snake_game.dart';

class GameScreen extends World with HasGameReference<SnakeGame>, TapCallbacks, DragCallbacks {

  late final TileMap _tileMap;
  late final Snake _snake;
  late SnakeDirection snakeDirection = SnakeDirection();
  Vector2? _dragStartPosition;
  Vector2? _lastDragPosition;

  @override
  Future<void> onLoad() async {
    _tileMap = TileMap(game);
    await _tileMap.onLoad();
    _snake = Snake(_tileMap, 100);

    addAll([
       _tileMap,
      _snake
    ]);
  }

  @override
  void update(double dt) {
    super.update(dt);
    _snake.update(dt);
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);

    final position = event.localPosition;
    final width = game.size.x;
    final height = game.size.y;

    if (position.y < height / 3) {
      snakeDirection.changeDirection(Direction.up);
    } else if (position.y > height * 2 / 3) {
      snakeDirection.changeDirection(Direction.down);
    } else if (position.x < width / 3) {
      snakeDirection.changeDirection(Direction.left);
    } else if (position.x > width * 2 / 3) {
      snakeDirection.changeDirection(Direction.right);
    }
  }

  @override
  void onDragStart(DragStartEvent event) {
    _dragStartPosition = event.localPosition;
    _lastDragPosition = _dragStartPosition;
    super.onDragStart(event);
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    _lastDragPosition = event.localEndPosition;
    super.onDragUpdate(event);
  }

  @override
  void onDragEnd(DragEndEvent event) {
    if (_dragStartPosition == null || _lastDragPosition == null) return;

    final delta = _lastDragPosition! - _dragStartPosition!;
    _dragStartPosition = null;
    _lastDragPosition = null;

    if (delta.x.abs() > delta.y.abs()) {
      if (delta.x > 0) {
        snakeDirection.changeDirection(Direction.right);
      } else {
        snakeDirection.changeDirection(Direction.left);
      }
    } else {
      if (delta.y > 0) {
        snakeDirection.changeDirection(Direction.down);
      } else {
        snakeDirection.changeDirection(Direction.up);
      }
    }

    GameLogger().e(snakeDirection.direction.name);

    _snake.onSwipe(snakeDirection.direction);

    super.onDragEnd(event);
  }
}