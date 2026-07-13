import 'package:logishield/features/logistics/parcel/domain/entities/delay_rule.dart';

const defaultDelayRules = <DelayRule>[
  DelayRule(
    carrier: 'Pathao',
    thresholdHours: 36,
    highValueAmount: 5000,
    highValueThreshold: 12,
    enabled: true,
  ),
  DelayRule(
    carrier: 'Steadfast',
    thresholdHours: 36,
    highValueAmount: 5000,
    highValueThreshold: 12,
    enabled: true,
  ),
  DelayRule(
    carrier: 'RedX',
    thresholdHours: 48,
    highValueAmount: 5000,
    highValueThreshold: 18,
    enabled: true,
  ),
  DelayRule(
    carrier: 'eCourier',
    thresholdHours: 48,
    highValueAmount: 5000,
    highValueThreshold: 18,
    enabled: true,
  ),
  DelayRule(
    carrier: 'Paperfly',
    thresholdHours: 48,
    highValueAmount: 5000,
    highValueThreshold: 18,
    enabled: true,
  ),
];
