import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/app_provider.dart';

class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final fmt = NumberFormat.currency(symbol: 'Rs ', decimalDigits: 0);
    final dateFmt = DateFormat('dd MMM yyyy');

    return ListView.builder(
      itemCount: app.payments.length,
      itemBuilder: (_, i) {
        final p = app.payments[i];
        return ListTile(
          leading: const Icon(Icons.payment, color: Colors.green),
          title: Text(fmt.format(p.amount)),
          subtitle: Text('${dateFmt.format(p.paymentDate)} • ${p.notes ?? ""}'),
          trailing: Text(p.receiptNumber ?? ''),
        );
      },
    );
  }
}
