enum AccountType {
  cash,
  savings,
  salary,
  current,
  creditCard,
  bank,
  investment,
  loan,
  other,
}

class Account {
  final String id;
  final String name;
  final AccountType type;
  final double balance;
  final int color;
  final int icon;

  // Bank-specific fields
  final String? bankName;
  final String? accountNumber;

  // Loan-specific fields
  final double? loanPrincipal;
  final double? loanInterestRate;
  final int? loanTenureMonths;
  final DateTime? loanStartDate;
  final double? emiAmount;
  final int? emisPaid;
  final int? emiPaymentDay; // Day of month (1-31) when EMI is due

  Account({
    required this.id,
    required this.name,
    required this.type,
    required this.balance,
    required this.color,
    required this.icon,
    this.bankName,
    this.accountNumber,
    this.loanPrincipal,
    this.loanInterestRate,
    this.loanTenureMonths,
    this.loanStartDate,
    this.emiAmount,
    this.emisPaid,
    this.emiPaymentDay,
  });

  // Computed properties for loan accounts
  int get emisPending {
    if (loanTenureMonths == null) return 0;
    return loanTenureMonths! - (emisPaid ?? 0);
  }

  double get remainingLoanBalance {
    if (loanPrincipal == null || emiAmount == null) return 0;
    final pending = emisPending;
    return pending * emiAmount!;
  }

  double get totalInterestPaid {
    if (loanPrincipal == null || emiAmount == null) return 0;
    final paid = emisPaid ?? 0;
    final totalPaid = paid * emiAmount!;
    final principalPaid = loanPrincipal! - remainingLoanBalance;
    return totalPaid - principalPaid;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type.toString().split('.').last.toUpperCase(),
      'balance': balance,
      'color': color,
      'icon': icon,
      'bankName': bankName,
      'accountNumber': accountNumber,
      'loanPrincipal': loanPrincipal,
      'loanInterestRate': loanInterestRate,
      'loanTenureMonths': loanTenureMonths,
      'loanStartDate': loanStartDate?.toIso8601String(),
      'emiAmount': emiAmount,
      'emisPaid': emisPaid ?? 0,
      'emiPaymentDay': emiPaymentDay,
    };
  }

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      id: map['id'],
      name: map['name'],
      type: AccountType.values.firstWhere(
        (e) => e.toString().split('.').last.toUpperCase() == map['type'],
        orElse: () => AccountType.other,
      ),
      balance: (map['balance'] as num).toDouble(),
      color: map['color'],
      icon: map['icon'],
      bankName: map['bankName'],
      accountNumber: map['accountNumber'],
      loanPrincipal: (map['loanPrincipal'] as num?)?.toDouble(),
      loanInterestRate: (map['loanInterestRate'] as num?)?.toDouble(),
      loanTenureMonths: map['loanTenureMonths'],
      loanStartDate: map['loanStartDate'] != null
          ? DateTime.parse(map['loanStartDate'])
          : null,
      emiAmount: (map['emiAmount'] as num?)?.toDouble(),
      emisPaid: map['emisPaid'] ?? 0,
      emiPaymentDay: map['emiPaymentDay'],
    );
  }

  Account copyWith({
    String? id,
    String? name,
    AccountType? type,
    double? balance,
    int? color,
    int? icon,
    String? bankName,
    String? accountNumber,
    double? loanPrincipal,
    double? loanInterestRate,
    int? loanTenureMonths,
    DateTime? loanStartDate,
    double? emiAmount,
    int? emisPaid,
    int? emiPaymentDay,
  }) {
    return Account(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      balance: balance ?? this.balance,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      bankName: bankName ?? this.bankName,
      accountNumber: accountNumber ?? this.accountNumber,
      loanPrincipal: loanPrincipal ?? this.loanPrincipal,
      loanInterestRate: loanInterestRate ?? this.loanInterestRate,
      loanTenureMonths: loanTenureMonths ?? this.loanTenureMonths,
      loanStartDate: loanStartDate ?? this.loanStartDate,
      emiAmount: emiAmount ?? this.emiAmount,
      emisPaid: emisPaid ?? this.emisPaid,
      emiPaymentDay: emiPaymentDay ?? this.emiPaymentDay,
    );
  }
}
