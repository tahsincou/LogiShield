import '../repository/parcel_repository.dart';

class DeleteParcelUseCase {
  const DeleteParcelUseCase(this.repository);

  final ParcelRepository repository;

  Future<void> call(String id) {
    return repository.deleteParcel(id);
  }
}
