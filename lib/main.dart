import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snakegame/common/game_constants.dart';

import 'snake_game.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(
    MaterialApp(
      home: Scaffold(
        body: GameWidget(
          game: SnakeGame()..debugMode = GameConstants.debugMode,
        ),
      ),
    ),
  );
}
