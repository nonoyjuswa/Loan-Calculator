import '../models/loan_record.dart';

class LoanCalculator {
  static LoanRecord calculate({
    required String borrowerName,
    required double loanAmount,
    required double annualRate,
    required int months,
  }) {
    final totalInterest = loanAmount * (annualRate / 100) * (months / 12);
    final totalPayment = loanAmount + totalInterest;
    final monthlyPayment = totalPayment / months;

    return LoanRecord(
      borrowerName: borrowerName,
      loanAmount: loanAmount,
      annualRate: annualRate,
      months: months,
      totalInterest: totalInterest,
      totalPayment: totalPayment,
      monthlyPayment: monthlyPayment,
      date: DateTime.now(),
    );
  }
}