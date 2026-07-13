import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logishield/features/dashboard/domain/entities/dashboard_summary.dart';
import 'package:logishield/features/dashboard/domain/utils/dashboard_summary_calculator.dart';
import 'package:logishield/features/logistics/parcel/presentation/providers/parcel_notifier.dart';

final dashboardSummaryProvider = Provider<DashboardSummary>((ref) {
  final parcels = ref.watch(
    parcelNotifierProvider.select((state) => state.parcels),
  );

  return DashboardSummaryCalculator.calculate(parcels);
});
