import 'package:flutter/foundation.dart';

import 'user_brief.dart';

enum ExperienceType { tourism, volunteer, learning }

ExperienceType experienceTypeFromString(String value) {
  switch (value.toLowerCase()) {
    case 'tourism':
      return ExperienceType.tourism;
    case 'volunteer':
      return ExperienceType.volunteer;
    case 'learning':
      return ExperienceType.learning;
    default:
      throw ArgumentError('Unknown experience type: $value');
  }
}

String experienceTypeToString(ExperienceType type) {
  switch (type) {
    case ExperienceType.tourism:
      return 'Tourism';
    case ExperienceType.volunteer:
      return 'Volunteer';
    case ExperienceType.learning:
      return 'Learning';
  }
}

@immutable
class Sponsor {
  const Sponsor({required this.name, required this.logo});

  final String name;
  final String logo;

  Sponsor copyWith({String? name, String? logo}) {
    return Sponsor(name: name ?? this.name, logo: logo ?? this.logo);
  }

  factory Sponsor.fromJson(Map<String, dynamic> json) {
    return Sponsor(
      name: json['name'] as String,
      logo: json['logo'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'logo': logo,
    };
  }
}

@immutable
class Experience {
  const Experience({
    required this.id,
    required this.title,
    required this.type,
    required this.location,
    required this.lat,
    required this.lng,
    required this.startAt,
    required this.durationHours,
    required this.price,
    required this.isSponsored,
    this.sponsor,
    this.itinerary = const <String>[],
    this.impactGoals = const <String>[],
    this.gallery = const <String>[],
    this.participants = const <UserBrief>[],
  });

  final String id;
  final String title;
  final ExperienceType type;
  final String location;
  final double lat;
  final double lng;
  final DateTime startAt;
  final int durationHours;
  final double? price;
  final bool isSponsored;
  final Sponsor? sponsor;
  final List<String> itinerary;
  final List<String> impactGoals;
  final List<String> gallery;
  final List<UserBrief> participants;

  bool get isFree => price == null || price == 0;

  Experience copyWith({
    String? id,
    String? title,
    ExperienceType? type,
    String? location,
    double? lat,
    double? lng,
    DateTime? startAt,
    int? durationHours,
    double? price,
    bool? isSponsored,
    Sponsor? sponsor,
    List<String>? itinerary,
    List<String>? impactGoals,
    List<String>? gallery,
    List<UserBrief>? participants,
  }) {
    return Experience(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      location: location ?? this.location,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      startAt: startAt ?? this.startAt,
      durationHours: durationHours ?? this.durationHours,
      price: price ?? this.price,
      isSponsored: isSponsored ?? this.isSponsored,
      sponsor: sponsor ?? this.sponsor,
      itinerary: itinerary ?? List<String>.from(this.itinerary),
      impactGoals: impactGoals ?? List<String>.from(this.impactGoals),
      gallery: gallery ?? List<String>.from(this.gallery),
      participants: participants ?? List<UserBrief>.from(this.participants),
    );
  }

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      id: json['id'] as String,
      title: json['title'] as String,
      type: experienceTypeFromString(json['type'] as String),
      location: json['location'] as String,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      startAt: DateTime.parse(json['startAt'] as String),
      durationHours: json['durationHours'] as int,
      price: json['price'] == null ? null : (json['price'] as num).toDouble(),
      isSponsored: json['isSponsored'] as bool? ?? false,
      sponsor: json['sponsor'] == null
          ? null
          : Sponsor.fromJson(json['sponsor'] as Map<String, dynamic>),
      itinerary: (json['itinerary'] as List<dynamic>? ?? <dynamic>[])
          .map((dynamic e) => e as String)
          .toList(),
      impactGoals: (json['impactGoals'] as List<dynamic>? ?? <dynamic>[])
          .map((dynamic e) => e as String)
          .toList(),
      gallery: (json['gallery'] as List<dynamic>? ?? <dynamic>[])
          .map((dynamic e) => e as String)
          .toList(),
      participants: (json['participants'] as List<dynamic>? ?? <dynamic>[])
          .map((dynamic e) => UserBrief.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'type': experienceTypeToString(type),
      'location': location,
      'lat': lat,
      'lng': lng,
      'startAt': startAt.toIso8601String(),
      'durationHours': durationHours,
      'price': price,
      'isSponsored': isSponsored,
      'sponsor': sponsor?.toJson(),
      'itinerary': itinerary,
      'impactGoals': impactGoals,
      'gallery': gallery,
      'participants': participants.map((UserBrief e) => e.toJson()).toList(),
    };
  }
}
