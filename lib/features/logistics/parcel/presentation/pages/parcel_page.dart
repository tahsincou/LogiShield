import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
        onRefresh: () async {
          await ref.read(parcelNotifierProvider.notifier).loadParcels();
        },

        child: _buildBody(state),
      ),
    );
  }

  Widget _buildBody(state) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null) {
      return Center(child: Text(state.error!));
    }

    return ParcelList(parcels: state.parcels);
  }
}
