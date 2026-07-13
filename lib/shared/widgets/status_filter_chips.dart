import 'package:flutter/material.dart';
import 'package:logishield/core/locale/locale_extension.dart';
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
              label: Text(_label(context, status)),
              selected: selected == status,
              onSelected: (_) => onSelected(status),
            ),
          );
        }).toList(),
      ),
    );
  }

  String _label(BuildContext context, ParcelStatusFilter status) {
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
