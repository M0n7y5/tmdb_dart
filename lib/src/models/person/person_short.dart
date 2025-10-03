import 'package:json_annotation/json_annotation.dart';

part 'person_short.g.dart';

/// Represents a short person model for search results in the TMDB API
@JsonSerializable()
class PersonShort {
  /// The ID of the person
  final int id;

  /// Whether the person is adult
  final bool adult;

  /// The name of the person
  final String name;

  /// The gender of the person (0: Not specified, 1: Female, 2: Male, 3: Non-binary)
  final int? gender;

  /// The department the person is known for
  @JsonKey(name: 'known_for_department')
  final String? knownForDepartment;

  /// The popularity of the person
  final double popularity;

  /// The profile path of the person
  @JsonKey(name: 'profile_path')
  final String? profilePath;

  /// What the person is known for (can contain MovieShort or TvShowShort)
  @JsonKey(name: 'known_for')
  final List<dynamic>? knownFor;

  const PersonShort({
    required this.id,
    required this.adult,
    required this.name,
    this.gender,
    this.knownForDepartment,
    required this.popularity,
    this.profilePath,
    this.knownFor,
  });

  /// Creates a [PersonShort] from JSON
  factory PersonShort.fromJson(Map<String, dynamic> json) =>
      _$PersonShortFromJson(json);

  /// Converts this [PersonShort] to JSON
  Map<String, dynamic> toJson() => _$PersonShortToJson(this);
}
