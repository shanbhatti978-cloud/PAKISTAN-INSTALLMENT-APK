import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/app_provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final fmt = NumberFormat.currency(symbol: 'Rs ', decimalDigits: 0);

    return RefreshIndicator(
      onRefresh: () => app.loadAll(),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Overview', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.4,
            children: [
              _Card(title: 'Customers', value: '${app.totalCustomers}', icon: Icons.people, color: Colors.blue),
              _Card(title: 'Active Bookings', value: '${app.activeBookings}', icon: Icons.book, color: Colors.green),
              _Card(title: 'Pending Amount', value: fmt.format(app.totalPending), icon: Icons.pending, color: Colors.orange),
              _Card(title: "Today's Collection", value: fmt.format(app.todayCollection), icon: Icons.payments, color: Colors.purple),
            ],
          ),
          const SizedBox(height: 24),
          Text('Quick Actions', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ActionChip(avatar: const Icon(Icons.person_add), label: const Text('Add Customer'), onPressed: () {}),
              ActionChip(avatar: const Icon(Icons.add_box), label: const Text('New Booking'), onPressed: () {}),
              ActionChip(avatar: const Icon(Icons.payment), label: const Text('Collect Payment'), onPressed: () {}),
              ActionChip(avatar: const Icon(Icons.inventory), label: const Text('Add Inventory'), onPressed: () {}),
            ],
          ),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final String title, value;
  final IconData icon;
  final Color color;
  const _Card({required this.title, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(value, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            Text(title, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
