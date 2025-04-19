import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:snakegame/components/snake/snake.dart';
import 'package:snakegame/components/yummy.dart';
import 'package:snakegame/helpers/logger_service.dart';
import 'package:snakegame/components/map/tile_map.dart';
import '../../common/direction.dart';
import '../../components/ui/back_button.dart';
import '../../components/ui/pause_button.dart';
import '../../snake_game.dart';
import 'dart:async';

class GameScreen extends World with HasGameReference<SnakeGame>, TapCallbacks, DragCallbacks {
  late final TileMap _tileMap;
  late final Snake _snake;
  Vector2? _dragStartPosition;
  Vector2? _lastDragPosition;

  final hudComponents = <Component>[];

  @override
  void onMount() {
    super.onMount();
    hudComponents.addAll([
      BackButton(),
      PauseButton(),
    ]);
    game.camera.viewport.addAll(hudComponents);
  }

  @override
  void onRemove() {
    game.camera.viewport.removeAll(hudComponents);
    super.onRemove();
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    loadGame();
  }

  Future<void> loadGame() async {
    _tileMap = TileMap(game);
    add(_tileMap);
    _snake = Snake(
        _tileMap,
        (_tileMap.columns / 3).floor(),
            (SpriteComponent yummy) {remove(yummy); spawnYummy();}
    );
    add(_snake);

    spawnYummy();
  }

  @override
  void update(double dt) {
    super.update(dt);
    _snake.update(dt);
  }

  void spawnYummy() {
    Vector2 pos = _calculateYummyPosition();

    final currentYummy = Yummy(pos);
    add(currentYummy);

    GameLogger().i("yummy spawn: $pos");
  }

  Vector2 _calculateYummyPosition() {
    final occupied = _snake.getOccupiedGridPositions(_tileMap);
    final freeCells = _tileMap.getFreeCells(occupied);

    if (freeCells.isEmpty) return _tileMap.center;

    final cell = (freeCells..shuffle()).first;
    final rect = _tileMap.boardCells[cell.i][cell.j];

    final pos = Vector2(
      _tileMap.position.x + rect.left,
      _tileMap.position.y + rect.top,
    );

    return pos;
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