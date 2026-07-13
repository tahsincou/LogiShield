import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logishield/features/logistics/parcel/domain/entities/parcel.dart';
import 'package:logishield/shared/widgets/app_card.dart';

import '../../../../../shared/theme/app_colors.dart';
import '../../../../../shared/theme/app_spacing.dart';
import '../../../../../shared/widgets/app_empty.dart';
import '../../../../../shared/widgets/app_status_chip.dart';

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
            title: 'No parcels found',
            message: 'Your parcels will appear here.',
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
          onTap: () {
            context.push('/parcel-details', extra: parcel);
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
                      AppStatusChip(status: _formatStatus(parcel.status.name)),
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

  String _formatStatus(String value) {
    return value[0].toUpperCase() + value.substring(1);
  }
}
