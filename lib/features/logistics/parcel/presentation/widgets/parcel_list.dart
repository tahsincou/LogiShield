import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logishield/core/locale/locale_extension.dart';
import 'package:logishield/features/logistics/parcel/domain/entities/parcel.dart';
import 'package:logishield/shared/widgets/app_card.dart';

import '../../../../../shared/theme/app_colors.dart';
import '../../../../../shared/theme/app_spacing.dart';
import '../../../../../shared/widgets/app_empty.dart';
import '../../../../../shared/widgets/app_status_chip.dart';
import '../../domain/entities/parcel_status.dart';

class ParcelList extends StatelessWidget {
  const ParcelList({super.key, required this.parcels});

  final List<Parcel> parcels;

  @override
  Widget build(BuildContext context) {
    if (parcels.isEmpty) {
      return ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(height: AppSpacing.lg),
          AppEmpty(
            title: context.l10n.noParcelsFound,
            message: context.l10n.parcelsAppearHere,
            icon: Icons.inventory_2_outlined,
          ),
        ],
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.md),
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: parcels.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
      itemBuilder: (context, index) {
        final parcel = parcels[index];

        return InkWell(
          borderRadius: BorderRadius.circular(AppSpacing.md),
          onTap: () async {
            final changed = await context.push<bool>(
              '/parcel-details',
              extra: parcel,
            );

            if (changed == true && context.mounted) {
              // The notifier already reloads after update/delete.
            }
          },
          child: AppCard(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          parcel.trackingId,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                      if (parcel.isDelayed)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(AppSpacing.sm),
                          ),
                          child: const Text(
                            'Delayed',
                            style: TextStyle(
                              color: AppColors.warning,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    parcel.customerName,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      const Icon(Icons.local_shipping_outlined, size: 18),
                      const SizedBox(width: AppSpacing.sm),
                      Text(parcel.carrier),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.payments_outlined, size: AppSpacing.md),
                      const SizedBox(width: 6),
                      Text('COD ৳${parcel.codAmount.toStringAsFixed(0)}'),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      AppStatusChip(
                        status: _formatStatus(context, parcel.status),
                      ),
                      const Spacer(),
                      Text(
                        _formatDate(parcel.lastUpdated),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');

    return '$day/$month/${date.year}';
  }

  String _formatStatus(BuildContext context, ParcelStatusFilter status) {
    switch (status) {
      case ParcelStatusFilter.all:
        return context.l10n.all;
      case ParcelStatusFilter.pending:
        return context.l10n.pending;
      case ParcelStatusFilter.pickedUp:
        return context.l10n.pickedUp;
      case ParcelStatusFilter.inTransit:
        return context.l10n.inTransit;
      case ParcelStatusFilter.atSortingHub:
        return context.l10n.sortingHub;
      case ParcelStatusFilter.outForDelivery:
        return context.l10n.outForDelivery;
      case ParcelStatusFilter.delivered:
        return context.l10n.delivered;
      case ParcelStatusFilter.returned:
        return context.l10n.returned;
      case ParcelStatusFilter.failed:
        return context.l10n.failed;
    }
  }
}
