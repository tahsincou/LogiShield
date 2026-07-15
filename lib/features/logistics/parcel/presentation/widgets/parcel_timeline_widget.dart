import 'package:flutter/material.dart';
import 'package:logishield/core/locale/locale_extension.dart';
import '../../domain/entities/parcel_timeline.dart';

class ParcelTimelineWidget extends StatelessWidget {
  const ParcelTimelineWidget({super.key, required this.timeline});

  final List<ParcelTimeline> timeline;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        timeline.length,
        (index) => _TimelineItem(
          item: timeline[index],
          isLast: index == timeline.length - 1,
        ),
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  const _TimelineItem({required this.item, required this.isLast});

  final ParcelTimeline item;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final color = item.completed ? Colors.green : Colors.grey;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Icon(
                item.completed
                    ? Icons.check_circle
                    : Icons.radio_button_unchecked,
                color: color,
              ),
              if (!isLast)
                Expanded(
                  child: Container(width: 2, color: Colors.grey.shade300),
                ),
            ],
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _localizedTitle(context, item.title),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),

                  const SizedBox(height: 4),

                  Text(
                    item.time == null
                        ? context.l10n.pendingStatus
                        : _format(item.time!),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _format(DateTime date) {
    return '${date.day}/${date.month}/${date.year} '
        '${date.hour.toString().padLeft(2, '0')}:'
        '${date.minute.toString().padLeft(2, '0')}';
  }

  String _localizedTitle(BuildContext context, String title) {
    switch (title) {
      case 'created':
        return context.l10n.timelineCreated;

      case 'pickedUp':
        return context.l10n.timelinePickedUp;

      case 'arrivedAtHub':
        return context.l10n.timelineArrivedAtHub;

      case 'outForDelivery':
        return context.l10n.timelineOutForDelivery;

      case 'delivered':
        return context.l10n.timelineDelivered;

      default:
        return title;
    }
  }
}
