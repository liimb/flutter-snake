import 'dart:math';

import 'package:flame/components.dart';
import 'package:snakegame/components/snake/snake_border.dart';
import 'package:snakegame/components/snake/snake_head.dart';
import 'package:snakegame/components/snake/snake_part.dart';
import 'package:snakegame/components/map/tile_position.dart';
import 'package:snakegame/helpers/logger_service.dart';
import 'package:snakegame/components/map/tile_map.dart';

import '../../common/direction.dart';
import '../../common/game_constants.dart';
import '../../snake_game.dart';

class Snake extends Component with HasGameReference<SnakeGame> {
  Snake(this._tilemap, this.snakeLength, this.onYummyEaten, {super.key});

  final TileMap _tilemap;
  final int snakeLength;
  late final void Function(SpriteComponent yummy) onYummyEaten;

  double speed = GameConstants.snakeSpeed;

  late Vector2 _direction = Vector2.zero();
  late Vector2 _startPos;

  final List<SnakePart> snakeParts = [];

  final List<Vector2> _directionQueue = [];

  @override
  Future<void> onLoad() async {
    super.onLoad();
    loadSnake();
  }

  void loadSnake() {
    final centerI = _tilemap.boardCells.length ~/ 2;
    final centerJ = _tilemap.boardCells[0].length ~/ 2;
    final centerRect = _tilemap.boardCells[centerI][centerJ];
    //_startPos = Vector2(centerRect.left, centerRect.top) + _tilemap.position; //если квадратная
    _startPos = Vector2(centerRect.center.dx, centerRect.center.dy) + _tilemap.position; //если круглая + заменить отрисовку частей

    _direction = Vector2.zero();

    for (int i = 0; i < snakeLength; i++) {
      GameLogger().e(i.toString());
      Vector2 pos = _startPos - Vector2(i.toDouble() * GameConstants.snakeSize, 0);
      SnakePart part;

      if (i == 0) {
        part = SnakeHead(pos.clone(), Vector2.all(GameConstants.snakeSize + 7), this, onYummyEaten);
      } else if (i >= 3) {
        part = SnakeBorder(pos.clone(), Vector2.all(GameConstants.snakeSize));
      } else {
        part = SnakePart(pos.clone(), Vector2.all(GameConstants.snakeSize));
      }

      part.position = pos.clone();
      snakeParts.add(part);
      add(part);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (_direction == Vector2.zero()) return;

    for (int i = 0; i < snakeParts.length; i++) {
      SnakePart part = snakeParts[i];

      if (part.to == part.position) continue;

      final toTarget = part.to - part.position; // - Vector2((GameConstants.snakeSize - GameConstants.snakeSize * part.scale.x) * _getGridAlignedDirection(part.position - part.to).x, (GameConstants.snakeSize - GameConstants.snakeSize * part.scale.x) * _getGridAlignedDirection(part.position - part.to).y);
      final distance = speed * dt;

      if (toTarget.length <= distance) {
        part.position = part.to.clone();// - Vector2((GameConstants.snakeSize - GameConstants.snakeSize * part.scale.x) * _getGridAlignedDirection(part.position - part.to).x, (GameConstants.snakeSize - GameConstants.snakeSize * part.scale.x) * _getGridAlignedDirection(part.position - part.to).y);
      } else {
        part.position += toTarget.normalized() * distance;// - Vector2((GameConstants.snakeSize - GameConstants.snakeSize * part.scale.x) * _getGridAlignedDirection(part.position - part.to).x, (GameConstants.snakeSize - GameConstants.snakeSize * part.scale.x) * _getGridAlignedDirection(part.position - part.to).y);
      }

      if (toTarget.length >= distance + 0.1) {
        part.targetAngle = getAngleFromVector(toTarget);
      }
    }

    SnakePart head = snakeParts.first;
    if ((head.to - head.position).length < 0.5) {

      if (_directionQueue.isNotEmpty) {
        _direction = _directionQueue.removeAt(0);
      }

      head.to += _direction * GameConstants.snakeSize;

      for (int i = 1; i < snakeParts.length; i++) {
          final prev = snakeParts[i - 1];
          final current = snakeParts[i];

          // Vector2 rawDirection = prev.position - current.position;
          // Vector2 direction = _getGridAlignedDirection(rawDirection);
          //
          // GameLogger().w((direction).toString());

          current.to = prev.position.clone();//- Vector2((GameConstants.snakeSize - GameConstants.snakeSize * current.scale.x) * direction.x, (GameConstants.snakeSize - GameConstants.snakeSize * current.scale.x) * direction.y);// * _direction.x, (GameConstants.snakeSize - current.size.x) * _direction.y);
      }
    }
  }

  Vector2 _getGridAlignedDirection(Vector2 direction) {
    if (direction.x.abs() > direction.y.abs()) {
      return direction.x > 0 ? Vector2(1, 0) : Vector2(-1, 0);
    } else {
      return direction.y > 0 ? Vector2(0, 1) : Vector2(0, -1);
    }
  }

  List<TilePosition> getOccupiedGridPositions(TileMap tileMap) {
    return snakeParts
        .map((part) => toTile(part.position))
        .toSet()
        .toList();
  }

  double baseScale = 1;
  double scaleFactor = 0.97;
  double minScale = 0.75;

  double getScaled(int index) {
    if (index < 4) return baseScale;
    double size = baseScale * pow(scaleFactor, index - 4);
    return size < minScale ? minScale : size;
  }

  void addBorderPart() {
    if (snakeParts.isEmpty) return;

    final lastPart = snakeParts.last;

    final tailPosition = lastPart.position.clone();

    final size = Vector2.all(GameConstants.snakeSize);

    final newPart = SnakeBorder(tailPosition, size)
      ..position = tailPosition
      ..to = tailPosition;

    //newPart.scale = Vector2.all(getScaled(snakeParts.length));

    snakeParts.add(newPart);

    GameLogger().i("snake length: ${snakeParts.length}");

    add(newPart);
  }

  double getAngleFromVector(Vector2 dir) {
    if (dir.x == 0 && dir.y < 0) return -pi / 2; // вверх
    if (dir.x == 0 && dir.y > 0) return pi / 2;  // вниз
    if (dir.x < 0 && dir.y == 0) return pi;  // влево
    return 0.0;                                  // вправо (по умолчанию)
  }

  TilePosition toTile(Vector2 pos) {
    final localX = pos.x - _tilemap.position.x;
    final localY = pos.y - _tilemap.position.y;

    final i = (localX / _tilemap.cellSize).floor();
    final j = (localY / _tilemap.cellSize).floor();

    return TilePosition(i, j);
  }

  void onSwipe(Direction direction) {
    Vector2 newDir;
    switch (direction) {
      case Direction.up:
        newDir = Vector2(0, -1);
        break;
      case Direction.down:
        newDir = Vector2(0, 1);
        break;
      case Direction.left:
        newDir = Vector2(-1, 0);
        break;
      case Direction.right:
        newDir = Vector2(1, 0);
        break;
    }

    if (_direction == Vector2.zero()) {
      if (newDir == Vector2(-1, 0)) return;
      _direction = newDir;
      return;
    }

    final lastDir = _directionQueue.isNotEmpty ? _directionQueue.last : _direction;

    if (lastDir + newDir != Vector2.zero() && speed != 0) {
      _directionQueue.add(newDir);
    }
  }
}
