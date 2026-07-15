import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logishield/core/locale/locale_extension.dart';
import 'package:logishield/core/utils/validators.dart';
import 'package:logishield/features/logistics/parcel/domain/entities/carrier.dart';
import 'package:logishield/features/logistics/parcel/domain/entities/carrier_extension.dart';
import 'package:logishield/features/logistics/parcel/domain/entities/parcel.dart';
import 'package:logishield/features/logistics/parcel/domain/params/create_parcel.dart';
import 'package:logishield/features/logistics/parcel/presentation/controllers/create_parcel_form_controller.dart';
import 'package:logishield/features/logistics/parcel/presentation/providers/parcel_notifier.dart';
import 'package:logishield/shared/theme/app_spacing.dart';
import 'package:logishield/shared/widgets/app_button.dart';
import 'package:logishield/shared/widgets/app_dropdown.dart';
import 'package:logishield/shared/widgets/app_text_field.dart';

import '../../domain/entities/carrier_parser.dart';

class ParcelFormPage extends ConsumerStatefulWidget {
  const ParcelFormPage({super.key, this.parcel});

  final Parcel? parcel;

  @override
  ConsumerState<ParcelFormPage> createState() => _ParcelFormPageState();
}

class _ParcelFormPageState extends ConsumerState<ParcelFormPage> {
  late final CreateParcelFormController form;

  @override
  void initState() {
    super.initState();

    form = CreateParcelFormController();

    final parcel = widget.parcel;

    if (parcel != null) {
      form.trackingIdController.text = parcel.trackingId;
      form.customerNameController.text = parcel.customerName;
      form.phoneController.text = parcel.phone;
      form.addressController.text = parcel.address;
      form.codAmountController.text = parcel.codAmount.toString();
      form.carrier = CarrierParser.fromApiValue(parcel.carrier);
    }
  }

  @override
  void dispose() {
    form.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(parcelNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.parcel == null
              ? context.l10n.addParcel
              : context.l10n.editParcel,
        ),
      ),
      body: Form(
        key: form.formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            children: [
              AppTextField(
                controller: form.trackingIdController,
                label: context.l10n.trackingId,
                prefixIcon: const Icon(Icons.qr_code),
                validator: (value) {
                  return Validators.required(value, context.l10n.trackingId);
                },
              ),
              const SizedBox(height: AppSpacing.md),

              AppDropdown<Carrier>(
                value: form.carrier,
                label: context.l10n.carrier,
                items: form.carriers.map((carrier) {
                  return DropdownMenuItem(
                    value: carrier,
                    child: Text(carrier.label(context)),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    form.carrier = value;
                  });
                },
                validator: (value) {},
              ),
              const SizedBox(height: AppSpacing.md),

              AppTextField(
                controller: form.customerNameController,
                label: context.l10n.customerName,
                prefixIcon: const Icon(Icons.person_outline),
                validator: (value) {
                  return Validators.required(value, context.l10n.customerName);
                },
              ),
              const SizedBox(height: AppSpacing.md),

              AppTextField(
                controller: form.phoneController,
                label: context.l10n.phone,
                keyboardType: TextInputType.phone,
                prefixIcon: const Icon(Icons.phone_outlined),
                validator: Validators.phone,
              ),
              const SizedBox(height: AppSpacing.md),

              AppTextField(
                controller: form.addressController,
                label: context.l10n.address,
                maxLines: 3,
                prefixIcon: const Icon(Icons.location_on_outlined),
                validator: (value) {
                  return Validators.required(value, context.l10n.address);
                },
              ),
              const SizedBox(height: AppSpacing.md),

              AppTextField(
                controller: form.codAmountController,
                label: context.l10n.codAmount,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                prefixIcon: const Icon(Icons.payments_outlined),
                validator: (value) {
                  return Validators.number(value, context.l10n.codAmount);
                },
              ),
              const SizedBox(height: AppSpacing.lg),

              AppButton(
                text: widget.parcel == null
                    ? context.l10n.createParcel
                    : context.l10n.updateParcel,
                isLoading: state.isSubmitting,
                onPressed: state.isSubmitting ? null : _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (!form.formKey.currentState!.validate()) return;

    final notifier = ref.read(parcelNotifierProvider.notifier);

    bool success;

    if (widget.parcel == null) {
      final request = CreateParcelRequest(
        trackingId: form.trackingIdController.text.trim(),
        carrier: form.carrier!.name,
        customerName: form.customerNameController.text.trim(),
        phone: form.phoneController.text.trim(),
        address: form.addressController.text.trim(),
        codAmount: double.parse(form.codAmountController.text.trim()),
      );

      success = await notifier.createParcel(request);
    } else {
      final existing = widget.parcel!;

      final updatedParcel = Parcel(
        id: existing.id,
        trackingId: form.trackingIdController.text.trim(),
        carrier: form.carrier!.apiValue,
        customerName: form.customerNameController.text.trim(),
        phone: form.phoneController.text.trim(),
        address: form.addressController.text.trim(),
        codAmount: double.parse(form.codAmountController.text.trim()),
        status: existing.status,
        lastUpdated: DateTime.now(),
        isDelayed: existing.isDelayed,
      );

      success = await notifier.updateParcel(updatedParcel);
    }

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.parcel == null
                ? context.l10n.parcelCreated
                : context.l10n.parcelUpdated,
          ),
        ),
      );

      context.pop(true);
    }
  }
}
