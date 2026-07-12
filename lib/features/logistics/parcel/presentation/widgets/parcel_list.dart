import 'package:flutter/material.dart';

import '../../domain/entities/parcel.dart';
import 'parcel_tile.dart';

class ParcelList extends StatelessWidget {
  const ParcelList({super.key, required this.parcels});

  final List<Parcel> parcels;

  @override
  Widget build(BuildContext context) {
    if (parcels.isEmpty) {
      return const Center(child: Text('No parcels found'));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),

      itemCount: parcels.length,

      separatorBuilder: (_, __) => const SizedBox(height: 12),

      itemBuilder: (context, index) {
        return ParcelTile(parcel: parcels[index]);
      },
    );
  }
}
