import 'package:flutter_riverpod/legacy.dart';
import 'package:logishield/core/providers/repository_providers.dart';
import 'package:logishield/features/logistics/shipment/presentation/notifiers/shipment_details/shipment_details_notifier.dart';
import 'package:logishield/features/logistics/shipment/presentation/notifiers/shipment_details/shipment_details_state.dart';

final shipmentDetailsNotifierProvider =
    StateNotifierProvider<ShipmentDetailsNotifier, ShipmentDetailsState>((ref) {
      return ShipmentDetailsNotifier(ref.read(shipmentRepositoryProvider));
    });
