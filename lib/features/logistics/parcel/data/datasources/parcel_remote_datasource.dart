import 'package:logishield/core/config/app_config.dart';
import 'package:logishield/core/config/environment.dart';
import 'package:logishield/core/network/api_client.dart';
import 'package:logishield/features/logistics/parcel/data/models/parcel_model.dart';
import 'package:logishield/features/logistics/parcel/data/models/parcl_details_model.dart';
import 'package:logishield/features/logistics/parcel/domain/entities/parcel.dart';
import 'package:logishield/features/logistics/parcel/domain/params/create_parcel.dart';

class ParcelRemoteDataSource {
  ParcelRemoteDataSource(this.apiClient);

  final ApiClient apiClient;

  bool get _isSupabase => AppConfig.environment == Environment.staging;

  Future<List<ParcelModel>> getParcels() async {
    final response = await apiClient.get<List>('/parcels');

    return (response.data ?? const [])
        .map(
          (item) =>
              ParcelModel.fromJson(Map<String, dynamic>.from(item as Map)),
        )
        .toList();
  }

  Future<void> createParcel(CreateParcelRequest request) async {
    await apiClient.post(
      '/parcels',
      data: {
        'trackingId': request.trackingId,
        'carrier': request.carrier,
        'customerName': request.customerName,
        'phone': request.phone,
        'address': request.address,
        'codAmount': request.codAmount,
        'status': 'pending',
        'lastUpdated': DateTime.now().toUtc().toIso8601String(),
        'isDelayed': false,
      },
    );
  }

  Future<void> updateParcel(Parcel parcel) async {
    final data = {
      'trackingId': parcel.trackingId,
      'carrier': parcel.carrier,
      'customerName': parcel.customerName,
      'phone': parcel.phone,
      'address': parcel.address,
      'codAmount': parcel.codAmount,
      'status': parcel.status.name,
      'lastUpdated': DateTime.now().toUtc().toIso8601String(),
      'isDelayed': parcel.isDelayed,
    };

    if (_isSupabase) {
      await apiClient.patch(
        '/parcels',
        queryParameters: {'id': 'eq.${parcel.id}'},
        data: data,
      );

      return;
    }

    await apiClient.put(
      '/parcels/${parcel.id}',
      data: {'id': parcel.id, ...data},
    );
  }

  Future<void> deleteParcel(String id) async {
    if (_isSupabase) {
      await apiClient.delete('/parcels', queryParameters: {'id': 'eq.$id'});

      return;
    }

    await apiClient.delete('/parcels/$id');
  }

  Future<ParcelDetailsModel> getParcelsDetails(String trackingId) async {
    if (_isSupabase) {
      final response = await apiClient.get<List>(
        '/parcels',
        queryParameters: {'trackingId': 'eq.$trackingId', 'limit': 1},
      );

      final rows = response.data ?? const [];

      if (rows.isEmpty) {
        throw StateError('Parcel not found');
      }

      return ParcelDetailsModel.fromJson(
        Map<String, dynamic>.from(rows.first as Map),
      );
    }

    final response = await apiClient.get<Map<String, dynamic>>(
      '/parcels/$trackingId',
    );

    return ParcelDetailsModel.fromJson(response.data!);
  }
}
