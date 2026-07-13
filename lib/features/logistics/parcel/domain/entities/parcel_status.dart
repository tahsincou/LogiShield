enum ParcelStatusFilter {
  all,
  pending,
  pickedUp,
  inTransit,
  atSortingHub,
  outForDelivery,
  delivered,
  returned,
  failed;

  String get label => switch (this) {
    ParcelStatusFilter.all => 'All',
    ParcelStatusFilter.pending => 'Pending',
    ParcelStatusFilter.pickedUp => 'Picked Up',
    ParcelStatusFilter.inTransit => 'In Transit',
    ParcelStatusFilter.atSortingHub => 'Sorting Hub',
    ParcelStatusFilter.outForDelivery => 'Out for Delivery',
    ParcelStatusFilter.delivered => 'Delivered',
    ParcelStatusFilter.returned => 'Returned',
    ParcelStatusFilter.failed => 'Failed',
  };
}
