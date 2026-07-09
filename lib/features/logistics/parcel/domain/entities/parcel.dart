import 'package:logishield/features/logistics/parcel/domain/entities/parcel_status.dart';

class Parcel {
  final String id;
  final String trackingId;
  final String carrier;
  final String customerName;
  final String phone;
  final String address;

  final double codAmount;

  final ParcelStatusFilter status;

  final DateTime lastUpdated;

  final bool isDelayed;

  const Parcel({
    required this.id,
    required this.trackingId,
    required this.carrier,
    required this.customerName,
    required this.phone,
    required this.address,
    required this.codAmount,
    required this.status,
    required this.lastUpdated,
    required this.isDelayed,
  });
}
