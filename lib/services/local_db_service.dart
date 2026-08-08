import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/customer.dart';
import '../models/booking.dart';
import '../models/payment.dart';
import '../models/inventory_item.dart';

class LocalDbService {
  static const String customersBox = 'customers';
  static const String bookingsBox = 'bookings';
  static const String paymentsBox = 'payments';
  static const String inventoryBox = 'inventory';
  static const String cashBookBox = 'cash_book';
  static const String settingsBox = 'settings';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(customersBox);
    await Hive.openBox(bookingsBox);
    await Hive.openBox(paymentsBox);
    await Hive.openBox(inventoryBox);
    await Hive.openBox(cashBookBox);
    await Hive.openBox(settingsBox);
  }

  // Customers
  Future<List<Customer>> getCustomers() async {
    final box = Hive.box(customersBox);
    return box.values
        .map((e) => Customer.fromMap(Map<String, dynamic>.from(jsonDecode(e))))
        .where((c) => c.deletedAt == null)
        .toList();
  }

  Future<void> saveCustomer(Customer customer) async {
    final box = Hive.box(customersBox);
    await box.put(customer.id, jsonEncode(customer.toMap()));
  }

  Future<void> deleteCustomer(String id) async {
    final box = Hive.box(customersBox);
    final raw = box.get(id);
    if (raw != null) {
      final c = Customer.fromMap(Map<String, dynamic>.from(jsonDecode(raw)));
      final updated = Customer(
        id: c.id,
        pageNo: c.pageNo,
        mobileNo: c.mobileNo,
        name: c.name,
        fatherName: c.fatherName,
        cnic: c.cnic,
        reference: c.reference,
        address: c.address,
        createdBy: c.createdBy,
        assignedTo: c.assignedTo,
        createdAt: c.createdAt,
        updatedAt: DateTime.now(),
        deletedAt: DateTime.now(),
        isSynced: false,
      );
      await box.put(id, jsonEncode(updated.toMap()));
    }
  }

  // Bookings
  Future<List<Booking>> getBookings() async {
    final box = Hive.box(bookingsBox);
    return box.values
        .map((e) => Booking.fromMap(Map<String, dynamic>.from(jsonDecode(e))))
        .toList();
  }

  Future<void> saveBooking(Booking booking) async {
    final box = Hive.box(bookingsBox);
    await box.put(booking.id, jsonEncode(booking.toMap()));
  }

  // Payments
  Future<List<Payment>> getPayments() async {
    final box = Hive.box(paymentsBox);
    return box.values
        .map((e) => Payment.fromMap(Map<String, dynamic>.from(jsonDecode(e))))
        .toList();
  }

  Future<void> savePayment(Payment payment) async {
    final box = Hive.box(paymentsBox);
    await box.put(payment.id, jsonEncode(payment.toMap()));
  }

  // Inventory
  Future<List<InventoryItem>> getInventory() async {
    final box = Hive.box(inventoryBox);
    return box.values
        .map((e) => InventoryItem.fromMap(Map<String, dynamic>.from(jsonDecode(e))))
        .toList();
  }

  Future<void> saveInventory(InventoryItem item) async {
    final box = Hive.box(inventoryBox);
    await box.put(item.id, jsonEncode(item.toMap()));
  }

  Future<String> generateLocalInventoryNumber() async {
    final items = await getInventory();
    final maxNum = items.fold<int>(0, (prev, item) {
      final match = RegExp(r'INV-(\d+)').firstMatch(item.inventoryNumber);
      if (match != null) {
        final n = int.tryParse(match.group(1)!) ?? 0;
        return n > prev ? n : prev;
      }
      return prev;
    });
    return 'INV-${(maxNum + 1).toString().padLeft(6, '0')}';
  }
}
