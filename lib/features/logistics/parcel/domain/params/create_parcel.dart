class CreateParcelRequest {
  final String customer;
  final String phone;
  final String address;

  const CreateParcelRequest({
    required this.customer,
    required this.phone,
    required this.address,
  });
}
