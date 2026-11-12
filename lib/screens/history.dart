import 'package:flutter/material.dart';
import '../models/loan_record.dart';
import '../services/history_service.dart';
import '../utils/app_theme.dart';
import '../utils/formatters.dart';
import 'input.dart';
import 'result.dart';

class LoanHistoryScreen extends StatefulWidget {
  const LoanHistoryScreen({super.key});

  @override
  State<LoanHistoryScreen> createState() => _LoanHistoryScreenState();
}

class _LoanHistoryScreenState extends State<LoanHistoryScreen> {
  List<LoanRecord> _records = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final data = await HistoryService.load();
    if (!mounted) return;
    setState(() {
      _records = data;
      _loading = false;
    });
  }

  Future<void> _openInput() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const LoanInputScreen()),
    );
    _load(); // refresh after coming back
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Loan History')),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        onPressed: _openInput,
        child: const Icon(Icons.add),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _records.isEmpty
              ? const Center(child: Text('No saved loans yet'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _records.length,
                  itemBuilder: (context, i) {
                    final r = _records[i];
                    return Dismissible(
                      key: ValueKey(r.date.toIso8601String()),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        color: Colors.red,
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      onDismissed: (_) {
                        HistoryService.removeAt(i);
                        setState(() => _records.removeAt(i));
                      },
                      child: Card(
                        child: ListTile(
                          leading: const Icon(Icons.calendar_month,
                              color: AppColors.primary),
                          title: Text(
                            formatDate(r.date),
                            style:
                                const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            '${formatPeso(r.loanAmount)}  |  ${r.months} mos\n'
                            'Monthly: ${formatPeso(r.monthlyPayment)}',
                          ),
                          isThreeLine: true,
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => LoanResultScreen(
                                record: r,
                                canSave: false,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}