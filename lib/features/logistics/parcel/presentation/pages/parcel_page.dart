import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logishield/core/locale/locale_extension.dart';

import '../../../../../shared/theme/app_spacing.dart';
import '../../../../../shared/widgets/app_error.dart';
import '../../../../../shared/widgets/app_loading.dart';
import '../../../../../shared/widgets/app_search_field.dart';
import '../../../../../shared/widgets/offline_banner.dart';
import '../../../../../shared/widgets/status_filter_chips.dart';
import '../providers/parcel_notifier.dart';
import '../widgets/parcel_list.dart';

class ParcelPage extends ConsumerStatefulWidget {
  const ParcelPage({super.key});

  @override
  ConsumerState<ParcelPage> createState() => _ParcelPageState();
}

class _ParcelPageState extends ConsumerState<ParcelPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(parcelNotifierProvider.notifier).loadParcels();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(parcelNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.parcels)),

      body: RefreshIndicator(
        onRefresh: () {
          return ref.read(parcelNotifierProvider.notifier).loadParcels();
        },
        child: Column(
          children: [
            if (state.isFromCache)
              OfflineBanner(
                message: context.l10n.showingCachedData,
                onRefresh: () {
                  ref.read(parcelNotifierProvider.notifier).loadParcels();
                },
              ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                children: [
                  AppSearchField(
                    hintText: context.l10n.searchParcelHint,
                    onChanged: (value) {
                      ref
                          .read(parcelNotifierProvider.notifier)
                          .filterParcels(searchQuery: value);
                    },
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  StatusFilterChips(
                    selected: state.statusFilter,
                    onSelected: (status) {
                      ref
                          .read(parcelNotifierProvider.notifier)
                          .filterParcels(status: status);
                    },
                  ),
                  const SizedBox(height: AppSpacing.sm),

                  Row(
                    children: [
                      FilterChip(
                        label: Text(context.l10n.delayedOnly),
                        avatar: const Icon(
                          Icons.warning_amber_rounded,
                          size: 18,
                        ),
                        selected: state.delayedOnly,
                        onSelected: (selected) {
                          ref
                              .read(parcelNotifierProvider.notifier)
                              .filterParcels(delayedOnly: selected);
                        },
                      ),
                      const Spacer(),
                      Text(
                        context.l10n.parcelCount(state.parcels.length),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(child: _buildBody(state)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final created = await context.push<bool>('/create-parcel');

          if (created == true && mounted) {
            await ref.read(parcelNotifierProvider.notifier).loadParcels();
          }
        },
        icon: const Icon(Icons.add),
        label: Text(context.l10n.addParcel),
      ),
    );
  }

  Widget _buildBody(state) {
    if (state.isLoading) {
      return AppLoading(message: context.l10n.loadingParcels);
    }

    if (state.error != null) {
      return AppError(
        message: state.error!,
        onRetry: () {
          ref.read(parcelNotifierProvider.notifier).loadParcels();
        },
      );
    }

    return ParcelList(parcels: state.parcels);
  }
}
