class TilePosition {
  final int i;
  final int j;

  TilePosition(this.i, this.j);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is TilePosition &&
              runtimeType == other.runtimeType &&
              i == other.i &&
              j == other.j;

  @override
  int get hashCode => i.hashCode ^ j.hashCode;
}