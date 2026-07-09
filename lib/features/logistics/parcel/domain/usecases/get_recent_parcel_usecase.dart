import 'package:logishield/core/common/repository_result.dart';

import '../entities/parcel.dart';
import '../repository/parcel_repository.dart';

class GetRecentParcelsUseCase {
  final ParcelRepository repository;

  const GetRecentParcelsUseCase(this.repository);

  Future<RepositoryResult<List<Parcel>>> call() {
    return repository.getRecentParcels();
  }
}
