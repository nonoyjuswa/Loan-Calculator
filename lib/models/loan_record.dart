class LoanRecord {
  final String borrowerName;
  final double loanAmount;
  final double annualRate;
  final int months;
  final double totalInterest;
  final double totalPayment;
  final double monthlyPayment;
  final DateTime date;

  LoanRecord({
    required this.borrowerName,
    required this.loanAmount,
    required this.annualRate,
    required this.months,
    required this.totalInterest,
    required this.totalPayment,
    required this.monthlyPayment,
    required this.date,
  });

  // For saving to history later (Step 8)
  Map<String, dynamic> toJson() => {
        'borrowerName': borrowerName,
        'loanAmount': loanAmount,
        'annualRate': annualRate,
        'months': months,
        'totalInterest': totalInterest,
        'totalPayment': totalPayment,
        'monthlyPayment': monthlyPayment,
        'date': date.toIso8601String(),
      };

  factory LoanRecord.fromJson(Map<String, dynamic> json) => LoanRecord(
        borrowerName: json['borrowerName'],
        loanAmount: (json['loanAmount'] as num).toDouble(),
        annualRate: (json['annualRate'] as num).toDouble(),
        months: json['months'],
        totalInterest: (json['totalInterest'] as num).toDouble(),
        totalPayment: (json['totalPayment'] as num).toDouble(),
        monthlyPayment: (json['monthlyPayment'] as num).toDouble(),
        date: DateTime.parse(json['date']),
      );
}