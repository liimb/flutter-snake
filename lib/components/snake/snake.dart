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

class Snake extends Component with HasGameRef<SnakeGame> {
  Snake(this._tilemap, this.snakeLength, this.onYummyEaten, {super.key});

  final TileMap _tilemap;
  final int snakeLength;
  late final void Function(SpriteComponent yummy) onYummyEaten;

  double speed = GameConstants.snakeSpeed;

  late Vector2 _direction = Vector2.zero();
  late Vector2 _startPos;

  final List<SnakePart> snakeParts = [];

  @override
  Future<void> onLoad() async {
    super.onLoad();
    loadSnake();
  }

  void loadSnake() {
    final centerI = _tilemap.boardCells.length ~/ 2;
    final centerJ = _tilemap.boardCells[0].length ~/ 2;
    final centerRect = _tilemap.boardCells[centerI][centerJ];
    _startPos = Vector2(centerRect.left, centerRect.top) + _tilemap.position; //если квадратная
    //_startPos = Vector2(centerRect.left / 2, centerRect.top / 2) + _tilemap.position; //если круглая + заменить отрисовку частей

    _direction = Vector2.zero();

    for (int i = 0; i < snakeLength; i++) {
      GameLogger().e(i.toString());
      Vector2 pos = _startPos - Vector2(i.toDouble() * GameConstants.snakeSize, 0);
      SnakePart part;

      if (i == 0) {
        part = SnakeHead(pos.clone(), this, onYummyEaten);
      } else if (i >= 3) {
        part = SnakeBorder(pos.clone());
      } else {
        part = SnakePart(pos.clone());
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

      final toTarget = part.to - part.position;
      final distance = speed * dt;

      if (toTarget.length <= distance) {
        part.position = part.to.clone();
      } else {
        part.position += toTarget.normalized() * distance;
      }
    }

    SnakePart head = snakeParts.first;
    if ((head.to - head.position).length < 0.1) {
      head.to += _direction * GameConstants.snakeSize;

      for (int i = 1; i < snakeParts.length; i++) {
        snakeParts[i].to = snakeParts[i - 1].position.clone();
      }
    }
  }

  List<TilePosition> getOccupiedGridPositions(TileMap tileMap) {
    return snakeParts.map((part) {

      final i = (part.x - tileMap.position.x).floor();
      final j = (part.y - tileMap.position.y).floor();

      return TilePosition(i, j);
    }).toList();
  }

  void addBorderPart() {
    if (snakeParts.isEmpty) return;

    final lastPart = snakeParts.last;

    final tailPosition = lastPart.position.clone();

    final newPart = SnakeBorder(tailPosition)
      ..position = tailPosition
      ..to = tailPosition;

    snakeParts.add(newPart);
    add(newPart);
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

    if(_direction == Vector2.zero() && direction == Direction.left) return;

    if (newDir + _direction != Vector2.zero()) {
      _direction = newDir;
    }
  }
}
