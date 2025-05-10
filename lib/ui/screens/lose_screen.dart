import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:snakegame/snake_game.dart';
import '../custom_button.dart';

class LoseScreen extends PositionComponent with HasGameReference<SnakeGame> {
  LoseScreen(this._score);

  final int _score;

  late final TextPaint pixelTextStyle;

  @override
  Future<void> onLoad() async {
    size = game.size;
    anchor = Anchor.topLeft;

    final screenWidth = size.x;
    final screenHeight = size.y;

    final panelWidth = screenWidth * 0.85;
    final panelHeight = screenHeight * 0.5;

    final fontSize = screenHeight * 0.05;

    pixelTextStyle = TextPaint(
      style: TextStyle(
        fontSize: fontSize,
        color: const Color(0xFFFFFFFF),
        fontFamily: 'PixelifySans',
        fontWeight: FontWeight.w900,
      ),
    );

    final background = RectangleComponent(
      size: size,
      paint: Paint()..color = const Color(0xDB000000),
      anchor: Anchor.topLeft,
    );

    final panel = RectangleComponent(
      size: Vector2(panelWidth, panelHeight),
      position: size / 2,
      anchor: Anchor.center,
      paint: Paint()..color = const Color(0x00000000),
    );

    add(background);
    add(panel);

    final centerX = panel.position.x;
    final topY = panel.position.y - panel.size.y / 2;

    addAll([
      SpriteComponent(
        sprite: game.uiSprites[4],
        position: Vector2(centerX, topY + 70),
        size: Vector2.all(150),
        anchor: Anchor.center,
      ),
      TextComponent(
        text: "Ваш счёт:",
        anchor: Anchor.topCenter,
        position: Vector2(centerX, topY + panelHeight / 2 - 70),
        textRenderer: pixelTextStyle,
      ),
      TextComponent(
        text: _score.toString(),
        anchor: Anchor.topCenter,
        position: Vector2(centerX, topY + panelHeight / 2 - 20),
        textRenderer: pixelTextStyle,
      ),
      CustomButton(
          action: () => {
            game.router.pop(),
            game.restartGame()
          },
          butSize: 110,
          butSprite: game.uiSprites[7],
          position: Vector2(centerX + panelWidth / 4.5, topY + panelHeight - 70),
      ),
      CustomButton(
          action: () => {
            game.router.pop(),
            game.router.pushReplacementNamed("menu")
          },
          butSize: 110,
          butSprite: game.uiSprites[6],
          position: Vector2(centerX - panelWidth / 4.5, topY + panelHeight - 70)
      ),
    ]);
  }
}