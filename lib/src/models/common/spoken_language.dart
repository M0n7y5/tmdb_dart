import 'package:json_annotation/json_annotation.dart';

part 'spoken_language.g.dart';

/// Represents a spoken language in the TMDB API
@JsonSerializable()
class SpokenLanguage {
  /// The ISO 639-1 language code
  @JsonKey(name: 'iso_639_1')
  final String iso6391;

  /// The name of the language
  final String name;

  /// The English name of the language
  @JsonKey(name: 'english_name')
  final String englishName;

  const SpokenLanguage({
    required this.iso6391,
    required this.name,
    required this.englishName,
  });

  /// Creates a [SpokenLanguage] from JSON
  factory SpokenLanguage.fromJson(Map<String, dynamic> json) =>
      _$SpokenLanguageFromJson(json);

  /// Converts this [SpokenLanguage] to JSON
  Map<String, dynamic> toJson() => _$SpokenLanguageToJson(this);
}
