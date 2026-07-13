import 'package:flutter_test/flutter_test.dart';
import 'package:logishield/features/logistics/parcel/domain/entities/delay_rule.dart';
import 'package:logishield/features/logistics/parcel/domain/entities/parcel.dart';
import 'package:logishield/features/logistics/parcel/domain/entities/parcel_status.dart';
import 'package:logishield/features/logistics/parcel/domain/utils/delay_engine.dart';

void main() {
  const rule = DelayRule(
    carrier: 'Pathao',
    thresholdHours: 36,
    highValueAmount: 5000,
    highValueThreshold: 12,
    enabled: true,
  );

  Parcel createParcel({
    ParcelStatusFilter status = ParcelStatusFilter.inTransit,
    double codAmount = 1000,
    required DateTime lastUpdated,
  }) {
    return Parcel(
      id: '1',
      trackingId: 'PTH1001',
      carrier: 'Pathao',
      customerName: 'Rahim',
      phone: '01700000000',
      address: 'Dhaka',
      codAmount: codAmount,
      status: status,
      lastUpdated: lastUpdated,
      isDelayed: false,
    );
  }

  final now = DateTime(2026, 7, 14, 12);

  test('marks regular parcel delayed after carrier threshold', () {
    final parcel = createParcel(
      lastUpdated: now.subtract(const Duration(hours: 40)),
    );

    final result = DelayEngine.isDelayed(
      parcel: parcel,
      rules: const [rule],
      now: now,
    );

    expect(result, isTrue);
  });

  test('does not mark regular parcel delayed before threshold', () {
    final parcel = createParcel(
      lastUpdated: now.subtract(const Duration(hours: 20)),
    );

    final result = DelayEngine.isDelayed(
      parcel: parcel,
      rules: const [rule],
      now: now,
    );

    expect(result, isFalse);
  });

  test('uses shorter threshold for high-value COD parcel', () {
    final parcel = createParcel(
      codAmount: 6000,
      lastUpdated: now.subtract(const Duration(hours: 15)),
    );

    final result = DelayEngine.isDelayed(
      parcel: parcel,
      rules: const [rule],
      now: now,
    );

    expect(result, isTrue);
  });

  test('delivered parcel is never delayed', () {
    final parcel = createParcel(
      status: ParcelStatusFilter.delivered,
      lastUpdated: now.subtract(const Duration(hours: 100)),
    );

    final result = DelayEngine.isDelayed(
      parcel: parcel,
      rules: const [rule],
      now: now,
    );

    expect(result, isFalse);
  });

  test('returns delayed hours beyond threshold', () {
    final parcel = createParcel(
      lastUpdated: now.subtract(const Duration(hours: 50)),
    );

    final result = DelayEngine.delayedHours(
      parcel: parcel,
      rules: const [rule],
      now: now,
    );

    expect(result, 14);
  });
}
