import 'package:flutter/foundation.dart';

import 'user_brief.dart';

@immutable
class Review {
  const Review({required this.id, required this.author, required this.rating, required this.comment});

  final String id;
  final UserBrief author;
  final int rating;
  final String comment;

  Review copyWith({String? id, UserBrief? author, int? rating, String? comment}) {
    return Review(
      id: id ?? this.id,
      author: author ?? this.author,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
    );
  }

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] as String,
      author: UserBrief.fromJson(json['author'] as Map<String, dynamic>),
      rating: json['rating'] as int,
      comment: json['comment'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'author': author.toJson(),
      'rating': rating,
      'comment': comment,
    };
  }
}
