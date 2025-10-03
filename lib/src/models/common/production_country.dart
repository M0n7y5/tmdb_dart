import 'package:json_annotation/json_annotation.dart';

part 'production_country.g.dart';

/// Represents a production country in the TMDB API
@JsonSerializable()
class ProductionCountry {
  /// The ISO 3166-1 country code
  @JsonKey(name: 'iso_3166_1')
  final String iso31661;

  /// The name of the country
  final String name;

  const ProductionCountry({
    required this.iso31661,
    required this.name,
  });

  /// Creates a [ProductionCountry] from JSON
  factory ProductionCountry.fromJson(Map<String, dynamic> json) =>
      _$ProductionCountryFromJson(json);

  /// Converts this [ProductionCountry] to JSON
  Map<String, dynamic> toJson() => _$ProductionCountryToJson(this);
}
