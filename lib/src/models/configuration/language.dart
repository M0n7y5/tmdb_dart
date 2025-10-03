import 'package:json_annotation/json_annotation.dart';

part 'language.g.dart';

/// Represents a language in the TMDB API configuration
@JsonSerializable()
class Language {
  /// The ISO 639-1 language code
  @JsonKey(name: 'iso_639_1')
  final String iso6391;

  /// The English name of the language
  @JsonKey(name: 'english_name')
  final String englishName;

  /// The name of the language
  final String name;

  const Language({
    required this.iso6391,
    required this.englishName,
    required this.name,
  });

  /// Creates a [Language] from JSON
  factory Language.fromJson(Map<String, dynamic> json) =>
      _$LanguageFromJson(json);

  /// Converts this [Language] to JSON
  Map<String, dynamic> toJson() => _$LanguageToJson(this);
}
