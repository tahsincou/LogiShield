import 'package:logishield/core/common/repository_result.dart';
import 'package:logishield/core/network/network_exception.dart';
import 'package:logishield/features/logistics/parcel/data/datasources/parcel_local_data_source.dart';
import 'package:logishield/features/logistics/parcel/data/datasources/parcel_remote_datasource.dart';
import 'package:logishield/features/logistics/parcel/domain/entities/parcel_details.dart';
import 'package:logishield/features/logistics/parcel/domain/entities/parcel_timeline.dart';
import 'package:logishield/features/logistics/parcel/domain/params/create_parcel.dart';

import '../../domain/entities/parcel.dart';
import '../../domain/repository/parcel_repository.dart';

class ParcelRepositoryImpl implements ParcelRepository {
  ParcelRepositoryImpl({required this.remote, required this.local});

  final ParcelRemoteDataSource remote;
  final ParcelLocalDataSource local;

  @override
  Future<RepositoryResult<List<Parcel>>> getRecentParcels() async {
    try {
      final parcels = await remote.getParcels();

      await local.replaceParcels(parcels);

      return RepositoryResult(data: parcels, isFromCache: false);
    } on NetworkException {
      return RepositoryResult(
        data: await local.getParcels(),
        isFromCache: true,
      );
    }
  }

  @override
  Future<void> createParcel(CreateParcelRequest request) {
    return remote.createParcel(request);
  }

  @override
  Future<void> updateParcel(Parcel parcel) {
    return remote.updateParcel(parcel);
  }

  @override
  Future<void> deleteParcel(String trackingId) {
    return remote.deletePracel(trackingId);
  }

  @override
  Future<ParcelDetails> getParcelDetails(String trackingId) async {
    final parcels = await remote.getParcels();

    final parcel = parcels.firstWhere((e) => e.trackingId == trackingId);

    return ParcelDetails(
      parcel: parcel,
      timeline: [
        ParcelTimeline(
          title: 'Created',
          completed: true,
          time: DateTime(2026, 7, 4, 9, 0),
        ),
        ParcelTimeline(
          title: 'Picked Up',
          completed: true,
          time: DateTime(2026, 7, 4, 10, 30),
        ),
        ParcelTimeline(
          title: 'Arrived at Hub',
          completed: true,
          time: DateTime(2026, 7, 4, 13, 20),
        ),
        ParcelTimeline(title: 'Out for Delivery', completed: false, time: null),
        ParcelTimeline(title: 'Delivered', completed: false, time: null),
      ],
    );
  }
}
