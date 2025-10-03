import 'package:json_annotation/json_annotation.dart';

part 'crew.g.dart';

/// Represents a crew member in the TMDB API
@JsonSerializable()
class Crew {
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

  /// The credit ID
  @JsonKey(name: 'credit_id')
  final String creditId;

  /// The department the person worked in
  final String department;

  /// The job the person performed
  final String job;

  const Crew({
    required this.id,
    required this.adult,
    this.gender,
    this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    this.profilePath,
    required this.creditId,
    required this.department,
    required this.job,
  });

  /// Creates a [Crew] from JSON
  factory Crew.fromJson(Map<String, dynamic> json) => _$CrewFromJson(json);

  /// Converts this [Crew] to JSON
  Map<String, dynamic> toJson() => _$CrewToJson(this);
}
