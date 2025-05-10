import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:snakegame/common/game_constants.dart';
import 'package:snakegame/snake_game.dart';
import '../custom_button.dart';
import 'game_screen.dart';

class PauseScreen extends PositionComponent with HasGameReference<SnakeGame> {
  PauseScreen();

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
      TextComponent(
        text: "Пауза",
        anchor: Anchor.topCenter,
        position: Vector2(centerX, topY + 20),
        textRenderer: pixelTextStyle,
      ),

      CustomButton(
        action: () => {
          game.router.pop(),
          game.restartGame()
        },
        butSize: 110,
        butSprite: game.uiSprites[7],
        position: Vector2(centerX + panelWidth / 4.5, topY + panelHeight - 170),
      ),
      CustomButton(
          action: () => {
            game.router.pop(),
            game.router.pushReplacementNamed("menu")
          },
          butSize: 110,
          butSprite: game.uiSprites[6],
          position: Vector2(centerX - panelWidth / 4.5, topY + panelHeight - 170)
      ),

      CustomButton(
          action: () => {
            game.router.pop(),
            (game.world as GameScreen).snake.speed = GameConstants.snakeSpeed
          },
          butSize: 110,
          butSprite: game.uiSprites[9],
          position: Vector2(centerX, topY + panelHeight - 70)
      ),
    ]);
  }
}
