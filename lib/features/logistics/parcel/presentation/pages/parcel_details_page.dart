import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logishield/core/locale/locale_extension.dart';
import 'package:logishield/features/logistics/parcel/domain/entities/parcel.dart';
import 'package:logishield/shared/widgets/app_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logishield/features/logistics/parcel/presentation/providers/parcel_notifier.dart';
import 'package:logishield/shared/widgets/confirmation_dialog.dart';
import 'package:logishield/features/logistics/parcel/domain/utils/default_delay_rule.dart';
import 'package:logishield/features/logistics/parcel/domain/utils/delay_engine.dart';

import '../../../../../shared/widgets/app_status_chip.dart';
import '../../domain/entities/parcel_status.dart';

class ParcelDetailsPage extends ConsumerWidget {
  const ParcelDetailsPage({super.key, required this.parcel});

  final Parcel parcel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final delayedHours = DelayEngine.delayedHours(
      parcel: parcel,
      rules: defaultDelayRules,
    );

    final elapsedHours = DateTime.now().difference(parcel.lastUpdated).inHours;
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.parcelDetails),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () async {
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (_) => ConfirmationDialog(
                  title: context.l10n.deleteParcel,
                  message: context.l10n.deleteParcelConfirmation,
                ),
              );

              if (confirmed != true) return;

              final success = await ref
                  .read(parcelNotifierProvider.notifier)
                  .deleteParcel(parcel.id);

              if (!context.mounted) return;

              if (success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(context.l10n.parcelDeleted)),
                );

                context.pop(true);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppCard(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.local_shipping_outlined,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            parcel.trackingId,
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 6),
                          Text(parcel.carrier),
                          const SizedBox(height: 8),
                          AppStatusChip(
                            status: _formatStatus(context, parcel.status),
                          ),
                        ],
                      ),
                    ),
                    if (parcel.isDelayed)
                      const Icon(Icons.warning_amber_rounded, size: 28),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            _Section(
              title: context.l10n.customerInformation,
              children: [
                _InfoRow(
                  icon: Icons.person_outline,
                  label: context.l10n.customerName,
                  value: parcel.customerName,
                ),
                _InfoRow(
                  icon: Icons.phone_outlined,
                  label: context.l10n.phone,
                  value: parcel.phone,
                ),
                _InfoRow(
                  icon: Icons.location_on_outlined,
                  label: context.l10n.address,
                  value: parcel.address,
                ),
              ],
            ),
            const SizedBox(height: 16),
            _Section(
              title: context.l10n.parcelInformation,
              children: [
                _InfoRow(
                  icon: Icons.payments_outlined,
                  label: context.l10n.codAmount,
                  value: '৳${parcel.codAmount.toStringAsFixed(0)}',
                ),
                _InfoRow(
                  icon: Icons.schedule_outlined,
                  label: context.l10n.lastUpdated,
                  value: _formatDate(parcel.lastUpdated),
                ),
                _InfoRow(
                  icon: Icons.warning_amber_outlined,
                  label: context.l10n.delayStatus,
                  value: parcel.isDelayed
                      ? context.l10n.delayed
                      : context.l10n.onSchedule,
                ),
              ],
            ),
            const SizedBox(height: 16),

            _Section(
              title: context.l10n.delayAnalysis,
              children: [
                _InfoRow(
                  icon: Icons.timer_outlined,
                  label: context.l10n.elapsedTime,
                  value: context.l10n.hours(elapsedHours),
                ),
                _InfoRow(
                  icon: Icons.warning_amber_outlined,
                  label: context.l10n.delayStatus,
                  value: parcel.isDelayed
                      ? context.l10n.delayedByHours(delayedHours)
                      : context.l10n.onSchedule,
                ),
                _InfoRow(
                  icon: Icons.local_shipping_outlined,
                  label: context.l10n.carrierRule,
                  value: _carrierRuleText(context, parcel),
                ),
                if (parcel.codAmount >= 5000)
                  _InfoRow(
                    icon: Icons.priority_high_rounded,
                    label: context.l10n.priority,
                    value: context.l10n.highValueParcel,
                  ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () async {
                  final updated = await context.push<bool>(
                    '/edit-parcel',
                    extra: parcel,
                  );

                  if (updated == true && context.mounted) {
                    context.pop(true);
                  }
                },
                icon: const Icon(Icons.edit_outlined),
                label: Text(context.l10n.editParcel),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');

    return '$day/$month/${date.year} $hour:$minute';
  }

  String _carrierRuleText(BuildContext context, Parcel parcel) {
    for (final rule in defaultDelayRules) {
      if (rule.carrier.toLowerCase() == parcel.carrier.toLowerCase()) {
        final threshold = parcel.codAmount >= rule.highValueAmount
            ? rule.highValueThreshold
            : rule.thresholdHours;

        return context.l10n.hourThreshold(threshold);
      }
    }

    return context.l10n.noRuleConfigured;
  }
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

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 21, color: colors.onSurfaceVariant),
          const SizedBox(width: 12),
          SizedBox(
            width: 105,
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colors.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: colors.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
