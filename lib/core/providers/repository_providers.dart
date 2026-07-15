import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logishield/core/providers/providers.dart';
import 'package:logishield/features/auth/data/repository/auth_repository.dart';
import 'package:logishield/features/auth/data/repository/auth_repository_impl.dart';
import 'package:logishield/features/logistics/parcel/data/repository/parcel_repository_impl.dart';
import 'package:logishield/features/logistics/parcel/domain/repository/parcel_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    ref.read(authRemoteDataSourceProvider),
    ref.read(secureStorageServiceProvider),
  );
});

//Parcels
final parcelRepositoryProvider = Provider<ParcelRepository>((ref) {
  return ParcelRepositoryImpl(
    remote: ref.read(parcelRemoteDataSourceProvider),
    local: ref.read(parcelLocalDataSourceProvider),
  );
});
