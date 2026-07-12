import 'package:flutter/material.dart';

import '../../domain/entities/parcel.dart';

class ParcelTile extends StatelessWidget {
  const ParcelTile({super.key, required this.parcel, this.onTap});

  final Parcel parcel;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,

        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              parcel.trackingId,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),

            if (parcel.isDelayed)
              const Icon(Icons.warning_amber_rounded, color: Colors.orange),
          ],
        ),

        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 6),

            Text(parcel.customerName),

            Text(parcel.carrier),

            Text('COD ৳${parcel.codAmount.toStringAsFixed(0)}'),

            const SizedBox(height: 4),

            Chip(label: Text(parcel.status.name)),
          ],
        ),
      ),
    );
  }
}
