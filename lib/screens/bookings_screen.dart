import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/app_provider.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final fmt = NumberFormat.currency(symbol: 'Rs ', decimalDigits: 0);

    return ListView.builder(
      itemCount: app.bookings.length,
      itemBuilder: (_, i) {
        final b = app.bookings[i];
        final customer = app.customers.where((c) => c.id == b.customerId).firstOrNull;
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: ListTile(
            title: Text(b.itemDescription ?? 'Booking'),
            subtitle: Text('${customer?.name ?? "Unknown"} • ${b.recoveryType} • ${b.status}'),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(fmt.format(b.remainingAmount), style: const TextStyle(fontWeight: FontWeight.bold)),
                Text('of ${fmt.format(b.totalAmount)}', style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        );
      },
    );
  }
}
