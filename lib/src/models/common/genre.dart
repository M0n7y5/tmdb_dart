import 'package:json_annotation/json_annotation.dart';

part 'genre.g.dart';

/// Represents a genre in the TMDB API
@JsonSerializable()
class Genre {
  /// The ID of the genre
  final int id;

  /// The name of the genre
  final String name;

  const Genre({
    required this.id,
    required this.name,
  });

  /// Creates a [Genre] from JSON
  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);

  /// Converts this [Genre] to JSON
  Map<String, dynamic> toJson() => _$GenreToJson(this);
}
