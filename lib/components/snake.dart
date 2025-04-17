import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:snakegame/helpers/logger_service.dart';
import 'package:snakegame/ui/tile_map.dart';

import '../common/direction.dart';
import '../common/game_constants.dart';
import '../snake_game.dart';

class Snake extends Component with HasGameRef<SnakeGame> {
  Snake(this._tilemap, this.snakeLength, {super.key});

  late final Vector2 _startPos;
  final int snakeLength;

  final TileMap _tilemap;

  List<Vector2> snakeParts = [];
  late Vector2 _direction;
  double speed = GameConstants.snakeSpeed;
  late Vector2 _nextTargetPosition;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    final centerI = _tilemap.boardCells.length ~/ 4;
    final centerJ = _tilemap.boardCells[0].length ~/ 2;
    final centerRect = _tilemap.boardCells[centerI][centerJ];
    _startPos = Vector2(centerRect.left, centerRect.top) + _tilemap.position;

    GameLogger().i(_startPos.toString());

    for (int i = 0; i < snakeLength; i++) {
      snakeParts.add(_startPos.clone());
    }

    _direction = Vector2(0, 0);

    _nextTargetPosition = _startPos + _direction * GameConstants.snakeSize;
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (snakeParts.isEmpty) return;

    Vector2 head = snakeParts.first;
    Vector2 toTarget = _nextTargetPosition - head;

    if (toTarget.length <= speed * dt) {
      final newHead = _nextTargetPosition.clone();
      snakeParts.insert(0, newHead);
      snakeParts.removeLast();
      _nextTargetPosition = newHead + _direction * GameConstants.snakeSize;
    } else {
      Vector2 newHead = head + toTarget.normalized() * speed * dt;
      snakeParts[0] = newHead;
    }
  }


  void onSwipe(Direction direction) {
    switch (direction) {
      case Direction.up:
        if(_direction != Vector2(0, 1)) {_direction = Vector2(0, -1);};
        break;
      case Direction.down:
        if(_direction != Vector2(0, -1)) {_direction = Vector2(0, 1);};
        break;
      case Direction.left:
        if(_direction != Vector2(1, 0)) {_direction = Vector2(-1, 0);};
        break;
      case Direction.right:
        if(_direction != Vector2(-1, 0)) {_direction = Vector2(1, 0);};
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