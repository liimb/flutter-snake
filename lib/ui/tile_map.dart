import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../common/game_constants.dart';
import '../snake_game.dart';

class TileMap extends PositionComponent {
  TileMap(this.gameRef, {required this.boardSize, super.key});

  final Vector2 boardSize;
  final SnakeGame gameRef;

  late Paint primary;
  late Paint secondary;

  final Map<Rect, Paint> boardCells = {};

  void _fillBoardCells() {
    for (var i = 0; i < (boardSize.x / GameConstants.snakeSize).floorToDouble(); i++) {
      for (var j = 0; j < (boardSize.y / GameConstants.snakeSize).floorToDouble(); j++) {
        final rect = Rect.fromLTWH(
          i * GameConstants.snakeSize,
          j * GameConstants.snakeSize,
          GameConstants.snakeSize,
          GameConstants.snakeSize,
        );
        final paint = (i + j).isEven ? secondary : primary;

        boardCells.addAll({rect: paint});
      }
    }
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    position = (gameRef.size - boardSize);
    primary = Paint()..color = Colors.grey.withOpacity(.6);
    secondary = Paint()..color = Colors.blue.withOpacity(.6);

    _fillBoardCells();
  }

  @override
  void render(Canvas canvas) {
    for (final cell in boardCells.entries) {
      canvas.drawRect(cell.key, cell.value);
    }
  }
}