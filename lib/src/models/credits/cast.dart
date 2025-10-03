import 'package:json_annotation/json_annotation.dart';

part 'cast.g.dart';

/// Represents a cast member in the TMDB API
@JsonSerializable()
class Cast {
  /// The ID of the person
  final int id;

  /// Whether the person is adult
  final bool adult;

  /// The gender of the person (0: Not specified, 1: Female, 2: Male, 3: Non-binary)
  final int? gender;

  /// The department the person is known for
  @JsonKey(name: 'known_for_department')
  final String? knownForDepartment;

  /// The name of the person
  final String name;

  /// The original name of the person
  @JsonKey(name: 'original_name')
  final String originalName;

  /// The popularity of the person
  final double popularity;

  /// The profile path of the person
  @JsonKey(name: 'profile_path')
  final String? profilePath;

  /// The cast ID
  @JsonKey(name: 'cast_id')
  final int castId;

  /// The character name
  final String character;

  /// The credit ID
  @JsonKey(name: 'credit_id')
  final String creditId;

  /// The order of the person in the cast
  final int order;

  const Cast({
    required this.id,
    required this.adult,
    this.gender,
    this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    this.profilePath,
    required this.castId,
    required this.character,
    required this.creditId,
    required this.order,
  });

  /// Creates a [Cast] from JSON
  factory Cast.fromJson(Map<String, dynamic> json) => _$CastFromJson(json);

  /// Converts this [Cast] to JSON
  Map<String, dynamic> toJson() => _$CastToJson(this);
}
