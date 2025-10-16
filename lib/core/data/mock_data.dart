import 'dart:convert';

import 'package:flutter/services.dart';

import '../../models/experience.dart';
import '../../models/review.dart';
import '../../models/trip.dart';
import '../../models/user.dart';

class MockDataRepository {
  MockDataRepository();

  static const String _seedBundle = 'assets/mock/seed_data.json';

  Map<String, dynamic>? _cache;

  Future<void> _ensureLoaded() async {
    if (_cache != null) {
      return;
    }
    final String raw = await rootBundle.loadString(_seedBundle);
    _cache = jsonDecode(raw) as Map<String, dynamic>;
  }

  Future<List<Experience>> loadExperiences(String key) async {
    await _ensureLoaded();
    final List<dynamic> list = (_cache?[key] as List<dynamic>? ?? <dynamic>[]);
    return list
        .map((dynamic e) => Experience.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<Experience?> findExperience(String id) async {
    await _ensureLoaded();
    final Iterable<String> keys = <String>['recommended', 'nearby', 'volunteer'];
    for (final String key in keys) {
      final List<dynamic> list = _cache?[key] as List<dynamic>? ?? <dynamic>[];
      for (final dynamic item in list) {
        final Experience experience = Experience.fromJson(item as Map<String, dynamic>);
        if (experience.id == id) {
          return experience;
        }
      }
    }
    return null;
  }

  Future<User> loadUser() async {
    await _ensureLoaded();
    final Map<String, dynamic> user =
        _cache?['user'] as Map<String, dynamic>? ?? <String, dynamic>{};
    return User.fromJson(user);
  }

  Future<Map<String, List<Trip>>> loadUserTrips() async {
    await _ensureLoaded();
    final Map<String, dynamic> trips =
        _cache?['user_trips'] as Map<String, dynamic>? ?? <String, dynamic>{};
    return trips.map(
      (String key, dynamic value) => MapEntry<String, List<Trip>>(
        key,
        (value as List<dynamic>)
            .map((dynamic e) => Trip.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
    );
  }

  Future<List<Review>> loadReviews() async {
    await _ensureLoaded();
    final List<dynamic> list =
        _cache?['reviews'] as List<dynamic>? ?? <dynamic>[];
    return list
        .map((dynamic e) => Review.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
