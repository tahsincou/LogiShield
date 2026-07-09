// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:logishield/features/logistics/parcel/presentation/notifiers/parcel_details/parcel_details_provider.dart';
// import 'package:logishield/features/logistics/parcel/presentation/providers/parcel_notifier.dart';
// import 'package:logishield/features/logistics/parcel/presentation/widgets/parcel_timeline_widget.dart';
// import 'package:logishield/shared/theme/app_spacing.dart';
// import 'package:logishield/shared/widgets/app_card.dart';
// import 'package:logishield/shared/widgets/app_loading.dart';
// import 'package:logishield/shared/widgets/app_section.dart';
// import 'package:logishield/shared/widgets/confirmation_dialog.dart';
// import 'package:logishield/shared/widgets/info_tile.dart';

// import '../../domain/entities/parcel.dart';

// class ParcelDetailsPage extends ConsumerStatefulWidget {
//   final Parcel parcel;

//   const ParcelDetailsPage({super.key, required this.parcel});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() =>
//       _ParcelDetailsPageState();
// }

// class _ParcelDetailsPageState extends ConsumerState<ParcelDetailsPage> {
//   @override
//   void initState() {
//     super.initState();

//     Future.microtask(() {
//       ref
//           .read(parcelDetailsNotifierProvider.notifier)
//           .load(widget.parcel.trackingId);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final state = ref.watch(parcelDetailsNotifierProvider);

//     if (state.isLoading) {
//       return const Scaffold(
//         body: Center(child: AppLoading(message: 'Loading parcel details...')),
//       );
//     }
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Shipment Details'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.delete, color: Colors.redAccent),
//             onPressed: () async {
//               final confirmed = await showDialog<bool>(
//                 context: context,
//                 builder: (_) => const ConfirmationDialog(
//                   title: 'Delete Shipment',
//                   message: 'Are you sure you want to delete this parcel?',
//                 ),
//               );

//               if (confirmed != true) return;
//               final success = await ref
//                   .read(parcelNotifierProvider.notifier)
//                   .deleteParcel(widget.parcel.trackingId);

//               if (!context.mounted) return;

//               if (success) {
//                 context.pop(true);
//               }
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(10),
//               child: AppCard(
//                 child: Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Row(
//                     children: [
//                       Container(
//                         height: 70,
//                         width: 70,
//                         decoration: BoxDecoration(
//                           color: Theme.of(context).colorScheme.primaryContainer,
//                           borderRadius: BorderRadius.circular(18),
//                         ),
//                         child: const Icon(Icons.local_shipping, size: 36),
//                       ),
//                       const SizedBox(width: AppSpacing.sm),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               widget.parcel.trackingId,
//                               style: Theme.of(context).textTheme.headlineSmall,
//                             ),

//                             const SizedBox(height: 8),

//                             Chip(
//                               avatar: const Icon(
//                                 Icons.local_shipping,
//                                 size: 18,
//                               ),
//                               label: Text(widget.parcel.status),
//                             ),

//                             const SizedBox(height: 12),

//                             Text(
//                               widget.parcel.customer,
//                               style: Theme.of(context).textTheme.titleMedium,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: AppSpacing.md),
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: AppCard(
//                 child: Column(
//                   children: [
//                     InfoTile(
//                       icon: Icons.person,
//                       title: 'Customer',
//                       value: widget.parcel.customer,
//                     ),
//                     Divider(height: 1),
//                     InfoTile(
//                       icon: Icons.phone,
//                       title: 'Phone',
//                       value: widget.parcel.phone,
//                     ),
//                     Divider(height: 1),
//                     InfoTile(
//                       icon: Icons.location_on,
//                       title: 'Address',
//                       value: widget.parcel.address,
//                     ),
//                     Divider(height: 1),
//                     InfoTile(
//                       icon: Icons.local_shipping,
//                       title: 'Status',
//                       value: widget.parcel.status,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: AppSpacing.md),
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: AppCard(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     AppSection(
//                       title: "Parcel Progress",
//                       child: ParcelTimelineWidget(
//                         timeline: state.details?.timeline ?? const [],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () async {
//           final updated = await context.push<bool>(
//             '/edit-parcel',
//             extra: widget.parcel,
//           );

//           if (updated == true && context.mounted) {
//             context.pop(true);
//           }
//         },
//         icon: const Icon(Icons.edit),
//         label: const Text("Edit"),
//       ),
//     );
//   }
// }
