class DelayRule {
  final String carrier;
  final int thresholdHours;
  final double highValueAmount;
  final int highValueThreshold;
  final bool enabled;

  const DelayRule({
    required this.carrier,
    required this.thresholdHours,
    required this.highValueAmount,
    required this.highValueThreshold,
    required this.enabled,
  });
}
