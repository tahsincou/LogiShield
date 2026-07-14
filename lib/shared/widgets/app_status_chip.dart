import 'package:flutter/material.dart';

class AppStatusChip extends StatelessWidget {
  const AppStatusChip({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final style = _getStyle(context, status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: style.background,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: style.foreground.withValues(alpha: 0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(style.icon, size: 15, color: style.foreground),
          const SizedBox(width: 5),
          Text(
            status,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: style.foreground,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  _StatusStyle _getStyle(BuildContext context, String status) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final normalized = status.replaceAll(' ', '').toLowerCase();

    switch (normalized) {
      case 'pending':
      case 'pickedup':
        return const _StatusStyle(
          background: Color(0xFFFFF4E5),
          foreground: Color(0xFFB54708),
          icon: Icons.schedule_outlined,
        );

      case 'delivered':
        return const _StatusStyle(
          background: Color(0xFFEAFBF1),
          foreground: Color(0xFF027A48),
          icon: Icons.check_circle_outline,
        );

      case 'failed':
      case 'returned':
        return const _StatusStyle(
          background: Color(0xFFFFEEEE),
          foreground: Color(0xFFB42318),
          icon: Icons.error_outline,
        );

      case 'intransit':
      case 'sortinghub':
      case 'outfordelivery':
        return const _StatusStyle(
          background: Color(0xFFEFF4FF),
          foreground: Color(0xFF175CD3),
          icon: Icons.local_shipping_outlined,
        );

      default:
        return _StatusStyle(
          background: colors.onSurface.withValues(alpha: 0.07),
          foreground: colors.onSurfaceVariant,
          icon: Icons.info_outline,
        );
    }
  }
}

class _StatusStyle {
  const _StatusStyle({
    required this.background,
    required this.foreground,
    required this.icon,
  });

  final Color background;
  final Color foreground;
  final IconData icon;
}
