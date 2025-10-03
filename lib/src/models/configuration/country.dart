import 'package:json_annotation/json_annotation.dart';

part 'country.g.dart';

/// Represents a country in the TMDB API configuration
@JsonSerializable()
class Country {
  /// The ISO 3166-1 country code
  @JsonKey(name: 'iso_3166_1')
  final String iso31661;

  /// The English name of the country
  @JsonKey(name: 'english_name')
  final String englishName;

  /// The native name of the country
  @JsonKey(name: 'native_name')
  final String nativeName;

  const Country({
    required this.iso31661,
    required this.englishName,
    required this.nativeName,
  });

  /// Creates a [Country] from JSON
  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);

  /// Converts this [Country] to JSON
  Map<String, dynamic> toJson() => _$CountryToJson(this);
}
