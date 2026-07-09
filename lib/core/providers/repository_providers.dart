import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logishield/core/providers/providers.dart';
import 'package:logishield/features/auth/data/repository/auth_repository.dart';
import 'package:logishield/features/auth/data/repository/auth_repository_impl.dart';
import 'package:logishield/features/dashboard/data/repository/dashboard_repository_impl.dart';
import 'package:logishield/features/dashboard/domain/repository/dashboard_repository.dart';
import 'package:logishield/features/logistics/parcel/data/repository/parcel_repository_impl.dart';
import 'package:logishield/features/logistics/parcel/domain/repository/parcel_repository.dart';
import 'package:logishield/features/logistics/shipment/data/repository/shipment_repository_impl.dart';
import 'package:logishield/features/logistics/shipment/domain/repository/shipment_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    ref.read(authRemoteDataSourceProvider),
    ref.read(secureStorageServiceProvider),
  );
});

//Shipments
final shipmentRepositoryProvider = Provider<ShipmentRepository>((ref) {
  return ShipmentRepositoryImpl(
    remote: ref.read(shipmentRemoteDataSourceProvider),
    local: ref.read(shipmentLocalDataSourceProvider),
  );
});

//Parcels
// final parcelRepositoryProvider = Provider<ParcelRepository>((ref) {
//   return ParcelRepositoryImpl(
//     remote: ref.read(parcelRemoteDataSourceProvider),
//     local: ref.read(parcelLocalDataSourceProvider),
//   );
// });

//Dashboard
final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  return DashboardRepositoryImpl();
});
