import 'package:logishield/features/logistics/parcel/domain/entities/parcel.dart';
import 'package:logishield/features/logistics/parcel/domain/entities/parcel_status.dart';

class ParcelState {
  final bool isLoading;
  final bool isSubmitting;
  final List<Parcel> parcels;
  final String? error;
  final String searchQuery;
  final ParcelStatusFilter statusFilter;
  final bool isFromCache;

  const ParcelState({
    this.isLoading = false,
    this.isSubmitting = false,
    this.parcels = const [],
    this.isFromCache = false,
    this.error,
    this.searchQuery = '',
    this.statusFilter = ParcelStatusFilter.all,
  });

  ParcelState copyWith({
    bool? isLoading,
    bool? isSubmitting,
    List<Parcel>? parcels,
    String? error,
    String? searchQuery,
    ParcelStatusFilter? statusFilter,
  }) {
    return ParcelState(
      isLoading: isLoading ?? this.isLoading,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      parcels: parcels ?? this.parcels,
      error: error,
      searchQuery: searchQuery ?? this.searchQuery,
      statusFilter: statusFilter ?? this.statusFilter,
      isFromCache: isFromCache,
    );
  }
}
