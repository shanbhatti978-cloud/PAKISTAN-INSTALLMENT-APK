import 'package:flutter/material.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final reports = [
      'Daily Collection Report',
      'Monthly Collection Report',
      'Outstanding Report',
      'Overdue Report',
      'Customer Report',
      'Inventory Report',
      'Cash Book Report',
      'Overall Summary',
    ];
    return ListView.builder(
      itemCount: reports.length,
      itemBuilder: (_, i) => ListTile(
        leading: const Icon(Icons.bar_chart),
        title: Text(reports[i]),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {},
      ),
    );
  }
}
