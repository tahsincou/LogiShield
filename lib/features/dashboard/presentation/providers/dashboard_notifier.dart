import 'package:flutter_riverpod/legacy.dart';
import 'package:logishield/core/providers/repository_providers.dart';
import 'package:logishield/features/dashboard/domain/utils/dashboard_summary_calculator.dart';
import 'package:logishield/features/logistics/parcel/domain/repository/parcel_repository.dart';

import 'dashboard_state.dart';

final dashboardNotifierProvider =
    StateNotifierProvider<DashboardNotifier, DashboardState>((ref) {
      return DashboardNotifier(ref.read(parcelRepositoryProvider));
    });

class DashboardNotifier extends StateNotifier<DashboardState> {
  DashboardNotifier(this._parcelRepository) : super(const DashboardState());

  final ParcelRepository _parcelRepository;

  Future<void> loadSummary() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _parcelRepository.getRecentParcels();

      final summary = DashboardSummaryCalculator.calculate(result.data);

      state = state.copyWith(
        isLoading: false,
        summary: summary,
        isFromCache: result.isFromCache,
      );
    } catch (error) {
      state = state.copyWith(isLoading: false, error: error.toString());
    }
  }
}
