import 'package:flutter/foundation.dart';
import '../models/customer.dart';
import '../models/booking.dart';
import '../models/payment.dart';
import '../models/inventory_item.dart';
import '../services/local_db_service.dart';

class AppProvider with ChangeNotifier {
  final LocalDbService _db = LocalDbService();
  List<Customer> customers = [];
  List<Booking> bookings = [];
  List<Payment> payments = [];
  List<InventoryItem> inventory = [];
  bool isLoading = false;
  String? error;

  Future<void> loadAll() async {
    isLoading = true;
    notifyListeners();
    try {
      customers = await _db.getCustomers();
      bookings = await _db.getBookings();
      payments = await _db.getPayments();
      inventory = await _db.getInventory();
    } catch (e) {
      error = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> addCustomer(Customer c) async {
    await _db.saveCustomer(c);
    customers = await _db.getCustomers();
    notifyListeners();
  }

  Future<void> updateCustomer(Customer c) async {
    await _db.saveCustomer(c.copyWith(isSynced: false));
    customers = await _db.getCustomers();
    notifyListeners();
  }

  Future<void> addBooking(Booking b) async {
    await _db.saveBooking(b);
    bookings = await _db.getBookings();
    notifyListeners();
  }

  Future<void> addPayment(Payment p) async {
    await _db.savePayment(p);
    // Update remaining on booking
    final idx = bookings.indexWhere((b) => b.id == p.bookingId);
    if (idx >= 0) {
      final b = bookings[idx];
      final newRemaining = (b.remainingAmount - p.amount).clamp(0.0, double.infinity);
      final updated = Booking(
        id: b.id,
        pageNo: b.pageNo,
        customerId: b.customerId,
        inventoryId: b.inventoryId,
        itemDescription: b.itemDescription,
        productPrice: b.productPrice,
        advancePayment: b.advancePayment,
        markupAmount: b.markupAmount,
        markupPercent: b.markupPercent,
        totalAmount: b.totalAmount,
        remainingAmount: newRemaining,
        recoveryType: b.recoveryType,
        status: newRemaining <= 0 ? 'closed' : b.status,
        startDate: b.startDate,
        finishDate: b.finishDate,
        totalMonths: b.totalMonths,
        createdBy: b.createdBy,
        assignedTo: b.assignedTo,
        createdAt: b.createdAt,
        updatedAt: DateTime.now(),
        isSynced: false,
      );
      await _db.saveBooking(updated);
    }
    payments = await _db.getPayments();
    bookings = await _db.getBookings();
    notifyListeners();
  }

  Future<String> nextInventoryNumber() async {
    return await _db.generateLocalInventoryNumber();
  }

  Future<void> addInventory(InventoryItem item) async {
    await _db.saveInventory(item);
    inventory = await _db.getInventory();
    notifyListeners();
  }

  // Dashboard metrics
  int get totalCustomers => customers.length;
  int get activeBookings => bookings.where((b) => b.status == 'active').length;
  double get totalPending => bookings.fold(0.0, (s, b) => s + b.remainingAmount);
  double get todayCollection {
    final today = DateTime.now();
    return payments
        .where((p) =>
            p.paymentDate.year == today.year &&
            p.paymentDate.month == today.month &&
            p.paymentDate.day == today.day)
        .fold(0.0, (s, p) => s + p.amount);
  }
}
