import 'package:flutter/foundation.dart';

enum TripStatus { upcoming, completed, saved }

TripStatus tripStatusFromString(String value) {
  switch (value.toLowerCase()) {
    case 'upcoming':
      return TripStatus.upcoming;
    case 'completed':
      return TripStatus.completed;
    case 'saved':
      return TripStatus.saved;
    default:
      throw ArgumentError('Unknown trip status: $value');
  }
}

String tripStatusToString(TripStatus status) {
  switch (status) {
    case TripStatus.upcoming:
      return 'upcoming';
    case TripStatus.completed:
      return 'completed';
    case TripStatus.saved:
      return 'saved';
  }
}

@immutable
class Trip {
  const Trip({required this.id, required this.experienceId, required this.status});

  final String id;
  final String experienceId;
  final TripStatus status;

  Trip copyWith({String? id, String? experienceId, TripStatus? status}) {
    return Trip(
      id: id ?? this.id,
      experienceId: experienceId ?? this.experienceId,
      status: status ?? this.status,
    );
  }

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      id: json['id'] as String,
      experienceId: json['experienceId'] as String,
      status: tripStatusFromString(json['status'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'experienceId': experienceId,
      'status': tripStatusToString(status),
    };
  }
}
