import 'package:flutter/material.dart';
import 'package:logishield/core/locale/locale_extension.dart';

import '../entities/carrier.dart';

extension CarrierExtension on Carrier {
  String label(BuildContext context) {
    switch (this) {
      case Carrier.pathao:
        return context.l10n.carrierPathao;

      case Carrier.steadfast:
        return context.l10n.carrierSteadfast;

      case Carrier.redx:
        return context.l10n.carrierRedX;

      case Carrier.ecourier:
        return context.l10n.carrierECourier;

      case Carrier.paperfly:
        return context.l10n.carrierPaperfly;
    }
  }
}
