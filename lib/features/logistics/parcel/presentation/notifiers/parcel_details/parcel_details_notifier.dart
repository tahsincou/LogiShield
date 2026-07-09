import 'package:flutter_riverpod/legacy.dart';
import 'package:logishield/features/logistics/parcel/domain/repository/parcel_repository.dart';
import 'package:logishield/features/logistics/parcel/presentation/notifiers/parcel_details/parcel_details_state.dart';

class ParcelDetailsNotifier extends StateNotifier<ParcelDetailsState> {
  ParcelDetailsNotifier(this.repository) : super(const ParcelDetailsState());

  final ParcelRepository repository;

  Future<void> load(String trackingId) async {
    state = state.copyWith(isLoading: true);

    final details = await repository.getParcelDetails(trackingId);

    state = state.copyWith(details: details, isLoading: false);
  }
}
