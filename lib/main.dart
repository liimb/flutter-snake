import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snakegame/common/game_constants.dart';

import 'helpers/storage_service.dart';
import 'snake_game.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  await StorageService().init();

  WidgetsFlutterBinding.ensureInitialized();
  final snakeGame = SnakeGame();
  snakeGame.debugMode = GameConstants.debugMode;
  await snakeGame.loadAllAssets();

  runApp(
    MaterialApp(
      home: Scaffold(
        body: GameWidget(
          game: snakeGame,
        ),
      ),
    ),
  );
}
