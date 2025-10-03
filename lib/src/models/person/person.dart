import 'package:json_annotation/json_annotation.dart';

part 'person.g.dart';

/// Represents a detailed person in the TMDB API
@JsonSerializable()
class Person {
  /// The ID of the person
  final int id;

  /// Whether the person is adult
  final bool adult;

  /// The name of the person
  final String name;

  /// Also known as names for the person
  @JsonKey(name: 'also_known_as')
  final List<String> alsoKnownAs;

  /// The biography of the person
  final String biography;

  /// The birthday of the person
  @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  final DateTime? birthday;

  /// The deathday of the person
  @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  final DateTime? deathday;

  /// The gender of the person (0: Not specified, 1: Female, 2: Male, 3: Non-binary)
  final int? gender;

  /// The homepage of the person
  final String? homepage;

  /// The department the person is known for
  @JsonKey(name: 'known_for_department')
  final String? knownForDepartment;

  /// The place of birth of the person
  @JsonKey(name: 'place_of_birth')
  final String? placeOfBirth;

  /// The popularity of the person
  final double popularity;

  /// The profile path of the person
  @JsonKey(name: 'profile_path')
  final String? profilePath;

  /// The IMDb ID of the person
  @JsonKey(name: 'imdb_id')
  final String? imdbId;

  const Person({
    required this.id,
    required this.adult,
    required this.name,
    required this.alsoKnownAs,
    required this.biography,
    this.birthday,
    this.deathday,
    this.gender,
    this.homepage,
    this.knownForDepartment,
    this.placeOfBirth,
    required this.popularity,
    this.profilePath,
    this.imdbId,
  });

  /// Creates a [Person] from JSON
  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  /// Converts this [Person] to JSON
  Map<String, dynamic> toJson() => _$PersonToJson(this);

  /// Converts a string to DateTime or returns null if empty
  static DateTime? _dateTimeFromJson(String? date) =>
      date != null && date.isNotEmpty ? DateTime.tryParse(date) : null;

  /// Converts a DateTime to ISO 8601 string or returns null
  static String? _dateTimeToJson(DateTime? date) => date?.toIso8601String();
}
