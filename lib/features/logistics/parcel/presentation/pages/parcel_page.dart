import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../shared/theme/app_spacing.dart';
import '../../../../../shared/widgets/app_error.dart';
import '../../../../../shared/widgets/app_loading.dart';
import '../../../../../shared/widgets/app_search_field.dart';
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
      appBar: AppBar(title: const Text('Parcels')),

      body: RefreshIndicator(
        onRefresh: () {
          return ref.read(parcelNotifierProvider.notifier).loadParcels();
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                children: [
                  AppSearchField(
                    hintText: 'Search tracking, customer, phone or carrier',
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
                        label: const Text('Delayed only'),
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
                        '${state.parcels.length} parcels',
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
    );
  }

  Widget _buildBody(state) {
    if (state.isLoading) {
      return const AppLoading(message: 'Loading parcels...');
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
