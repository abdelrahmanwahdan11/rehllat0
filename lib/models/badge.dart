import 'package:flutter/foundation.dart';

@immutable
class Badge {
  const Badge({required this.id, required this.title, required this.icon});

  final String id;
  final String title;
  final String icon;

  Badge copyWith({String? id, String? title, String? icon}) {
    return Badge(
      id: id ?? this.id,
      title: title ?? this.title,
      icon: icon ?? this.icon,
    );
  }

  factory Badge.fromJson(Map<String, dynamic> json) {
    return Badge(
      id: json['id'] as String,
      title: json['title'] as String,
      icon: json['icon'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'icon': icon,
    };
  }
}
