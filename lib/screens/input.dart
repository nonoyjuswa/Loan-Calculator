import 'package:flutter/material.dart';
import '../services/loan_calculator.dart';
import 'result.dart';

class LoanInputScreen extends StatefulWidget {
  const LoanInputScreen({super.key});

  @override
  State<LoanInputScreen> createState() => _LoanInputScreenState();
}

class _LoanInputScreenState extends State<LoanInputScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  final _rateCtrl = TextEditingController();
  int _months = 12;

  static const _durations = [6, 12, 18, 24, 36, 48, 60];

  @override
  void dispose() {
    _nameCtrl.dispose();
    _amountCtrl.dispose();
    _rateCtrl.dispose();
    super.dispose();
  }

  void _calculate() {
    if (!_formKey.currentState!.validate()) return;

    final record = LoanCalculator.calculate(
      borrowerName: _nameCtrl.text.trim(),
      loanAmount: double.parse(_amountCtrl.text),
      annualRate: double.parse(_rateCtrl.text),
      months: _months,
    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => LoanResultScreen(record: record)),
    );
  }

  void _clear() {
    _formKey.currentState!.reset();
    _nameCtrl.clear();
    _amountCtrl.clear();
    _rateCtrl.clear();
    setState(() => _months = 12);
  }

  String? _positiveNumber(String? v, {bool allowZero = false}) {
    if (v == null || v.trim().isEmpty) return 'Required';
    final n = double.tryParse(v);
    if (n == null) return 'Enter a valid number';
    if (allowZero ? n < 0 : n <= 0) return 'Must be greater than 0';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculate Loan')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(
                  labelText: "Borrower's Name",
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _amountCtrl,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Loan Amount (₱)',
                  prefixIcon: Icon(Icons.payments),
                ),
                validator: _positiveNumber,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _rateCtrl,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Annual Interest Rate (%)',
                  prefixIcon: Icon(Icons.percent),
                ),
                validator: (v) => _positiveNumber(v, allowZero: true),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<int>(
                initialValue: _months,
                decoration: const InputDecoration(
                  labelText: 'Loan Duration (Months)',
                  prefixIcon: Icon(Icons.calendar_month),
                ),
                items: _durations
                    .map((m) => DropdownMenuItem(value: m, child: Text('$m')))
                    .toList(),
                onChanged: (v) => setState(() => _months = v!),
              ),
              const SizedBox(height: 28),
              ElevatedButton.icon(
                onPressed: _calculate,
                icon: const Icon(Icons.calculate),
                label: const Text('Calculate'),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: _clear,
                icon: const Icon(Icons.refresh),
                label: const Text('Clear'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}