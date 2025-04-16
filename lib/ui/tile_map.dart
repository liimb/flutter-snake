import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:snakegame/components/border_tile.dart';
import 'package:snakegame/helpers/logger_service.dart';

import '../common/game_constants.dart';
import '../snake_game.dart';

class TileMap extends PositionComponent {
  TileMap(this.gameRef, {super.key});

  final SnakeGame gameRef;

  late Paint primary;
  late Paint secondary;
  late Paint border;

  late List<List<Rect>> boardCells;
  late int columns;
  late int rows;

  double get cellSize => GameConstants.snakeSize;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    position = Vector2(-gameRef.size.x / 2, -gameRef.size.y / 2);

    primary = Paint()..color = Color(0xFF5696ab);
    secondary = Paint()..color = Color(0xFF93bcc7);
    border = Paint()..color = Color(0xFF043c6c);

    columns = (gameRef.size.x / cellSize).floor();
    rows = (gameRef.size.y / cellSize).floor() - 4;

    GameLogger().i("${columns} ${rows}");

    _generateBoard();
  }

  void _generateBoard() {
    boardCells = List.generate(columns, (i) {
      return List.generate(rows, (j) {
        final rect = Rect.fromLTWH(
          i * cellSize,
          j * cellSize + GameConstants.snakeSize * 4,
          cellSize,
          cellSize,
        );

        final isBorder = (i == 0 || i == columns - 1 || j == 0 || j == rows - 1);
        if (isBorder) {
          final block = BorderTile(rect);
          add(block);
        }
        return rect;
      });
    });
  }

  @override
  void render(Canvas canvas) {
    for (int i = 0; i < columns; i++) {
      for (int j = 0; j < rows; j++) {
        final rect = boardCells[i][j];
        final paint = (i == 0 || i == columns - 1 || j == 0 || j == rows - 1) ? border : ((i + j).isEven ? secondary : primary);
        canvas.drawRect(rect, paint);
      }
    }
  }
}
