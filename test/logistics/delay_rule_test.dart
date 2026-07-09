// import 'package:flutter_test/flutter_test.dart';
// import 'package:logishield/features/logistics/parcel/domain/entities/delay_rule.dart';

// void main() {
//   group('DelayRule', () {
//     test('creates a standard carrier rule', () {
//       const rule = DelayRule(
//         carrier: 'Pathao',
//         thresholdHours: 36,
//         highValueAmount: 5000,
//         highValueThreshold: 12,
//         enabled: true,
//       );

//       expect(rule.thresholdHours, 36);
//       expect(rule.enabled, true);
//     });

//     test('high value threshold is stricter than normal threshold', () {
//       const rule = DelayRule(
//         carrier: 'Steadfast',
//         thresholdHours: 48,
//         highValueAmount: 5000,
//         highValueThreshold: 12,
//         enabled: true,
//       );

//       expect(rule.highValueThreshold, lessThan(rule.thresholdHours));
//     });

//     test('disabled rule flag works', () {
//       const rule = DelayRule(
//         carrier: 'RedX',
//         thresholdHours: 24,
//         highValueAmount: 5000,
//         highValueThreshold: 10,
//         enabled: false,
//       );

//       expect(rule.enabled, false);
//     });
//   });
// }
