import 'package:flutter/material.dart';

class CashBookScreen extends StatelessWidget {
  const CashBookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.account_balance_wallet, size: 64),
          SizedBox(height: 16),
          Text('Cash Book'),
          Text('Income / Expense / Discount entries'),
          Text('Integrated with payment collections'),
        ],
      ),
    );
  }
}
