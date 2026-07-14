import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logishield/core/locale/locale_extension.dart';
import 'package:logishield/features/logistics/parcel/domain/entities/parcel.dart';
import 'package:logishield/features/logistics/parcel/domain/entities/parcel_status.dart';
import 'package:logishield/shared/theme/app_spacing.dart';
import 'package:logishield/shared/widgets/app_card.dart';
import 'package:logishield/shared/widgets/app_empty.dart';
import 'package:logishield/shared/widgets/app_status_chip.dart';

class ParcelList extends StatelessWidget {
  const ParcelList({
    super.key,
    required this.parcels,
    this.padding = const EdgeInsets.all(AppSpacing.md),
  });

  final List<Parcel> parcels;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    if (parcels.isEmpty) {
      return ListView(
        padding: padding,
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          const SizedBox(height: 100),
          AppEmpty(
            title: context.l10n.noParcelsFound,
            message: context.l10n.parcelsAppearHere,
            icon: Icons.inventory_2_outlined,
          ),
        ],
      );
    }

    return ListView.separated(
      padding: padding,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: parcels.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
      itemBuilder: (context, index) {
        final parcel = parcels[index];

        return InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () {
            context.push('/parcel-details', extra: parcel);
          },
          child: AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 44,
                      width: 44,
                      decoration: BoxDecoration(
                        color: colors.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.local_shipping_outlined,
                        color: colors.onSurface,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            parcel.trackingId,
                            style: theme.textTheme.titleMedium,
                          ),
                          const SizedBox(height: 3),
                          Text(
                            parcel.customerName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: colors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),

                    if (parcel.isDelayed)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: colors.errorContainer,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          context.l10n.delayed,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: colors.onErrorContainer,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: AppSpacing.md),

                Row(
                  children: [
                    Expanded(
                      child: _MetaItem(
                        icon: Icons.business_outlined,
                        value: parcel.carrier,
                      ),
                    ),
                    Expanded(
                      child: _MetaItem(
                        icon: Icons.payments_outlined,
                        value: '৳${parcel.codAmount.toStringAsFixed(0)}',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppSpacing.md),

                Row(
                  children: [
                    AppStatusChip(
                      status: _formatStatus(context, parcel.status),
                    ),
                    const Spacer(),
                    Text(
                      _formatDate(parcel.lastUpdated),
                      style: theme.textTheme.bodySmall,
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.chevron_right,
                      size: 18,
                      color: colors.onSurfaceVariant,
                    ),
                  ],
                ),
              ],
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

class _MetaItem extends StatelessWidget {
  const _MetaItem({required this.icon, required this.value});

  final IconData icon;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      children: [
        Icon(icon, size: 17, color: colors.onSurfaceVariant),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            value,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}
