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
    double yPosition = 100;

    for (var author in authors) {
      final nameText = TextComponent(
        text: author.name,
        position: Vector2(130, yPosition + 20),
        textRenderer: TextPaint(
          style: const TextStyle(
            fontSize: 30,
            color: Color(0xFFC8FFF5),
          ),
        ),
      );
      add(nameText);
      yPosition += 100;
    }

    add(BackButton());
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
    position: Vector2(50, 50),
  );

  @override
  void action() => game.router.pushReplacementNamed("menu");
}
