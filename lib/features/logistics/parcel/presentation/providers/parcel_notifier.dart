// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_riverpod/legacy.dart';
// import 'package:logishield/features/logistics/parcel/domain/entities/parcel.dart';
// import 'package:logishield/features/logistics/parcel/domain/entities/parcel_status.dart';
// import 'package:logishield/features/logistics/parcel/domain/params/create_parcel.dart';
// import 'package:logishield/features/logistics/parcel/presentation/providers/parcel_provider.dart';

// import 'parcel_state.dart';

// final parcelNotifierProvider =
//     StateNotifierProvider<ParcelNotifier, ParcelState>(
//       (ref) => ParcelNotifier(ref),
//     );

// class ParcelNotifier extends StateNotifier<ParcelState> {
//   ParcelNotifier(this.ref) : super(const ParcelState());

//   final Ref ref;
//   List<Parcel> _allParcels = [];
//   Future<void> loadParcels() async {
//     state = state.copyWith(isLoading: true);

//     try {
//       final parcels = await ref.read(getRecentParcelsUseCaseProvider)();
//       _allParcels = parcels.data;

//       state = state.copyWith(parcels: parcels.data, isLoading: false);
//     } catch (e) {
//       state = state.copyWith(isLoading: false, error: e.toString());
//     }
//   }

//   Future<bool> createParcel(CreateParcelRequest request) async {
//     state = state.copyWith(isSubmitting: true);

//     try {
//       await ref.read(createparcelUseCaseProvider)(request);
//       await loadParcels();
//       state = state.copyWith(isSubmitting: false);

//       return true;
//     } catch (e) {
//       state = state.copyWith(isSubmitting: false, error: e.toString());

//       return false;
//     }
//   }

//   Future<bool> updateParcel(Parcel parcel) async {
//     state = state.copyWith(isSubmitting: true);

//     try {
//       await ref.read(updateparcelUseCaseProvider)(parcel);
//       await loadParcels();
//       state = state.copyWith(isSubmitting: false);

//       return true;
//     } catch (e) {
//       state = state.copyWith(isSubmitting: false, error: e.toString());

//       return false;
//     }
//   }

//   Future<bool> deleteParcel(String trackingId) async {
//     state = state.copyWith(isSubmitting: true);

//     try {
//       await ref.read(deleteparcelUseCaseProvider)(trackingId);
//       await loadParcels();
//       state = state.copyWith(isSubmitting: false);

//       return true;
//     } catch (e) {
//       state = state.copyWith(isSubmitting: false, error: e.toString());

//       return false;
//     }
//   }

//   void filterShipments({String? searchQuery, ParcelStatusFilter? status}) {
//     final query = searchQuery ?? state.searchQuery;
//     final filter = status ?? state.statusFilter;

//     var filtered = _allParcels;

//     // Search
//     if (query.trim().isNotEmpty) {
//       filtered = filtered.where((parcel) {
//         final q = query.toLowerCase();

//         return parcel.customer.toLowerCase().contains(q) ||
//             parcel.trackingId.toLowerCase().contains(q);
//       }).toList();
//     }

//     // Status
//     if (filter != ParcelStatusFilter.all) {
//       filtered = filtered.where((parcel) {
//         return parcel.status.toLowerCase() == filter.name.toLowerCase();
//       }).toList();
//     }

//     state = state.copyWith(
//       parcels: filtered,
//       searchQuery: query,
//       statusFilter: filter,
//     );
//   }
// }
