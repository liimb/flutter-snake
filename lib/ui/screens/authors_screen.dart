import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../../snake_game.dart';

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
  }
}
