import 'package:logishield/features/logistics/parcel/domain/entities/parcel.dart';
import 'package:logishield/features/logistics/parcel/domain/repository/parcel_repository.dart';

class UpdateParcelUseCase {
  final ParcelRepository repository;

  const UpdateParcelUseCase(this.repository);

  Future<void> call(Parcel parcel) {
    return repository.updateParcel(parcel);
  }
}
