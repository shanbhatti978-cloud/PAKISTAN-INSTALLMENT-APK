import 'package:uuid/uuid.dart';

class InventoryItem {
  final String id;
  final String inventoryNumber;
  final String itemDescription;
  final String? brand;
  final String? model;
  final String status; // available | issued | returned | damaged | sold
  final String? currentHolderId;
  final double? purchasePrice;
  final String? createdBy;
  final DateTime createdAt;
  final bool isSynced;

  InventoryItem({
    String? id,
    required this.inventoryNumber,
    required this.itemDescription,
    this.brand,
    this.model,
    this.status = 'available',
    this.currentHolderId,
    this.purchasePrice,
    this.createdBy,
    DateTime? createdAt,
    this.isSynced = false,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() => {
        'id': id,
        'inventory_number': inventoryNumber,
        'item_description': itemDescription,
        'brand': brand,
        'model': model,
        'status': status,
        'current_holder_id': currentHolderId,
        'purchase_price': purchasePrice,
        'created_by': createdBy,
        'created_at': createdAt.toIso8601String(),
        'is_synced': isSynced,
      };

  factory InventoryItem.fromMap(Map<String, dynamic> map) => InventoryItem(
        id: map['id'],
        inventoryNumber: map['inventory_number'] ?? '',
        itemDescription: map['item_description'] ?? '',
        brand: map['brand'],
        model: map['model'],
        status: map['status'] ?? 'available',
        currentHolderId: map['current_holder_id'],
        purchasePrice: map['purchase_price']?.toDouble(),
        createdBy: map['created_by'],
        createdAt: DateTime.tryParse(map['created_at'] ?? '') ?? DateTime.now(),
        isSynced: map['is_synced'] ?? false,
      );
}
