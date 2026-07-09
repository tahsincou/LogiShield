class Parcel {
  final String trackingId;
  final String customer;
  final String phone;
  final String address;
  final String status;

  const Parcel({
    required this.trackingId,
    required this.customer,
    required this.phone,
    required this.address,
    required this.status,
  });
}
