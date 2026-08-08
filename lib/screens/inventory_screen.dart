import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../models/inventory_item.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();

    return Scaffold(
      body: app.inventory.isEmpty
          ? const Center(child: Text('No inventory items'))
          : ListView.builder(
              itemCount: app.inventory.length,
              itemBuilder: (_, i) {
                final item = app.inventory[i];
                return ListTile(
                  leading: const Icon(Icons.inventory_2),
                  title: Text(item.inventoryNumber),
                  subtitle: Text(item.itemDescription),
                  trailing: Chip(
                    label: Text(item.status),
                    visualDensity: VisualDensity.compact,
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final number = await app.nextInventoryNumber();
          final item = InventoryItem(
            inventoryNumber: number,
            itemDescription: 'New Item',
            status: 'available',
          );
          await app.addInventory(item);
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Created $number')));
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
