import 'package:json_annotation/json_annotation.dart';

part 'keyword.g.dart';

/// Represents a keyword in the TMDB API
@JsonSerializable()
class Keyword {
  /// The ID of the keyword
  final int id;

  /// The name of the keyword
  final String name;

  const Keyword({
    required this.id,
    required this.name,
  });

  /// Creates a [Keyword] from JSON
  factory Keyword.fromJson(Map<String, dynamic> json) =>
      _$KeywordFromJson(json);

  /// Converts this [Keyword] to JSON
  Map<String, dynamic> toJson() => _$KeywordToJson(this);
}
