import 'package:flutter/foundation.dart';

@immutable
class UserBrief {
  const UserBrief({required this.id, required this.name, this.avatar});

  final String id;
  final String name;
  final String? avatar;

  UserBrief copyWith({String? id, String? name, String? avatar}) {
    return UserBrief(
      id: id ?? this.id,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
    );
  }

  factory UserBrief.fromJson(Map<String, dynamic> json) {
    return UserBrief(
      id: json['id'] as String,
      name: json['name'] as String,
      avatar: json['avatar'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'avatar': avatar,
    };
  }
}
