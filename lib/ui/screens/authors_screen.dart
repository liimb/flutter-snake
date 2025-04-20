import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../../snake_game.dart';
import 'dart:ui';
import 'package:snakegame/components/ui/simple_button.dart';

class AuthorCredits {
  final String name;

  AuthorCredits({
    required this.name,
  });
}

class AuthorScreen extends Component with HasGameReference<SnakeGame> {
  final List<AuthorCredits> authors = [
    AuthorCredits(
      name: 'Теницкий Артемий, студент 1 курса ПМиФИ',
    ),
    AuthorCredits(
      name: 'Шушакова Виктория, студент 1 курса ПМиФИ',
    ),
  ];

  @override
  Future<void> onLoad() async {
    add(
      RectangleComponent(
        size: game.size,
        paint: Paint()..color = const Color(0xFF1A4D2E),
      ),
    );

    final centerX = game.size.x / 2;
    double yPosition = game.size.y * 0.2;

    final snakeSprite = await game.loadSprite('yummies/coffee_espresso.png');

    final titleText = TextComponent(
      text: 'Авторы проекта:',
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: TextStyle(
          fontSize: 36,
          color: const Color(0xFFC8FFF5),
          fontFamily: 'PixelifySans',
          fontWeight: FontWeight.bold,
          shadows: [
          Shadow(
          blurRadius: 10,
          color: Colors.black.withOpacity(0.5),
          offset: const Offset(2, 2),
          )],
        ),
      ),
    );

    const iconSize = 40.0;
    const iconTextSpacing = 15.0;

    final titleGroup = PositionComponent(
      position: Vector2(centerX, yPosition),
      anchor: Anchor.center,
    );

    titleGroup.add(SpriteComponent(
      sprite: snakeSprite,
      size: Vector2.all(iconSize),
      position: Vector2(-titleText.width / 2 - iconSize / 2 - iconTextSpacing, 0),
      anchor: Anchor.center,
    ));

    titleGroup.add(TextComponent(
      text: 'Авторы проекта:',
      anchor: Anchor.center,
      position: Vector2.zero(),
      textRenderer: titleText.textRenderer,
    ));

    add(titleGroup);
    yPosition += 80;

    for (var author in authors) {
      final nameText = TextComponent(
        text: author.name,
        anchor: Anchor.center,
        position: Vector2(centerX, yPosition),
        textRenderer: TextPaint(
          style: TextStyle(
            fontSize: 24,
            color: const Color(0xFFC8FFF5),
            fontFamily: 'PixelifySans',
            shadows: [
              Shadow(
                blurRadius: 5,
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(1, 1),
              ),
            ],
          ),
        ),
      );
      add(nameText);
      yPosition += 60;
    }

    add(BackButton()
      ..position = Vector2(
        game.size.x / 2,
        game.size.y * 0.85,
      )
      ..anchor = Anchor.center);
  }
}

class BackButton extends SimpleButton with HasGameReference<SnakeGame> {
  BackButton()
      : super(
    Path()
      ..moveTo(22, 8)
      ..lineTo(10, 20)
      ..lineTo(22, 32)
      ..moveTo(12, 20)
      ..lineTo(34, 20),
  );

  @override
  void action() => game.router.pushReplacementNamed("menu");
}