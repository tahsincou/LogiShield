import 'package:logishield/features/logistics/parcel/data/models/parcel_model.dart';

import 'parcel_local_data_source.dart';

class ParcelInMemoryDataSource implements ParcelLocalDataSource {
  final List<ParcelModel> _cache = [];

  @override
  Future<List<ParcelModel>> getParcels() async {
    return List.unmodifiable(_cache);
  }

  @override
  Future<void> replaceParcels(List<ParcelModel> parcels) async {
    _cache
      ..clear()
      ..addAll(parcels);
  }
}
