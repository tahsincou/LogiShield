import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logishield/core/providers/providers.dart';
import 'package:logishield/features/logistics/parcel/domain/usecases/create_parcel_usecase.dart';
import 'package:logishield/features/logistics/parcel/domain/usecases/delete_parcel_usecase.dart';
import 'package:logishield/features/logistics/parcel/domain/usecases/get_recent_parcel_usecase.dart';
import 'package:logishield/features/logistics/parcel/domain/usecases/update_parcel_usecase.dart';

final getRecentParcelsUseCaseProvider = Provider<GetRecentParcelsUseCase>((
  ref,
) {
  return GetRecentParcelsUseCase(ref.watch(parcelRepositoryProvider));
});

final createparcelUseCaseProvider = Provider<CreateParcelUseCase>((ref) {
  return CreateParcelUseCase(ref.watch(parcelRepositoryProvider));
});

final updateparcelUseCaseProvider = Provider<UpdateParcelUseCase>((ref) {
  return UpdateParcelUseCase(ref.watch(parcelRepositoryProvider));
});

final deleteparcelUseCaseProvider = Provider<DeleteParcelUseCase>((ref) {
  return DeleteParcelUseCase(ref.watch(parcelRepositoryProvider));
});
