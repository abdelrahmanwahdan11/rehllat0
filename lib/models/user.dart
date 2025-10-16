import 'package:flutter/foundation.dart';

import 'badge.dart';
import 'trip.dart';
import 'user_brief.dart';

enum UserRole { seeker, volunteer, coordinator }

UserRole userRoleFromString(String value) {
  switch (value.toLowerCase()) {
    case 'seeker':
      return UserRole.seeker;
    case 'volunteer':
      return UserRole.volunteer;
    case 'coordinator':
      return UserRole.coordinator;
    default:
      throw ArgumentError('Unknown user role: $value');
  }
}

String userRoleToString(UserRole role) {
  switch (role) {
    case UserRole.seeker:
      return 'Seeker';
    case UserRole.volunteer:
      return 'Volunteer';
    case UserRole.coordinator:
      return 'Coordinator';
  }
}

@immutable
class User extends UserBrief {
  const User({
    required super.id,
    required super.name,
    required this.role,
    super.avatar,
    required this.volunteerHours,
    required this.completedProjects,
    this.badges = const <Badge>[],
    this.history = const <Trip>[],
  });

  final UserRole role;
  final int volunteerHours;
  final int completedProjects;
  final List<Badge> badges;
  final List<Trip> history;

  @override
  User copyWith({
    String? id,
    String? name,
    String? avatar,
    UserRole? role,
    int? volunteerHours,
    int? completedProjects,
    List<Badge>? badges,
    List<Trip>? history,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      role: role ?? this.role,
      volunteerHours: volunteerHours ?? this.volunteerHours,
      completedProjects: completedProjects ?? this.completedProjects,
      badges: badges ?? List<Badge>.from(this.badges),
      history: history ?? List<Trip>.from(this.history),
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      role: userRoleFromString(json['role'] as String),
      avatar: json['avatar'] as String?,
      volunteerHours: json['volunteerHours'] as int,
      completedProjects: json['completedProjects'] as int,
      badges: (json['badges'] as List<dynamic>? ?? <dynamic>[])
          .map((dynamic e) => Badge.fromJson(e as Map<String, dynamic>))
          .toList(),
      history: (json['history'] as List<dynamic>? ?? <dynamic>[])
          .map((dynamic e) => Trip.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'role': userRoleToString(role),
      'avatar': avatar,
      'volunteerHours': volunteerHours,
      'completedProjects': completedProjects,
      'badges': badges.map((Badge e) => e.toJson()).toList(),
      'history': history.map((Trip e) => e.toJson()).toList(),
    };
  }
}
