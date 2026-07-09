import 'package:logishield/features/logistics/parcel/domain/entities/parcel_details.dart';

class ParcelDetailsState {
  final bool isLoading;
  final ParcelDetails? details;
  final String? error;

  const ParcelDetailsState({this.isLoading = false, this.details, this.error});

  ParcelDetailsState copyWith({
    bool? isLoading,
    ParcelDetails? details,
    String? error,
  }) {
    return ParcelDetailsState(
      isLoading: isLoading ?? this.isLoading,
      details: details ?? this.details,
      error: error,
    );
  }
}
