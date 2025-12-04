class RecurringTransaction {
  final String id;
  final String title;
  final double amount;
  final String category;
  final String frequency; // 'daily', 'weekly', 'monthly', 'yearly'
  final DateTime nextDueDate;
  final bool isAutoAdd;
  final String? accountId;
  final String userId;
  final bool isExpense;

  RecurringTransaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.frequency,
    required this.nextDueDate,
    required this.isAutoAdd,
    this.accountId,
    required this.userId,
    required this.isExpense,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'category': category,
      'frequency': frequency,
      'nextDueDate': nextDueDate.toIso8601String(),
      'isAutoAdd': isAutoAdd ? 1 : 0,
      'accountId': accountId,
      'userId': userId,
      'isExpense': isExpense ? 1 : 0,
    };
  }

  static RecurringTransaction fromMap(Map<String, dynamic> map) {
    return RecurringTransaction(
      id: map['id'],
      title: map['title'],
      amount: map['amount'],
      category: map['category'],
      frequency: map['frequency'],
      nextDueDate: DateTime.parse(map['nextDueDate']),
      isAutoAdd: map['isAutoAdd'] == 1,
      accountId: map['accountId'],
      userId: map['userId'],
      isExpense: map['isExpense'] == 1,
    );
  }
}
