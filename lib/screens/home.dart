import 'package:flutter/material.dart';
import '../utils/app_theme.dart';
import '../widgets/menu_button.dart';
import 'input.dart';
import 'history.dart';
import 'settings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _showAbout(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Loan Calculator',
      applicationVersion: '1.0.0',
      children: const [
        Text('Computes total interest, total amount, and monthly payment.'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loan Calculator'),
        leading: const Icon(Icons.menu),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 12),
            const Icon(Icons.account_balance,
                size: 120, color: AppColors.primary),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  MenuButton(
                    icon: Icons.calculate,
                    label: 'Calculate\nLoan',
                    color: AppColors.primary,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LoanInputScreen()),
                    ),
                  ),
                  MenuButton(
                    icon: Icons.history,
                    label: 'Loan\nHistory',
                    color: AppColors.primaryLight,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LoanHistoryScreen()),
                    ),
                  ),
                  MenuButton(
                    icon: Icons.info_outline,
                    label: 'About',
                    color: AppColors.orange,
                    onTap: () => _showAbout(context),
                  ),
                  MenuButton(
                    icon: Icons.settings,
                    label: 'Settings',
                    color: AppColors.green,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SettingsScreen()),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}