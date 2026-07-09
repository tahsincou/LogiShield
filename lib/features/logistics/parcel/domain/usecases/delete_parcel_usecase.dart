import '../repository/parcel_repository.dart';

class DeleteParcelUseCase {
  final ParcelRepository repository;

  const DeleteParcelUseCase(this.repository);

  Future<void> call(String trackingId) {
    return repository.deleteParcel(trackingId);
  }
}
