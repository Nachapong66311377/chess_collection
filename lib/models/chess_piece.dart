class ChessPiece {
  final int? id;
  final String name;
  final String type; // King, Queen, Pawn, etc.
  final String color; // White / Black
  final double value; // คะแนนเชิงตัวเลข
  final String material; // วัสดุของหมากรุก เช่น ไม้ โลหะ คริสตัล
  final int year;         // ปีที่ผลิต

  ChessPiece({
    this.id,
    required this.name,
    required this.type,
    required this.color,
    required this.value,
    required this.material,
    required this.year,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'color': color,
      'value': value,
      'material': material,
      'year': year,
    };
  }

  factory ChessPiece.fromMap(Map<String, dynamic> map) {
  return ChessPiece(
    id: map['id'] as int?,
    name: map['name'] as String,
    type: map['type'] as String,
    color: map['color'] as String,
    value: (map['value'] as num).toDouble(), // แปลง int เป็น double
    material: map['material'] as String,
    year: map['year'] as int,
  );
}


}
