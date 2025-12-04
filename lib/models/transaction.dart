class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final bool isExpense;
  final String category;
  final String userId;
  final String? accountId;
  final List<String> tags;
  final String paymentMode;

  Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.isExpense,
    required this.category,
    required this.userId,
    this.accountId,
    this.tags = const [],
    this.paymentMode = 'Cash',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'date': date.toIso8601String(),
      'isExpense': isExpense ? 1 : 0,
      'category': category,
      'userId': userId,
      'accountId': accountId,
      'tags': tags.join(','),
      'paymentMode': paymentMode,
    };
  }

  static Transaction fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'],
      title: map['title'],
      amount: map['amount'],
      date: DateTime.parse(map['date']),
      isExpense: map['isExpense'] == 1,
      category: map['category'],
      userId: map['userId'],
      accountId: map['accountId'],
      tags: map['tags'] != null && map['tags'].toString().isNotEmpty
          ? map['tags'].toString().split(',')
          : [],
      paymentMode: map['paymentMode'] ?? 'Cash',
    );
  }
}
