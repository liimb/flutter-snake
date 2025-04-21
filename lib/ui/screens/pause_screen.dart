import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:snakegame/common/game_constants.dart';
import 'package:snakegame/snake_game.dart';
import '../rounded_button.dart';
import 'game_screen.dart';

class PauseScreen extends PositionComponent with HasGameReference<SnakeGame> {
  PauseScreen();

  final pixelTextStyle = TextPaint(
    style: const TextStyle(
      fontSize: 32,
      color: Color(0xFFFFFFFF),
      fontFamily: 'PixelifySans',
      fontWeight: FontWeight.w900,
    ),
  );

  @override
  Future<void> onLoad() async {
    size = game.size;
    anchor = Anchor.topLeft;

    // 🔹 Полупрозрачный фон (затемнение)
    final background = RectangleComponent(
      size: size,
      paint: Paint()..color = const Color(0xAA000000),
      anchor: Anchor.topLeft,
    );

    // 🔹 Панелька в центре
    final panel = RectangleComponent(
      size: Vector2(size.x * 0.9, size.y * 0.5),
      position: size / 2,
      anchor: Anchor.center,
      paint: Paint()..color = const Color(0xFF222222),
      children: [
        // Текст "Пауза"
        TextComponent(
          text: "Пауза",
          anchor: Anchor.topCenter,
          position: Vector2(size.x * 0.9 / 2, 20),
          textRenderer: pixelTextStyle,
        ),

        // Кнопка "Продолжить"
        RoundedButton(
          text: 'Заново',
          textRenderer: pixelTextStyle,
          action: () => {game.router.pop(), game.router.pushReplacementNamed("game")},
          color: const Color(0xFF4B8178),
          borderColor: const Color(0xffedffab),
          width: 150,
          height: 50,
        )..position = Vector2(size.x * 0.9 / 2, 110),

        RoundedButton(
          text: 'Меню',
          textRenderer: pixelTextStyle,
          action: () {
            game.router.pop();
            game.router.pushReplacementNamed("menu");
          },
          color: const Color(0xFF4B8178),
          borderColor: const Color(0xffedffab),
          width: 150,
          height: 50,
        )..position = Vector2(size.x * 0.9 / 2, 170),

        RoundedButton(
          text: 'Продолжить',
          textRenderer: pixelTextStyle,
          action: () => {game.router.pop(), (game.world as GameScreen).snake.speed = GameConstants.snakeSpeed},
          color: const Color(0xFF4B8178),
          borderColor: const Color(0xffedffab),
          width: 150,
          height: 50,
        )..position = Vector2(size.x * 0.9 / 2, 230)
      ],
    );
    addAll([background, panel]);
  }
}