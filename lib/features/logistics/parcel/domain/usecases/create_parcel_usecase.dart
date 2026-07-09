import 'package:logishield/features/logistics/parcel/domain/params/create_parcel.dart';

import '../repository/parcel_repository.dart';

class CreateParcelUseCase {
  final ParcelRepository repository;

  const CreateParcelUseCase(this.repository);

  Future<void> call(CreateParcelRequest request) {
    return repository.createParcel(request);
  }
}
