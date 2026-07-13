import 'package:logishield/features/dashboard/domain/entities/dashboard_summary.dart';
import 'package:logishield/features/logistics/parcel/domain/entities/parcel.dart';

import '../../../logistics/parcel/domain/entities/parcel_status.dart';

DashboardSummary calculate(List<Parcel> parcels) {
  return DashboardSummary(
    total: parcels.length,
    inTransit: parcels.where((parcel) {
      return parcel.status == ParcelStatusFilter.pickedUp ||
          parcel.status == ParcelStatusFilter.inTransit ||
          parcel.status == ParcelStatusFilter.atSortingHub ||
          parcel.status == ParcelStatusFilter.outForDelivery;
    }).length,
    delivered: parcels.where((parcel) {
      return parcel.status == ParcelStatusFilter.delivered;
    }).length,
    delayed: parcels.where((parcel) => parcel.isDelayed).length,
  );
}
