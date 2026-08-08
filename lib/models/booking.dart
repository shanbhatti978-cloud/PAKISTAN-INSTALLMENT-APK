import 'package:uuid/uuid.dart';

class Booking {
  final String id;
  final String? pageNo;
  final String customerId;
  final String? inventoryId;
  final String? itemDescription;
  final double productPrice;
  final double advancePayment;
  final double markupAmount;
  final double markupPercent;
  final double totalAmount;
  final double remainingAmount;
  final String recoveryType; // daily | monthly
  final String status; // active | closed | cancelled | overdue
  final DateTime? startDate;
  final DateTime? finishDate;
  final int? totalMonths;
  final String? createdBy;
  final String? assignedTo;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isSynced;

  Booking({
    String? id,
    this.pageNo,
    required this.customerId,
    this.inventoryId,
    this.itemDescription,
    this.productPrice = 0,
    this.advancePayment = 0,
    this.markupAmount = 0,
    this.markupPercent = 0,
    this.totalAmount = 0,
    this.remainingAmount = 0,
    this.recoveryType = 'monthly',
    this.status = 'active',
    this.startDate,
    this.finishDate,
    this.totalMonths,
    this.createdBy,
    this.assignedTo,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.isSynced = false,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  Map<String, dynamic> toMap() => {
        'id': id,
        'page_no': pageNo,
        'customer_id': customerId,
        'inventory_id': inventoryId,
        'item_description': itemDescription,
        'product_price': productPrice,
        'advance_payment': advancePayment,
        'markup_amount': markupAmount,
        'markup_percent': markupPercent,
        'total_amount': totalAmount,
        'remaining_amount': remainingAmount,
        'recovery_type': recoveryType,
        'status': status,
        'start_date': startDate?.toIso8601String(),
        'finish_date': finishDate?.toIso8601String(),
        'total_months': totalMonths,
        'created_by': createdBy,
        'assigned_to': assignedTo,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
        'is_synced': isSynced,
      };

  factory Booking.fromMap(Map<String, dynamic> map) => Booking(
        id: map['id'],
        pageNo: map['page_no'],
        customerId: map['customer_id'],
        inventoryId: map['inventory_id'],
        itemDescription: map['item_description'],
        productPrice: (map['product_price'] ?? 0).toDouble(),
        advancePayment: (map['advance_payment'] ?? 0).toDouble(),
        markupAmount: (map['markup_amount'] ?? 0).toDouble(),
        markupPercent: (map['markup_percent'] ?? 0).toDouble(),
        totalAmount: (map['total_amount'] ?? 0).toDouble(),
        remainingAmount: (map['remaining_amount'] ?? 0).toDouble(),
        recoveryType: map['recovery_type'] ?? 'monthly',
        status: map['status'] ?? 'active',
        startDate: map['start_date'] != null ? DateTime.tryParse(map['start_date']) : null,
        finishDate: map['finish_date'] != null ? DateTime.tryParse(map['finish_date']) : null,
        totalMonths: map['total_months'],
        createdBy: map['created_by'],
        assignedTo: map['assigned_to'],
        createdAt: DateTime.tryParse(map['created_at'] ?? '') ?? DateTime.now(),
        updatedAt: DateTime.tryParse(map['updated_at'] ?? '') ?? DateTime.now(),
        isSynced: map['is_synced'] ?? false,
      );
}
