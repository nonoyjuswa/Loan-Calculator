import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../models/loan_record.dart';
import '../utils/app_theme.dart';
import '../utils/formatters.dart';

class LoanResultScreen extends StatelessWidget {
  final LoanRecord record;
  const LoanResultScreen({super.key, required this.record});

  void _save(BuildContext context) {
    // Real saving comes in Step 8
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Save coming in Step 8')),
    );
  }

  void _share() {
    final text = 'Loan Summary\n'
        'Borrower: ${record.borrowerName}\n'
        'Loan Amount: ${formatPeso(record.loanAmount)}\n'
        'Interest Rate: ${record.annualRate.toStringAsFixed(2)}%\n'
        'Duration: ${record.months} months\n'
        'Total Interest: ${formatPeso(record.totalInterest)}\n'
        'Total to Pay: ${formatPeso(record.totalPayment)}\n'
        'Monthly Payment: ${formatPeso(record.monthlyPayment)}';
    SharePlus.instance.share(ShareParams(text: text));
  }

  Widget _row(String label, String value, {bool bold = false}) {
    final style = TextStyle(
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      fontSize: 15,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(value, style: style),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Loan Result')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.check_circle, size: 64, color: AppColors.green),
            const SizedBox(height: 8),
            const Text(
              'Loan Summary',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _row("Borrower's Name:", record.borrowerName),
                    _row('Loan Amount:', formatPeso(record.loanAmount)),
                    _row('Annual Interest Rate:',
                        '${record.annualRate.toStringAsFixed(2)}%'),
                    _row('Loan Duration:', '${record.months} Months'),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.highlight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _row('Total Interest:', formatPeso(record.totalInterest),
                      bold: true),
                  _row('Total Amount to Pay:', formatPeso(record.totalPayment),
                      bold: true),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Text('Monthly Payment:',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(
                    formatPeso(record.monthlyPayment),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _save(context),
                    icon: const Icon(Icons.download),
                    label: const Text('Save'),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(48),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _share,
                    icon: const Icon(Icons.share),
                    label: const Text('Share'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}