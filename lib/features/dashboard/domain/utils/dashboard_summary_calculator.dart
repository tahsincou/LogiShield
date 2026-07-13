import 'package:logishield/features/logistics/parcel/domain/entities/parcel.dart';
import 'package:logishield/features/logistics/parcel/domain/entities/parcel_status.dart';

import '../entities/dashboard_summary.dart';

class DashboardSummaryCalculator {
  const DashboardSummaryCalculator._();

  static DashboardSummary calculate(List<Parcel> parcels) {
    return DashboardSummary(
      total: parcels.length,
      inTransit: parcels
          .where(
            (parcel) =>
                parcel.status == ParcelStatusFilter.inTransit ||
                parcel.status == ParcelStatusFilter.pending ||
                parcel.status == ParcelStatusFilter.failed,
          )
          .length,
      delivered: parcels
          .where((parcel) => parcel.status == ParcelStatusFilter.delivered)
          .length,
      delayed: parcels.where((parcel) => parcel.isDelayed).length,
    );
  }
}
