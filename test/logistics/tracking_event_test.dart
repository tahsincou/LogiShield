// import 'package:flutter_test/flutter_test.dart';
// import 'package:logishield/features/logistics/parcel/domain/entities/tracking_event.dart';

// void main() {
//   group('TrackingEvent', () {
//     test('creates with correct field values', () {
//       final event = TrackingEvent(
//         id: 'evt1',
//         parcelId: 'p1',
//         status: 'atSortingHub',
//         location: 'Gazipur Hub',
//         timestamp: DateTime(2026, 7, 1, 8, 30),
//         description: 'Parcel arrived at sorting hub',
//       );

//       expect(event.parcelId, 'p1');
//       expect(event.status, 'atSortingHub');
//       expect(event.location, 'Gazipur Hub');
//       expect(event.description, contains('sorting hub'));
//     });

//     test('two events for same parcel have same parcelId', () {
//       const parcelId = 'p1';
//       final e1 = TrackingEvent(
//         id: 'e1',
//         parcelId: parcelId,
//         status: 'pickedUp',
//         location: 'Dhaka',
//         timestamp: DateTime(2026, 7, 1, 9),
//         description: 'Picked up',
//       );
//       final e2 = TrackingEvent(
//         id: 'e2',
//         parcelId: parcelId,
//         status: 'inTransit',
//         location: 'Dhaka-Ctg Highway',
//         timestamp: DateTime(2026, 7, 1, 12),
//         description: 'In transit',
//       );

//       expect(e1.parcelId, e2.parcelId);
//       expect(e2.timestamp.isAfter(e1.timestamp), true);
//     });
//   });
// }
