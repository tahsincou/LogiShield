import 'package:logishield/features/logistics/parcel/domain/entities/parcel.dart';
import 'package:logishield/features/logistics/parcel/domain/entities/parcel_status.dart';

import '../entities/delay_rule.dart';

class DelayEngine {
  const DelayEngine._();

  static bool isDelayed({
    required Parcel parcel,
    required List<DelayRule> rules,
    DateTime? now,
  }) {
    if (_isCompletedStatus(parcel.status)) {
      return false;
    }

    final rule = _findRule(carrier: parcel.carrier, rules: rules);

    if (rule == null || !rule.enabled) {
      return false;
    }

    final elapsedHours = (now ?? DateTime.now())
        .difference(parcel.lastUpdated)
        .inHours;

    final threshold = parcel.codAmount >= rule.highValueAmount
        ? rule.highValueThreshold
        : rule.thresholdHours;

    return elapsedHours >= threshold;
  }

  static int delayedHours({
    required Parcel parcel,
    required List<DelayRule> rules,
    DateTime? now,
  }) {
    final rule = _findRule(carrier: parcel.carrier, rules: rules);

    if (rule == null || !rule.enabled) {
      return 0;
    }

    final elapsedHours = (now ?? DateTime.now())
        .difference(parcel.lastUpdated)
        .inHours;

    final threshold = parcel.codAmount >= rule.highValueAmount
        ? rule.highValueThreshold
        : rule.thresholdHours;

    final difference = elapsedHours - threshold;

    return difference > 0 ? difference : 0;
  }

  static DelayRule? _findRule({
    required String carrier,
    required List<DelayRule> rules,
  }) {
    for (final rule in rules) {
      if (rule.carrier.toLowerCase() == carrier.toLowerCase()) {
        return rule;
      }
    }

    return null;
  }

  static bool _isCompletedStatus(ParcelStatusFilter status) {
    return status == ParcelStatusFilter.delivered ||
        status == ParcelStatusFilter.returned;
  }
}
