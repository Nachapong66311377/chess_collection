class ChessPiece {
  final int? id;
  final String name;
  final String type; // King, Queen, Pawn, etc.
  final String color; // White / Black
  final double value; // คะแนนเชิงตัวเลข

  ChessPiece({
    this.id,
    required this.name,
    required this.type,
    required this.color,
    required this.value,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'color': color,
      'value': value,
    };
  }

  factory ChessPiece.fromMap(Map<String, dynamic> map) {
    return ChessPiece(
      id: map['id'],
      name: map['name'],
      type: map['type'],
      color: map['color'],
      value: map['value'],
    );
  }
}
