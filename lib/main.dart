import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'snake_game.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: GameWidget(game: SnakeGame()),
      ),
    ),
  );
}
