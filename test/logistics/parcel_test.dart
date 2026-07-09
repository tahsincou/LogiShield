// import 'package:flutter_test/flutter_test.dart';
// import 'package:logishield/features/logistics/parcel/domain/entities/parcel.dart';
// import 'package:logishield/features/logistics/parcel/domain/entities/parcel_status.dart';

// void main() {
//   group('Parcel', () {
//     final baseParcel = Parcel(
//       id: '1',
//       trackingId: 'TRK1001',
//       carrier: 'Pathao',
//       customerName: 'Rahim Uddin',
//       phone: '01700000000',
//       address: 'Mirpur, Dhaka',
//       codAmount: 1500,
//       currentStatus: ParcelStatus.inTransit,
//       lastUpdated: DateTime(2026, 7, 1, 10, 0),
//       isDelayed: false,
//     );

//     test('creates with correct field values', () {
//       expect(baseParcel.trackingId, 'TRK1001');
//       expect(baseParcel.carrier, 'Pathao');
//       expect(baseParcel.codAmount, 1500);
//       expect(baseParcel.isDelayed, false);
//     });

//     test('copyWith updates only specified fields', () {
//       final updated = baseParcel.copyWith(
//         isDelayed: true,
//         currentStatus: ParcelStatus.atSortingHub,
//       );

//       expect(updated.isDelayed, true);
//       expect(updated.currentStatus, updated.currentStatus);
//       // unchanged fields
//       expect(updated.trackingId, baseParcel.trackingId);
//       expect(updated.customerName, baseParcel.customerName);
//       expect(updated.codAmount, baseParcel.codAmount);
//     });

//     test('copyWith with no args returns identical values', () {
//       final copy = baseParcel.copyWith();
//       expect(copy.id, baseParcel.id);
//       expect(copy.trackingId, baseParcel.trackingId);
//       expect(copy.lastUpdated, baseParcel.lastUpdated);
//     });

//     test('handles zero COD amount', () {
//       final freeParcel = baseParcel.copyWith(codAmount: 0);
//       expect(freeParcel.codAmount, 0);
//     });

//     test('handles high COD amount for delay-rule relevance', () {
//       final highValue = baseParcel.copyWith(codAmount: 10000);
//       expect(highValue.codAmount, greaterThan(5000));
//     });
//   });
// }
