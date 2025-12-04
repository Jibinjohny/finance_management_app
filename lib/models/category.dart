enum CategoryType { income, expense }

class Category {
  final String id;
  final String name;
  final int iconCodePoint;
  final int colorValue;
  final CategoryType type;
  final bool isDefault;

  Category({
    required this.id,
    required this.name,
    required this.iconCodePoint,
    required this.colorValue,
    required this.type,
    this.isDefault = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'iconCodePoint': iconCodePoint,
      'colorValue': colorValue,
      'type': type.index,
      'isDefault': isDefault ? 1 : 0,
    };
  }

  static Category fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      name: map['name'],
      iconCodePoint: map['iconCodePoint'],
      colorValue: map['colorValue'],
      type: CategoryType.values[map['type']],
      isDefault: map['isDefault'] == 1,
    );
  }
}
