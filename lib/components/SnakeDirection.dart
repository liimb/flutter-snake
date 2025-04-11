enum Direction { up, down, left, right }

class SnakeDirection {
  Direction direction = Direction.right;

  void changeDirection(Direction newDirection) {
    if (newDirection == Direction.up && direction != Direction.down) {
      direction = Direction.up;
    } else if (newDirection == Direction.down && direction != Direction.up) {
      direction = Direction.down;
    } else if (newDirection == Direction.left && direction != Direction.right) {
      direction = Direction.left;
    } else if (newDirection == Direction.right && direction != Direction.left) {
      direction = Direction.right;
    }
  }
}