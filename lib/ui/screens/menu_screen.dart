import 'package:flame/components.dart';
import 'package:flutter/rendering.dart';
import 'package:snakegame/helpers/storage_service.dart';
import '../../common/game_constants.dart';
import '../../snake_game.dart';
import '../rounded_button.dart';

class MenuScreen extends Component with HasGameReference<SnakeGame> {

  final pixelTextStyle = TextPaint(
    style: const TextStyle(
      fontSize: 32,
      color: Color(0xFFFFFFFF),
      fontFamily: 'PixelifySans',
      fontWeight: FontWeight.w900,
    ),
  );

  late final TextComponent _logo;
  late final TextComponent _scoreText;
  late final SpriteComponent _cup;
  late final RoundedButton _button1;
  late final RoundedButton _button2;

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    _logo.position = Vector2(size.x / 2, size.y / 4);
    _scoreText.position = Vector2(size.x / 2, _logo.y + 80);
    _cup.position = Vector2(size.x / 2 - 25, _logo.y + 80);
    _button1.position = Vector2(size.x / 2, _logo.y + 200);
    _button2.position = Vector2(size.x / 2, _logo.y + 270);
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();

    _logo = TextComponent(
      text: 'Змейка',
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 64,
          color: Color(0xFFFFFFFF),
          fontFamily: 'PixelifySans',
          fontWeight: FontWeight.w900,
        ),
      ),
      anchor: Anchor.center,
    );

    _button1 = RoundedButton(
      text: 'Играть',
      textRenderer: pixelTextStyle,
      action: () => game.router.pushReplacementNamed('game'),
      color: const Color(0xFF4B8178),
      borderColor: const Color(0xffedffab),
      width: 200,
      height: 50,
    );

    _button2 = RoundedButton(
      text: 'Авторы',
      textRenderer: pixelTextStyle,
      action: () => game.router.pushReplacementNamed('authors'),
      color: const Color(0xFF3D5C3B),
      borderColor: const Color(0xffedffab),
      width: 200,
      height: 50,
    );

    _scoreText = TextComponent(
      position: Vector2(game.size.x / 2, GameConstants.mapY / 2),
      text: "0",
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 64,
          color: Color(0xFFFFFFFF),
          fontFamily: 'PixelifySans',
          fontWeight: FontWeight.w900,
        ),
      ),
      anchor: Anchor.centerLeft,
    );

    _cup = SpriteComponent(
        //sprite: cupSprite,
        position: Vector2(-25, -game.size.y / 2 + GameConstants.mapY / 2),
        size: Vector2.all(35),
        anchor: Anchor.center
    );

    final cupSprite = await game.loadSprite('icons/cup.png');
    final score = await StorageService().getScore();

    _cup.sprite = cupSprite;
    _scoreText.text = score.toString();

    addAll([
      _logo,
      _scoreText,
      _cup,
      _button1,
      _button2,
    ]);
  }
}