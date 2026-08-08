import 'package:uuid/uuid.dart';

class Payment {
  final String id;
  final String bookingId;
  final String? recoveryId;
  final String customerId;
  final double amount;
  final DateTime paymentDate;
  final String? receiptNumber;
  final String? notes;
  final String? recoveryType;
  final String? createdBy;
  final String? collectedBy;
  final DateTime createdAt;
  final bool isSynced;

  Payment({
    String? id,
    required this.bookingId,
    this.recoveryId,
    required this.customerId,
    required this.amount,
    DateTime? paymentDate,
    this.receiptNumber,
    this.notes,
    this.recoveryType,
    this.createdBy,
    this.collectedBy,
    DateTime? createdAt,
    this.isSynced = false,
  })  : id = id ?? const Uuid().v4(),
        paymentDate = paymentDate ?? DateTime.now(),
        createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() => {
        'id': id,
        'booking_id': bookingId,
        'recovery_id': recoveryId,
        'customer_id': customerId,
        'amount': amount,
        'payment_date': paymentDate.toIso8601String().substring(0, 10),
        'receipt_number': receiptNumber,
        'notes': notes,
        'recovery_type': recoveryType,
        'created_by': createdBy,
        'collected_by': collectedBy,
        'created_at': createdAt.toIso8601String(),
        'is_synced': isSynced,
      };

  factory Payment.fromMap(Map<String, dynamic> map) => Payment(
        id: map['id'],
        bookingId: map['booking_id'],
        recoveryId: map['recovery_id'],
        customerId: map['customer_id'],
        amount: (map['amount'] ?? 0).toDouble(),
        paymentDate: DateTime.tryParse(map['payment_date'] ?? '') ?? DateTime.now(),
        receiptNumber: map['receipt_number'],
        notes: map['notes'],
        recoveryType: map['recovery_type'],
        createdBy: map['created_by'],
        collectedBy: map['collected_by'],
        createdAt: DateTime.tryParse(map['created_at'] ?? '') ?? DateTime.now(),
        isSynced: map['is_synced'] ?? false,
      );
}
