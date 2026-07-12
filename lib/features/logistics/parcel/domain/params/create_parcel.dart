class CreateParcelRequest {
  final String trackingId;
  final String carrier;
  final String customerName;
  final String phone;
  final String address;
  final double codAmount;

  const CreateParcelRequest({
    required this.trackingId,
    required this.carrier,
    required this.customerName,
    required this.phone,
    required this.address,
    required this.codAmount,
  });
}
