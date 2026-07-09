import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logishield/core/providers/database_helper_providers.dart';
import 'package:logishield/core/providers/providers.dart';
import 'package:logishield/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:logishield/features/auth/data/datasource/auth_remote_datasource_impl.dart';
import 'package:logishield/features/logistics/parcel/data/datasources/parcel_local_data_source.dart';
import 'package:logishield/features/logistics/parcel/data/datasources/parcel_local_data_source_impl.dart';
import 'package:logishield/features/logistics/parcel/data/datasources/parcel_memory_data_source.dart';
import 'package:logishield/features/logistics/parcel/data/datasources/parcel_remote_datasource.dart';
import 'package:logishield/features/logistics/shipment/data/datasources/shipment_local_data_source.dart';
import 'package:logishield/features/logistics/shipment/data/datasources/shipment_local_data_source_impl.dart';
import 'package:logishield/features/logistics/shipment/data/datasources/shipment_memory_data_source.dart';
import 'package:logishield/features/logistics/shipment/data/datasources/shipment_remote_datasource.dart';

//Auth
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSourceImpl(ref.read(apiClientProvider));
});

//Shipments
final shipmentRemoteDataSourceProvider = Provider<ShipmentRemoteDataSource>((
  ref,
) {
  final apiClient = ref.read(apiClientProvider);

  return ShipmentRemoteDataSource(apiClient);
});

final shipmentLocalDataSourceProvider = Provider<ShipmentLocalDataSource>((
  ref,
) {
  if (kIsWeb) {
    return ShipmentInMemoryDataSource();
  }

  return ShipmentLocalDataSourceImpl(ref.read(databaseHelperProvider));
});

//Parcels
// final parcelRemoteDataSourceProvider = Provider<ParcelRemoteDataSource>((ref) {
//   final apiClient = ref.read(apiClientProvider);

//   return ParcelRemoteDataSource(apiClient);
// });

// final parcelLocalDataSourceProvider = Provider<ParcelLocalDataSource>((ref) {
//   if (kIsWeb) {
//     return ParcelInMemoryDataSource();
//   }

//   return ParcelLocalDataSourceImpl(ref.read(databaseHelperProvider));
// });
