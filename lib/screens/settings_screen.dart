import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    return ListView(
      children: [
        const ListTile(title: Text('Business Info'), subtitle: const Text('Pakistan Trader Corporation'), leading: const Icon(Icons.business)),
        ListTile(title: const Text('Current User'), subtitle: Text(auth.user?.email ?? '-'), leading: const Icon(Icons.person)),
        ListTile(title: const Text('Role'), subtitle: Text(auth.role ?? '-'), leading: const Icon(Icons.security)),
        const Divider(),
        SwitchListTile(title: const Text('Dark Mode'), value: false, onChanged: (_) {}),
        ListTile(title: const Text('Sync Status'), subtitle: const Text('Offline-first ready'), leading: const Icon(Icons.sync)),
        if (auth.isAdmin) ...[
          const Divider(),
          ListTile(title: const Text('User Management'), leading: const Icon(Icons.manage_accounts), onTap: () {}),
          ListTile(title: const Text('Backup / Restore'), leading: const Icon(Icons.backup), onTap: () {}),
          ListTile(title: const Text('Audit Logs'), leading: const Icon(Icons.history), onTap: () {}),
        ],
      ],
    );
  }
}
