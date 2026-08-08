import 'package:uuid/uuid.dart';

class Customer {
  final String id;
  final String? pageNo;
  final String? mobileNo;
  final String name;
  final String? fatherName;
  final String? cnic;
  final String? reference;
  final String? address;
  final String? createdBy;
  final String? assignedTo;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final bool isSynced;

  Customer({
    String? id,
    this.pageNo,
    this.mobileNo,
    required this.name,
    this.fatherName,
    this.cnic,
    this.reference,
    this.address,
    this.createdBy,
    this.assignedTo,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.deletedAt,
    this.isSynced = false,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  Map<String, dynamic> toMap() => {
        'id': id,
        'page_no': pageNo,
        'mobile_no': mobileNo,
        'name': name,
        'father_name': fatherName,
        'cnic': cnic,
        'reference': reference,
        'address': address,
        'created_by': createdBy,
        'assigned_to': assignedTo,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
        'deleted_at': deletedAt?.toIso8601String(),
        'is_synced': isSynced,
      };

  factory Customer.fromMap(Map<String, dynamic> map) => Customer(
        id: map['id'],
        pageNo: map['page_no'],
        mobileNo: map['mobile_no'],
        name: map['name'] ?? '',
        fatherName: map['father_name'],
        cnic: map['cnic'],
        reference: map['reference'],
        address: map['address'],
        createdBy: map['created_by'],
        assignedTo: map['assigned_to'],
        createdAt: DateTime.tryParse(map['created_at'] ?? '') ?? DateTime.now(),
        updatedAt: DateTime.tryParse(map['updated_at'] ?? '') ?? DateTime.now(),
        deletedAt: map['deleted_at'] != null ? DateTime.tryParse(map['deleted_at']) : null,
        isSynced: map['is_synced'] ?? false,
      );

  Customer copyWith({
    String? name,
    String? mobileNo,
    String? address,
    String? pageNo,
    bool? isSynced,
  }) =>
      Customer(
        id: id,
        pageNo: pageNo ?? this.pageNo,
        mobileNo: mobileNo ?? this.mobileNo,
        name: name ?? this.name,
        fatherName: fatherName,
        cnic: cnic,
        reference: reference,
        address: address ?? this.address,
        createdBy: createdBy,
        assignedTo: assignedTo,
        createdAt: createdAt,
        updatedAt: DateTime.now(),
        deletedAt: deletedAt,
        isSynced: isSynced ?? this.isSynced,
      );
}
