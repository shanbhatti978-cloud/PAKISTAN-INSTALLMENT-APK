import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/app_provider.dart';
import 'dashboard_screen.dart';
import 'customers_screen.dart';
import 'bookings_screen.dart';
import 'payments_screen.dart';
import 'inventory_screen.dart';
import 'cashbook_screen.dart';
import 'reports_screen.dart';
import 'settings_screen.dart';
import 'login_screen.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});
  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  final _screens = const [
    DashboardScreen(),
    CustomersScreen(),
    BookingsScreen(),
    PaymentsScreen(),
    InventoryScreen(),
    CashBookScreen(),
    ReportsScreen(),
    SettingsScreen(),
  ];

  final _titles = const [
    'Dashboard',
    'Customers',
    'Bookings',
    'Payments',
    'Inventory',
    'Cash Book',
    'Reports',
    'Settings',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<AppProvider>().loadAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_index]),
        actions: [
          if (auth.isAdmin)
            const Padding(
              padding: EdgeInsets.only(right: 8),
              child: Chip(label: Text('Admin'), visualDensity: VisualDensity.compact),
            ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final navigator = Navigator.of(context);
              await auth.logout();
              if (!mounted) return;
              navigator.pushReplacement(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: _screens[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index > 4 ? 4 : _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.dashboard), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.people), label: 'Customers'),
          NavigationDestination(icon: Icon(Icons.book), label: 'Bookings'),
          NavigationDestination(icon: Icon(Icons.payment), label: 'Payments'),
          NavigationDestination(icon: Icon(Icons.more_horiz), label: 'More'),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.primaryContainer),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Pakistan Trader', style: Theme.of(context).textTheme.titleLarge),
                  Text(auth.user?.email ?? '', style: Theme.of(context).textTheme.bodyMedium),
                  Text('Role: ${auth.role ?? "-"}'),
                ],
              ),
            ),
            for (int i = 0; i < _titles.length; i++)
              ListTile(
                leading: Icon([
                  Icons.dashboard,
                  Icons.people,
                  Icons.book,
                  Icons.payment,
                  Icons.inventory,
                  Icons.account_balance_wallet,
                  Icons.bar_chart,
                  Icons.settings,
                ][i]),
                title: Text(_titles[i]),
                selected: _index == i,
                onTap: () {
                  setState(() => _index = i);
                  Navigator.pop(context);
                },
              ),
          ],
        ),
      ),
    );
  }
}
