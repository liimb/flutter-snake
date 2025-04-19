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
    final centerX = game.size.x / 2;
    double yPosition = game.size.y * 0.3;

    for (var author in authors) {
      final nameText = TextComponent(
        text: author.name,
        anchor: Anchor.center,
        position: Vector2(centerX, yPosition),
        textRenderer: TextPaint(
          style: TextStyle(
            fontSize: 24,
            color: Color(0xFFC8FFF5),
            fontFamily: 'Roboto',
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
