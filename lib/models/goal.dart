class Goal {
  final String id;
  final String name;
  final double targetAmount;
  final double currentAmount;
  final DateTime? deadline;
  final int icon;
  final int color;
  final String userId;

  Goal({
    required this.id,
    required this.name,
    required this.targetAmount,
    required this.currentAmount,
    this.deadline,
    required this.icon,
    required this.color,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'targetAmount': targetAmount,
      'currentAmount': currentAmount,
      'deadline': deadline?.toIso8601String(),
      'icon': icon,
      'color': color,
      'userId': userId,
    };
  }

  static Goal fromMap(Map<String, dynamic> map) {
    return Goal(
      id: map['id'],
      name: map['name'],
      targetAmount: (map['targetAmount'] as num).toDouble(),
      currentAmount: (map['currentAmount'] as num).toDouble(),
      deadline: map['deadline'] != null
          ? DateTime.parse(map['deadline'])
          : null,
      icon: map['icon'],
      color: map['color'],
      userId: map['userId'],
    );
  }
}
