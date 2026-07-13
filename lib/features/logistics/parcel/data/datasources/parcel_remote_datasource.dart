import 'package:logishield/core/network/api_client.dart';
import 'package:logishield/features/logistics/parcel/data/models/parcel_model.dart';
import 'package:logishield/features/logistics/parcel/data/models/parcl_details_model.dart';
import 'package:logishield/features/logistics/parcel/domain/params/create_parcel.dart';
import '../../domain/entities/parcel.dart';

class ParcelRemoteDataSource {
  final ApiClient apiClient;

  ParcelRemoteDataSource(this.apiClient);

  Future<List<ParcelModel>> getParcels() async {
    final response = await apiClient.get<List>('/parcels');

    return (response.data as List).map((e) => ParcelModel.fromJson(e)).toList();
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
        'lastUpdated': DateTime.now().toIso8601String(),
        'isDelayed': false,
      },
    );
  }

  Future<void> updateParcel(Parcel parcel) async {
    final model = ParcelModel(
      id: parcel.id,
      trackingId: parcel.trackingId,
      carrier: parcel.carrier,
      customerName: parcel.customerName,
      phone: parcel.phone,
      address: parcel.address,
      codAmount: parcel.codAmount,
      status: parcel.status,
      lastUpdated: parcel.lastUpdated,
      isDelayed: parcel.isDelayed,
    );

    await apiClient.put('/parcels/${parcel.id}', data: model.toJson());
  }

  Future<void> deleteParcel(String id) async {
    await apiClient.delete('/parcels/$id');
  }

  Future<ParcelDetailsModel> getParcelsDetails(String trackingId) async {
    final response = await apiClient.get<Map<String, dynamic>>(
      '/parcels/$trackingId',
    );

    return ParcelDetailsModel.fromJson(response.data!);
  }
}
