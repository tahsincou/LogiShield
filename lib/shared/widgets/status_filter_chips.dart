import 'package:flutter/material.dart';
import 'package:logishield/features/logistics/parcel/domain/entities/parcel_status.dart';

class StatusFilterChips extends StatelessWidget {
  const StatusFilterChips({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final ParcelStatusFilter selected;
  final ValueChanged<ParcelStatusFilter> onSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: ParcelStatusFilter.values.map((status) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(status.label),
              selected: selected == status,
              onSelected: (_) => onSelected(status),
            ),
          );
        }).toList(),
      ),
    );
  }
}
