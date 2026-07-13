import 'package:flutter/material.dart';

class CreateParcelFormController {
  final formKey = GlobalKey<FormState>();

  final trackingIdController = TextEditingController();
  final customerNameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final codAmountController = TextEditingController();

  String? carrier;

  final carriers = const [
    'Pathao',
    'Steadfast',
    'RedX',
    'eCourier',
    'Paperfly',
  ];

  void dispose() {
    trackingIdController.dispose();
    customerNameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    codAmountController.dispose();
  }
}
