import 'package:logishield/features/logistics/parcel/domain/entities/carrier.dart';

extension CarrierParser on Carrier {
  static Carrier? fromApiValue(String value) {
    try {
      return Carrier.values.firstWhere(
        (carrier) => carrier.apiValue.toLowerCase() == value.toLowerCase(),
      );
    } catch (_) {
      return null;
    }
  }
}
