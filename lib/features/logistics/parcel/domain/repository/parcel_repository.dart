import 'package:logishield/core/common/repository_result.dart';
import 'package:logishield/features/logistics/parcel/domain/entities/parcel_details.dart';
import 'package:logishield/features/logistics/parcel/domain/params/create_parcel.dart';
import '../entities/parcel.dart';

abstract interface class ParcelRepository {
  Future<RepositoryResult<List<Parcel>>> getRecentParcels();

  Future<void> createParcel(CreateParcelRequest request);

  Future<void> updateParcel(Parcel parcel);

  Future<void> deleteParcel(String id);

  Future<ParcelDetails> getParcelDetails(String trackingId);
}
