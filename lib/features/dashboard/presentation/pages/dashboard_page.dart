import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logishield/core/locale/locale_extension.dart';
import 'package:logishield/features/dashboard/domain/entities/dashboard_summary.dart';
import 'package:logishield/features/dashboard/presentation/providers/dashboard_provider.dart';
import 'package:logishield/features/logistics/parcel/domain/entities/parcel.dart';
import 'package:logishield/features/logistics/parcel/presentation/providers/parcel_notifier.dart';
import 'package:logishield/features/logistics/parcel/presentation/providers/parcel_state.dart';
import 'package:logishield/features/logistics/parcel/presentation/widgets/parcel_list.dart';
import 'package:logishield/shared/theme/app_spacing.dart';
import 'package:logishield/shared/widgets/app_drawer.dart';
import 'package:logishield/shared/widgets/app_error.dart';
import 'package:logishield/shared/widgets/app_loading.dart';
import 'package:logishield/shared/widgets/dashboard_card.dart';

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
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: Text(context.l10n.appName),
        actions: [
          if (parcelState.isFromCache)
            IconButton(
              tooltip: context.l10n.offlineMode,
              onPressed: () {
                ref.read(parcelNotifierProvider.notifier).loadParcels();
              },
              icon: const Icon(Icons.cloud_off_outlined),
            ),
          const SizedBox(width: 8),
        ],
      ),
      body: _buildBody(
        parcelState: parcelState,
        summary: summary,
        colors: colors,
      ),
    );
  }

  Widget _buildBody({
    required ParcelState parcelState,
    required DashboardSummary summary,
    required ColorScheme colors,
  }) {
    if (parcelState.isLoading && parcelState.parcels.isEmpty) {
      return AppLoading(message: context.l10n.loadingParcels);
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
        .where((parcel) => parcel.isDelayed)
        .toList();

    return RefreshIndicator(
      onRefresh: () {
        return ref.read(parcelNotifierProvider.notifier).loadParcels();
      },
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.sm,
              AppSpacing.md,
              0,
            ),
            sliver: SliverToBoxAdapter(
              child: Text(
                context.l10n.overview,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.all(AppSpacing.md),
            sliver: SliverGrid(
              delegate: SliverChildListDelegate.fixed([
                InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () => context.push('/parcels'),
                  child: DashboardCard(
                    title: context.l10n.totalParcels,
                    value: summary.total.toString(),
                    icon: Icons.inventory_2_outlined,
                  ),
                ),
                DashboardCard(
                  title: context.l10n.delayed,
                  value: summary.delayed.toString(),
                  icon: Icons.warning_amber_rounded,
                  iconColor: colors.error,
                ),
                DashboardCard(
                  title: context.l10n.inTransit,
                  value: summary.inTransit.toString(),
                  icon: Icons.local_shipping_outlined,
                ),
                DashboardCard(
                  title: context.l10n.delivered,
                  value: summary.delivered.toString(),
                  icon: Icons.check_circle_outline,
                  iconColor: const Color(0xFF12B76A),
                ),
              ]),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: AppSpacing.sm,
                mainAxisSpacing: AppSpacing.sm,
                childAspectRatio: 1.45,
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.sm,
              AppSpacing.md,
              AppSpacing.sm,
            ),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.l10n.delayedParcels,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          context.l10n.requiresAction(delayedParcels.length),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () => context.push('/parcels'),
                    child: Text(context.l10n.viewAll),
                  ),
                ],
              ),
            ),
          ),

          if (delayedParcels.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Text(
                  context.l10n.noParcelsFound,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 24),
              sliver: SliverToBoxAdapter(
                child: SizedBox(
                  height: 430,
                  child: ParcelList(
                    parcels: delayedParcels,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
