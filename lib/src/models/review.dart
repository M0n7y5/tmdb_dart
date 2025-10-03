import 'package:json_annotation/json_annotation.dart';

part 'review.g.dart';

/// Represents a review in the TMDB API
@JsonSerializable()
class Review {
  /// The ID of the review
  final String id;

  /// The author of the review
  final String author;

  /// The details of the author
  @JsonKey(name: 'author_details')
  final AuthorDetails authorDetails;

  /// The content of the review
  final String content;

  /// The date when the review was created
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  /// The date when the review was updated
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  /// The URL of the review
  final String url;

  const Review({
    required this.id,
    required this.author,
    required this.authorDetails,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.url,
  });

  /// Creates a [Review] from JSON
  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  /// Converts this [Review] to JSON
  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}

/// Represents the author details of a review
@JsonSerializable()
class AuthorDetails {
  /// The name of the author
  final String? name;

  /// The username of the author
  final String? username;

  /// The avatar path of the author
  @JsonKey(name: 'avatar_path')
  final String? avatarPath;

  /// The rating given by the author
  final double? rating;

  const AuthorDetails({
    this.name,
    this.username,
    this.avatarPath,
    this.rating,
  });

  /// Creates a [AuthorDetails] from JSON
  factory AuthorDetails.fromJson(Map<String, dynamic> json) =>
      _$AuthorDetailsFromJson(json);

  /// Converts this [AuthorDetails] to JSON
  Map<String, dynamic> toJson() => _$AuthorDetailsToJson(this);
}
