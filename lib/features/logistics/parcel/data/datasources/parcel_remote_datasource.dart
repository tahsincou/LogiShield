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
        'customer': request.customer,
        'phone': request.phone,
        'address': request.address,
      },
    );
  }

  Future<void> updateParcel(Parcel parcel) async {
    final model = ParcelModel(
      trackingId: parcel.trackingId,
      customer: parcel.customer,
      phone: parcel.phone,
      address: parcel.address,
      status: parcel.status,
    );

    await apiClient.put('/parcels/${parcel.trackingId}', data: model.toJson());
  }

  Future<void> deletePracel(String trackingId) async {
    await apiClient.delete('/parcels/$trackingId');
  }

  Future<ParcelDetailsModel> getParcelsDetails(String trackingId) async {
    final response = await apiClient.get<Map<String, dynamic>>(
      '/parcels/$trackingId',
    );

    return ParcelDetailsModel.fromJson(response.data!);
  }
}
