import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logishield/features/dashboard/presentation/providers/dashboard_provider.dart';
import 'package:logishield/features/logistics/parcel/domain/entities/parcel.dart';
import 'package:logishield/features/logistics/parcel/presentation/providers/parcel_notifier.dart';
import 'package:logishield/features/logistics/parcel/presentation/widgets/parcel_list.dart';
import 'package:logishield/shared/theme/app_colors.dart';
import 'package:logishield/shared/theme/app_spacing.dart';
import 'package:logishield/shared/widgets/app_drawer.dart';
import 'package:logishield/shared/widgets/app_error.dart';
import 'package:logishield/shared/widgets/app_loading.dart';
import 'package:logishield/shared/widgets/dashboard_card.dart';

import '../../../logistics/parcel/presentation/providers/parcel_state.dart';
import '../../domain/entities/dashboard_summary.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(parcelNotifierProvider.notifier).loadParcels();
    });
  }

  @override
  Widget build(BuildContext context) {
    final parcelState = ref.watch(parcelNotifierProvider);
    final summary = ref.watch(dashboardSummaryProvider);

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('LogiShield'),
        actions: [
          // if (parcelState.isFromCache)
          //   Icon(Icons.wifi_off_rounded, color: AppColors.error),
        ],
      ),
      body: _buildBody(parcelState: parcelState, summary: summary),
    );
  }

  Widget _buildBody({
    required ParcelState parcelState,
    required DashboardSummary summary,
  }) {
    if (parcelState.isLoading && parcelState.parcels.isEmpty) {
      return const AppLoading(message: 'Loading dashboard...');
    }

    if (parcelState.error != null && parcelState.parcels.isEmpty) {
      return AppError(
        message: parcelState.error!,
        onRetry: () {
          ref.read(parcelNotifierProvider.notifier).loadParcels();
        },
      );
    }

    final List<Parcel> delayedParcels = parcelState.parcels
        .where((Parcel parcel) => parcel.isDelayed)
        .toList();

    return RefreshIndicator(
      onRefresh: () {
        return ref.read(parcelNotifierProvider.notifier).loadParcels();
      },
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Overview',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppSpacing.md),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: AppSpacing.sm,
              mainAxisSpacing: AppSpacing.sm,
              childAspectRatio: 1.7,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    context.push('/parcels');
                  },
                  child: DashboardCard(
                    title: 'Total Parcels',
                    value: summary.total.toString(),
                    icon: Icons.inventory_2_outlined,
                    iconColor: Colors.black,
                  ),
                ),
                DashboardCard(
                  title: 'Delayed',
                  value: summary.delayed.toString(),
                  icon: Icons.warning_amber_rounded,
                  iconColor: AppColors.error,
                ),
                DashboardCard(
                  title: 'In Transit',
                  value: summary.inTransit.toString(),
                  icon: Icons.local_shipping_outlined,
                  iconColor: Colors.black,
                ),
                DashboardCard(
                  title: 'Delivered',
                  value: summary.delivered.toString(),
                  icon: Icons.check_circle_outline,
                  iconColor: AppColors.success,
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.lg),

            Row(
              children: [
                Expanded(
                  child: Text(
                    'Delayed Parcels',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    context.push('/parcels');
                  },
                  child: const Text('View all'),
                ),
                // Text(
                //   '${delayedParcels.length} requires action',
                //   style: Theme.of(context).textTheme.bodySmall,
                // ),
              ],
            ),

            const SizedBox(height: AppSpacing.sm),

            Expanded(child: ParcelList(parcels: delayedParcels)),
          ],
        ),
      ),
    );
  }
}
