class DashboardSummary {
  final int total;
  final int inTransit;
  final int delivered;
  final int delayed;

  const DashboardSummary({
    required this.total,
    required this.inTransit,
    required this.delivered,
    required this.delayed,
  });
}
