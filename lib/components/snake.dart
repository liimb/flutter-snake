import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../common/game_constants.dart';
import '../snake_game.dart';
import 'SnakeDirection.dart';

class Snake extends Component with HasGameRef<SnakeGame> {
  Snake(this._startPos, this.snakeLength, {super.key});

  final Vector2 _startPos;
  final int snakeLength;

  List<Vector2> snakeParts = [];
  late Vector2 _direction;
  double speed = GameConstants.snakeSpeed;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    for (int i = 0; i < snakeLength; i++) {
      snakeParts.add(_startPos + Vector2(-i * GameConstants.snakeSize, 0));
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
        if (_direction != Vector2(0, 1)) _direction = Vector2(0, -1);
        break;
      case Direction.down:
        if (_direction != Vector2(0, -1)) _direction = Vector2(0, 1);
        break;
      case Direction.left:
        if (_direction != Vector2(1, 0)) _direction = Vector2(-1, 0);
        break;
      case Direction.right:
        if (_direction != Vector2(-1, 0)) _direction = Vector2(1, 0);
        break;
    }
  }

  @override
  void render(Canvas canvas) {
    final paint = Paint()..color = Colors.green;

    for (var part in snakeParts) {
      canvas.drawRect(Rect.fromLTWH(part.x, part.y, GameConstants.snakeSize, GameConstants.snakeSize), paint);
    }
  }
}