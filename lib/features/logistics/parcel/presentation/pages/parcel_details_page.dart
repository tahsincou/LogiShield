import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logishield/features/logistics/parcel/domain/entities/parcel.dart';
import 'package:logishield/shared/widgets/app_card.dart';

class ParcelDetailsPage extends StatelessWidget {
  const ParcelDetailsPage({super.key, required this.parcel});

  final Parcel parcel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Parcel Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppCard(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.local_shipping_outlined,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            parcel.trackingId,
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 6),
                          Text(parcel.carrier),
                          const SizedBox(height: 8),
                          _StatusChip(status: parcel.status.name),
                        ],
                      ),
                    ),
                    if (parcel.isDelayed)
                      const Icon(Icons.warning_amber_rounded, size: 28),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            _Section(
              title: 'Customer Information',
              children: [
                _InfoRow(
                  icon: Icons.person_outline,
                  label: 'Customer',
                  value: parcel.customerName,
                ),
                _InfoRow(
                  icon: Icons.phone_outlined,
                  label: 'Phone',
                  value: parcel.phone,
                ),
                _InfoRow(
                  icon: Icons.location_on_outlined,
                  label: 'Address',
                  value: parcel.address,
                ),
              ],
            ),
            const SizedBox(height: 16),
            _Section(
              title: 'Parcel Information',
              children: [
                _InfoRow(
                  icon: Icons.payments_outlined,
                  label: 'COD Amount',
                  value: '৳${parcel.codAmount.toStringAsFixed(0)}',
                ),
                _InfoRow(
                  icon: Icons.schedule_outlined,
                  label: 'Last Updated',
                  value: _formatDate(parcel.lastUpdated),
                ),
                _InfoRow(
                  icon: Icons.warning_amber_outlined,
                  label: 'Delay Status',
                  value: parcel.isDelayed ? 'Delayed' : 'On Schedule',
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () async {
                  final updated = await context.push<bool>(
                    '/edit-parcel',
                    extra: parcel,
                  );

                  if (updated == true && context.mounted) {
                    context.pop(true);
                  }
                },
                icon: const Icon(Icons.edit_outlined),
                label: const Text('Edit Parcel'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');

    return '$day/$month/${date.year} $hour:$minute';
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 21),
          const SizedBox(width: 12),
          SizedBox(
            width: 105,
            child: Text(label, style: TextStyle(color: Colors.grey.shade600)),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        _formatStatus(status),
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }

  String _formatStatus(String value) {
    switch (value) {
      case 'inTransit':
        return 'In Transit';
      case 'outForDelivery':
        return 'Out for Delivery';
      default:
        return value;
    }
  }
}
