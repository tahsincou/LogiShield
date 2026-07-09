import '../../domain/entities/parcel_timeline.dart';

class ParcelTimelineModel extends ParcelTimeline {
  const ParcelTimelineModel({
    required super.title,
    required super.time,
    required super.completed,
  });

  factory ParcelTimelineModel.fromJson(Map<String, dynamic> json) {
    return ParcelTimelineModel(
      title: json['title'] as String,
      time: json['time'] == null
          ? null
          : DateTime.parse(json['time'] as String),
      completed: json['completed'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'time': time?.toIso8601String(),
      'completed': completed,
    };
  }
}
