class Tag {
  final String id;
  final String name;
  final int color;
  final String userId;

  Tag({
    required this.id,
    required this.name,
    required this.color,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'color': color, 'userId': userId};
  }

  static Tag fromMap(Map<String, dynamic> map) {
    return Tag(
      id: map['id'],
      name: map['name'],
      color: map['color'],
      userId: map['userId'],
    );
  }
}
