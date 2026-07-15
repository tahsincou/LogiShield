import 'package:flutter/material.dart';

import '../../domain/entities/carrier.dart';

class CreateParcelFormController {
  final formKey = GlobalKey<FormState>();

  final trackingIdController = TextEditingController();
  final customerNameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final codAmountController = TextEditingController();

  Carrier? carrier;

  final carriers = Carrier.values;

  void dispose() {
    trackingIdController.dispose();
    customerNameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    codAmountController.dispose();
  }
}
