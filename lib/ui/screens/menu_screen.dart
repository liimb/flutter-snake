import 'package:flame/components.dart';
import 'package:flutter/rendering.dart';
import 'package:snakegame/helpers/storage_service.dart';
import 'package:snakegame/ui/custom_button.dart';
import '../../common/game_constants.dart';
import '../../snake_game.dart';
import 'dart:ui' as ui;

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
  late final CustomButton _playButton;
  late final CustomButton _authorsButton;

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    _logo.position = Vector2(size.x / 2, size.y / 4);
    _scoreText.position = Vector2(size.x / 2, _logo.y + 80);
    _cup.position = Vector2(size.x / 2 - 25, _logo.y + 80);
    _playButton.position = Vector2(size.x / 2, _logo.y + 200);
    _authorsButton.position = Vector2(size.x / 2, _logo.y + 300);
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();

    add(
      RectangleComponent(
          size: game.size,
          paint: Paint()
            ..shader = ui.Gradient.linear(
              Offset(0, 0),
              Offset(0, game.size.y),
              [
                const Color(0xFF1A4D2E),
                const Color(0xFF000000),
              ],
            ),
          priority: -5
      ),
    );

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

    _playButton = CustomButton(
        action: () => game.router.pushReplacementNamed('game'),
        butSize: 230,
        butSprite: game.uiSprites[1]
    );

    _authorsButton = CustomButton(
      action: () => game.router.pushReplacementNamed('authors'),
      butSize: 230,
      butSprite: game.uiSprites[0]
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
      // SpriteComponent(
      //   sprite: game.uiSprites[2],
      //   size: game.size,
      //   anchor: Anchor.topLeft,
      //   position: Vector2.zero()
      // )..priority = -1,
      _logo,
      _scoreText,
      _cup,
      _playButton,
      _authorsButton,
    ]);
  }
}
