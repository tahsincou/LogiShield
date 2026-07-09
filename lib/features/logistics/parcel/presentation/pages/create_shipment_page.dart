import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logishield/core/utils/validators.dart';
import 'package:logishield/features/logistics/parcel/domain/entities/parcel.dart';
import 'package:logishield/features/logistics/parcel/domain/params/create_parcel.dart';
import 'package:logishield/features/logistics/parcel/presentation/controllers/create_parcel_form_controller.dart';
import 'package:logishield/features/logistics/parcel/presentation/providers/parcel_notifier.dart';
import 'package:logishield/shared/widgets/app_button.dart';
import 'package:logishield/shared/widgets/app_dropdown.dart';
import 'package:logishield/shared/widgets/app_text_field.dart';

import '../../../../../shared/theme/app_spacing.dart';

class ParcelFormPage extends ConsumerStatefulWidget {
  final Parcel? parcel;

  const ParcelFormPage({super.key, this.parcel});

  @override
  ConsumerState<ParcelFormPage> createState() => _CreateShipmentPageState();
}

class _CreateShipmentPageState extends ConsumerState<ParcelFormPage> {
  late final CreateParcelFormController form;

  @override
  void initState() {
    super.initState();

    form = CreateParcelFormController();

    if (widget.parcel != null) {
      form.customerController.text = widget.parcel!.customer;
      form.phoneController.text = widget.parcel!.phone;
      form.addressController.text = widget.parcel!.address;
    }
  }

  @override
  void dispose() {
    form.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final parcelState = ref.watch(parcelNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.parcel == null ? 'Create Shipment' : 'Edit Shipment',
        ),
      ),
      body: Form(
        key: form.formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            children: [
              // Fields here
              AppTextField(
                controller: form.customerController,
                label: 'Customer Name',
                prefixIcon: const Icon(Icons.person),
                validator: (value) =>
                    Validators.required(value, 'Customer Name'),
              ),

              const SizedBox(height: 16),

              AppTextField(
                controller: form.phoneController,
                label: 'Phone',
                keyboardType: TextInputType.phone,
                prefixIcon: const Icon(Icons.phone),
                validator: Validators.phone,
              ),

              const SizedBox(height: 16),

              AppTextField(
                controller: form.addressController,
                label: 'Address',
                maxLines: 3,
                prefixIcon: const Icon(Icons.location_on),
                validator: (value) => Validators.required(value, 'Address'),
              ),

              const SizedBox(height: 16),

              AppDropdown<String>(
                value: form.parcelType,
                label: 'Parcel Type',
                items: form.parcelTypes
                    .map(
                      (type) =>
                          DropdownMenuItem(value: type, child: Text(type)),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    form.parcelType = value;
                  });
                },
                validator: (value) => Validators.dropdown(value, 'Parcel Type'),
              ),
              const SizedBox(height: 16),

              AppTextField(
                controller: form.weightController,
                label: 'Weight (kg)',
                keyboardType: TextInputType.number,
                prefixIcon: const Icon(Icons.scale),
                validator: (value) => Validators.number(value, 'Weight'),
              ),
              const SizedBox(height: 16),

              AppTextField(
                controller: form.deliveryChargeController,
                label: 'Delivery Charge',
                keyboardType: TextInputType.number,
                prefixIcon: const Icon(Icons.payments),
                validator: (value) =>
                    Validators.number(value, 'Delivery Charge'),
              ),
              const SizedBox(height: AppSpacing.lg),

              AppButton(
                text: widget.parcel == null
                    ? 'Create Shipment'
                    : 'Update Shipment',
                isLoading: parcelState.isSubmitting,
                onPressed: parcelState.isSubmitting
                    ? null
                    : () async {
                        if (!form.formKey.currentState!.validate()) {
                          return;
                        }

                        final notifier = ref.read(
                          parcelNotifierProvider.notifier,
                        );

                        bool success;

                        if (widget.parcel == null) {
                          final request = CreateParcelRequest(
                            customer: form.customerController.text.trim(),
                            phone: form.phoneController.text.trim(),
                            address: form.addressController.text.trim(),
                          );

                          success = await notifier.createParcel(request);
                        } else {
                          final parcel = Parcel(
                            trackingId: widget.parcel!.trackingId,
                            customer: form.customerController.text.trim(),
                            phone: form.phoneController.text.trim(),
                            address: form.addressController.text.trim(),
                            status: widget.parcel!.status,
                          );

                          success = await notifier.updateParcel(parcel);
                        }

                        if (!mounted) return;

                        if (success) {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                widget.parcel == null
                                    ? 'Shipment created successfully'
                                    : 'Shipment updated successfully',
                              ),
                            ),
                          );

                          // ignore: use_build_context_synchronously
                          context.pop(true);
                        }
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
