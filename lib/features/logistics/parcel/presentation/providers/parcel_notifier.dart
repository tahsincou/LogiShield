import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:logishield/features/logistics/parcel/domain/entities/parcel.dart';
import 'package:logishield/features/logistics/parcel/domain/entities/parcel_status.dart';
import 'package:logishield/features/logistics/parcel/domain/params/create_parcel.dart';
import 'package:logishield/features/logistics/parcel/presentation/providers/parcel_provider.dart';

import 'parcel_state.dart';

final parcelNotifierProvider =
    StateNotifierProvider<ParcelNotifier, ParcelState>(
      (ref) => ParcelNotifier(ref),
    );

class ParcelNotifier extends StateNotifier<ParcelState> {
  ParcelNotifier(this.ref) : super(const ParcelState());

  final Ref ref;
  List<Parcel> _allParcels = [];

  Future<void> loadParcels() async {
    state = state.copyWith(isLoading: true);

    try {
      final parcels = await ref.read(getRecentParcelsUseCaseProvider)();
      _allParcels = parcels.data;

      state = state.copyWith(
        isLoading: false,
        isFromCache: parcels.isFromCache,
      );

      filterParcels(
        searchQuery: state.searchQuery,
        status: state.statusFilter,
        delayedOnly: state.delayedOnly,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void filterParcels({
    String? searchQuery,
    ParcelStatusFilter? status,
    bool? delayedOnly,
  }) {
    final query = searchQuery ?? state.searchQuery;
    final filter = status ?? state.statusFilter;
    final showDelayedOnly = delayedOnly ?? state.delayedOnly;

    List<Parcel> filtered = List.of(_allParcels);

    if (query.trim().isNotEmpty) {
      final normalizedQuery = query.trim().toLowerCase();

      filtered = filtered.where((parcel) {
        return parcel.trackingId.toLowerCase().contains(normalizedQuery) ||
            parcel.customerName.toLowerCase().contains(normalizedQuery) ||
            parcel.phone.toLowerCase().contains(normalizedQuery) ||
            parcel.carrier.toLowerCase().contains(normalizedQuery);
      }).toList();
    }

    if (filter != ParcelStatusFilter.all) {
      filtered = filtered.where((parcel) {
        return parcel.status.name == filter.name;
      }).toList();
    }

    if (showDelayedOnly) {
      filtered = filtered.where((parcel) => parcel.isDelayed).toList();
    }

    state = state.copyWith(
      parcels: filtered,
      searchQuery: query,
      statusFilter: filter,
      delayedOnly: showDelayedOnly,
    );
  }

  Future<bool> createParcel(CreateParcelRequest request) async {
    state = state.copyWith(isSubmitting: true);

    try {
      await ref.read(createparcelUseCaseProvider)(request);
      await loadParcels();
      state = state.copyWith(isSubmitting: false);

      return true;
    } catch (e) {
      state = state.copyWith(isSubmitting: false, error: e.toString());

      return false;
    }
  }

  Future<bool> updateParcel(Parcel parcel) async {
    state = state.copyWith(isSubmitting: true);

    try {
      await ref.read(updateparcelUseCaseProvider)(parcel);
      await loadParcels();
      state = state.copyWith(isSubmitting: false);

      return true;
    } catch (e) {
      state = state.copyWith(isSubmitting: false, error: e.toString());

      return false;
    }
  }

  Future<bool> deleteParcel(String trackingId) async {
    state = state.copyWith(isSubmitting: true);

    try {
      await ref.read(deleteparcelUseCaseProvider)(trackingId);
      await loadParcels();
      state = state.copyWith(isSubmitting: false);

      return true;
    } catch (e) {
      state = state.copyWith(isSubmitting: false, error: e.toString());

      return false;
    }
  }

  void filterShipments({String? searchQuery, ParcelStatusFilter? status}) {
    final query = searchQuery ?? state.searchQuery;
    final filter = status ?? state.statusFilter;

    var filtered = _allParcels;

    // Search
    if (query.trim().isNotEmpty) {
      filtered = filtered.where((parcel) {
        final q = query.toLowerCase();

        return parcel.customerName.toLowerCase().contains(q) ||
            parcel.trackingId.toLowerCase().contains(q);
      }).toList();
    }

    // Status
    if (filter != ParcelStatusFilter.all) {
      filtered = filtered.where((parcel) {
        return parcel.status.name.toLowerCase() == filter.name.toLowerCase();
      }).toList();
    }

    state = state.copyWith(
      parcels: filtered,
      searchQuery: query,
      statusFilter: filter,
    );
  }
}
