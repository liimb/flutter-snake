import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:snakegame/snake_game.dart';
import '../rounded_button.dart';

class LoseScreen extends PositionComponent with HasGameReference<SnakeGame> {
  LoseScreen();

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

    final background = RectangleComponent(
      size: size,
      paint: Paint()..color = const Color(0xAA000000),
      anchor: Anchor.topLeft,
    );

    final panel = RectangleComponent(
      size: Vector2(size.x * 0.9, size.y * 0.5),
      position: size / 2,
      anchor: Anchor.center,
      paint: Paint()..color = const Color(0xFF222222),
      children: [

        TextComponent(
          text: "Ваш счет:",
          anchor: Anchor.topCenter,
          position: Vector2(size.x * 0.9 / 2, 20),
          textRenderer: pixelTextStyle,
        ),

        RoundedButton(
          text: 'Заново',
          textRenderer: pixelTextStyle,
          action: ()  {
            game.router.pop();
            game.restartGame();
          },
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
      ],
    );
    addAll([background, panel]);
  }
}