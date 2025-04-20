import 'package:flame/components.dart';
import 'package:flutter/rendering.dart';
import '../../snake_game.dart';
import '../rounded_button.dart';

class MenuScreen extends Component with HasGameReference<SnakeGame> {

  MenuScreen() {
    addAll([
      _logo = TextComponent(
        text: 'Змейка',
        textRenderer: TextPaint(
          style: const TextStyle(
            fontSize: 64,
            color: Color(0xFFC8FFF5),
            fontFamily: 'PixelifySans',
            fontWeight: FontWeight.w900,
          ),
        ),
        anchor: Anchor.center,
      ),
      _button1 = RoundedButton(
        text: 'Играть',
        textRenderer: TextPaint(
        style: const TextStyle(
        fontSize: 64,
        color: Color(0xFFC8FFF5),
        fontFamily: 'PixelifySans',
        fontWeight: FontWeight.w900,
        ),
    ),

        action: () => {
          game.router.pushReplacementNamed('game')
        },
        color: const Color(0xffadde6c),
        borderColor: const Color(0xffedffab),
      ),
      _button2 = RoundedButton(
        text: 'Авторы',
        textRenderer: TextPaint(
          style: const TextStyle(
            fontSize: 64,
            color: Color(0xFFC8FFF5),
            fontFamily: 'PixelifySans',
            fontWeight: FontWeight.w900,
          ),
        ),
        action: () => game.router.pushReplacementNamed('authors'),
        color: const Color(0xffdebe6c),
        borderColor: const Color(0xfffff4c7),
      ),
    ]);
  }

  late final TextComponent _logo;
  late final RoundedButton _button1;
  late final RoundedButton _button2;

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    _logo.position = Vector2(size.x / 2, size.y / 3);
    _button1.position = Vector2(size.x / 2, _logo.y + 80);
    _button2.position = Vector2(size.x / 2, _logo.y + 140);
  }
}