import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:snakegame/helpers/logger_service.dart';
import 'package:snakegame/ui/tile_map.dart';

import '../common/game_constants.dart';
import '../snake_game.dart';
import 'SnakeDirection.dart';

class Snake extends Component with HasGameRef<SnakeGame> {
  Snake(this._tilemap, this.snakeLength, {super.key});

  late final Vector2 _startPos;
  final int snakeLength;

  final TileMap _tilemap;

  List<Vector2> snakeParts = [];
  late Vector2 _direction;
  double speed = GameConstants.snakeSpeed;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    final centerI = _tilemap.boardCells.length ~/ 4;
    final centerJ = _tilemap.boardCells[0].length ~/ 2;
    final centerRect = _tilemap.boardCells[centerI][centerJ];
    _startPos = Vector2(centerRect.center.dx - GameConstants.snakeSize / 2, centerRect.center.dy - GameConstants.snakeSize / 2) + _tilemap.position;

    GameLogger().i(_startPos.toString());

    for (int i = 0; i < snakeLength; i++) {
      snakeParts.add(_startPos);
    }

    _direction = Vector2(0, 0);
  }

  @override
  void update(double dt) {
    super.update(dt);

    final head = snakeParts.first;
    final newHead = head + _direction * speed * dt;

    snakeParts.insert(0, newHead);
    snakeParts.removeLast();

    if (newHead.x < 0 || newHead.x > gameRef.size.x || newHead.y < 0 || newHead.y > gameRef.size.y) {

    }
  }


  void onSwipe(Direction direction) {
    switch (direction) {
      case Direction.up:
        _direction = Vector2(0, -1);
        break;
      case Direction.down:
        _direction = Vector2(0, 1);
        break;
      case Direction.left:
        _direction = Vector2(-1, 0);
        break;
      case Direction.right:
        _direction = Vector2(1, 0);
        break;
    }
  }

  @override
  void render(Canvas canvas) {
    final paint = Paint()..color = Color(0xFFfcc45c);

    for (var part in snakeParts) {
      canvas.drawRect(Rect.fromLTWH(part.x, part.y, GameConstants.snakeSize, GameConstants.snakeSize), paint);
    }
  }
}