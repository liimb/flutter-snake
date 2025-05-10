import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../../snake_game.dart';
import '../custom_button.dart';
import 'dart:ui' as ui;

class AuthorCredits {
  final String name;
  AuthorCredits({required this.name});
}

class AuthorScreen extends Component with HasGameReference<SnakeGame> {
  final List<AuthorCredits> authors = [
    AuthorCredits(name: 'Теницкий Артемий Сергеевич'),
    AuthorCredits(name: 'Шушакова Виктория Александровна'),
    AuthorCredits(name: 'Кабденов Муса Токсановив'),
    AuthorCredits(name: 'Сысоев Иван Сергеевич'),
    AuthorCredits(name: 'Губарева Мария Алексеевна'),
  ];

  @override
  Future<void> onLoad() async {
    add(
      RectangleComponent(
        size: game.size,
        paint: Paint()
          ..shader = ui.Gradient.linear(
            Offset(0, 0), // сверху
            Offset(0, game.size.y), // вниз
            [
              const Color(0xFF1A4D2E), // светло-зелёный
              const Color(0xFF000000), // чёрный
            ],
          ),
        priority: -5
      ),
    );

    final centerX = game.size.x / 2;
    final maxTextWidth = game.size.x * 0.8;
    double yPosition = game.size.y * 0.03;

    final snakeSprite = await game.loadSprite('yummies/coffee_espresso.png');

    final titleGroup = PositionComponent(
      position: Vector2(centerX, yPosition),
      anchor: Anchor.topCenter,
    );

    const titleIconSize = 40.0;
    const titleSpacing = 10.0;

    titleGroup.add(SpriteComponent(
      sprite: snakeSprite,
      size: Vector2.all(titleIconSize),
      position: Vector2(-maxTextWidth / 3, 20),
      anchor: Anchor.topCenter,
    ));

    titleGroup.add(TextBoxComponent(
      text: 'Авторы проекта:',
      textRenderer: TextPaint(
        style: TextStyle(
          fontSize: 32,
          color: const Color(0xFFC8FFF5),
          fontFamily: 'PixelifySans',
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(blurRadius: 8, color: Colors.black54, offset: Offset(2, 2)),
          ],
        ),
      ),
      boxConfig: TextBoxConfig(
        maxWidth: maxTextWidth - titleIconSize - titleSpacing,
        timePerChar: 0.0,
      ),
      position: Vector2(titleIconSize + titleSpacing, 0),
      anchor: Anchor.topCenter,
    ));

    add(titleGroup);
    yPosition += 120;

    final icon = await game.loadSprite('yummies/vegetable_tomato.png');

    for (var author in authors) {

      final group = PositionComponent(
        position: Vector2(centerX, yPosition),
        anchor: Anchor.topCenter,
      );

      group.add(SpriteComponent(
        sprite: icon,
        size: Vector2(24, 24),
        position: Vector2(-maxTextWidth / 2.2, 20),
        anchor: Anchor.topLeft,
      ));

      group.add(TextBoxComponent(
        text: author.name,
        textRenderer: TextPaint(
          style: TextStyle(
            fontSize: 24,
            color: const Color(0xFFC8FFF5),
            fontFamily: 'PixelifySans',
            shadows: [Shadow(blurRadius: 5, color: Colors.black38, offset: Offset(1, 1))],
          ),
        ),
        boxConfig: TextBoxConfig(
          maxWidth: maxTextWidth - 30,
          timePerChar: 0.0,
        ),
        position: Vector2(30, 0),
        anchor: Anchor.topCenter,
      ));

      add(group);
      yPosition += 90;
    }

    add(CustomButton(
      action: () => game.router.pushReplacementNamed("menu"),
      butSize: 70,
      butSprite: game.uiSprites[8],
      anchor: Anchor.center,
      position: Vector2(game.size.x / 2, game.size.y * 0.9),
    ));
  }
}