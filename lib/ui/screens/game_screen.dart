import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:snakegame/components/snake.dart';
import 'package:snakegame/helpers/logger_service.dart';
import 'package:snakegame/ui/tile_map.dart';
import '../../common/direction.dart';
import '../../snake_game.dart';

class GameScreen extends World with HasGameReference<SnakeGame>, TapCallbacks, DragCallbacks {

  late final TileMap _tileMap;
  late final Snake _snake;
  Vector2? _dragStartPosition;
  Vector2? _lastDragPosition;

  @override
  Future<void> onLoad() async {
    _tileMap = TileMap(game);
    await _tileMap.onLoad();
    _snake = Snake(_tileMap, 10);

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
    super.onDragEnd(event);
    if (_dragStartPosition == null || _lastDragPosition == null) return;

    final delta = _lastDragPosition! - _dragStartPosition!;
    _dragStartPosition = null;
    _lastDragPosition = null;

    if (delta.x.abs() > delta.y.abs()) {
      if (delta.x > 0) {
        _onSnakeSwipe(Direction.right);
      } else {
        _onSnakeSwipe(Direction.left);
      }
    } else {
      if (delta.y > 0) {
        _onSnakeSwipe(Direction.down);
      } else {
        _onSnakeSwipe(Direction.up);
      }
    }
  }

  void _onSnakeSwipe(Direction dir) {
    GameLogger().e(dir.name);
    _snake.onSwipe(dir);
  }
}