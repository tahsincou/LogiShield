import 'package:logishield/features/logistics/parcel/domain/entities/parcel_status.dart';

import '../../domain/entities/parcel.dart';

class ParcelModel extends Parcel {
  const ParcelModel({
    required super.id,
    required super.trackingId,
    required super.carrier,
    required super.customerName,
    required super.phone,
    required super.address,
    required super.codAmount,
    required super.status,
    required super.lastUpdated,
    required super.isDelayed,
  });

  factory ParcelModel.fromJson(Map<String, dynamic> json) {
    return ParcelModel(
      id: json['id'] as String,
      trackingId: json['trackingId'] as String,
      carrier: json['carrier'] as String,
      customerName: json['customerName'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String,
      codAmount: (json['codAmount'] as num).toDouble(),
      status: ParcelStatusFilter.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => ParcelStatusFilter.all,
      ),
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
      isDelayed: json['isDelayed'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'trackingId': trackingId,
      'carrier': carrier,
      'customerName': customerName,
      'phone': phone,
      'address': address,
      'codAmount': codAmount,
      'status': status.name,
      'lastUpdated': lastUpdated.toIso8601String(),
      'isDelayed': isDelayed,
    };
  }
}
