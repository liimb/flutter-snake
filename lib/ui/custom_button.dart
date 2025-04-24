import 'package:flame/components.dart';
import 'package:flame/events.dart';

class CustomButton extends SpriteComponent with TapCallbacks {

  CustomButton({
    required this.action,
    required this.butSprite,
    required this.butSize,
    super.position,
    super.anchor = Anchor.center,
  });

  final void Function() action;
  final Sprite butSprite;
  final double butSize;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    sprite = butSprite;

    final originalSize = sprite!.originalSize;
    final scaleFactor = butSize / originalSize.x;
    size = originalSize * scaleFactor;
  }
  @override

  @override
  void onTapDown(TapDownEvent event) {
    scale = Vector2.all(1.05);
  }
  @override
  void onTapCancel(TapCancelEvent event) {
    scale = Vector2.all(1.0);
    action();
  }
}
