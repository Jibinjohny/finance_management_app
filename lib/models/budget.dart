class Budget {
  final String id;
  final String category;
  final double amount;
  final String period; // 'monthly', 'yearly'
  final DateTime startDate;
  final String userId;

  Budget({
    required this.id,
    required this.category,
    required this.amount,
    required this.period,
    required this.startDate,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'amount': amount,
      'period': period,
      'startDate': startDate.toIso8601String(),
      'userId': userId,
    };
  }

  static Budget fromMap(Map<String, dynamic> map) {
    return Budget(
      id: map['id'],
      category: map['category'],
      amount: map['amount'],
      period: map['period'],
      startDate: DateTime.parse(map['startDate']),
      userId: map['userId'],
    );
  }
}
