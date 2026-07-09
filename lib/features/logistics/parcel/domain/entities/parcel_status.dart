enum ParcelStatusFilter {
  all,
  pending,
  delivered,
  failed;

  String get label {
    switch (this) {
      case ParcelStatusFilter.all:
        return 'All';
      case ParcelStatusFilter.pending:
        return 'Pending';
      case ParcelStatusFilter.delivered:
        return 'Delivered';
      case ParcelStatusFilter.failed:
        return 'Failed';
    }
  }
}
