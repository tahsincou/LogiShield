import 'parcel.dart';
import 'parcel_timeline.dart';

class ParcelDetails {
  final Parcel parcel;
  final List<ParcelTimeline> timeline;

  const ParcelDetails({required this.parcel, required this.timeline});
}
