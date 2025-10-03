import 'package:json_annotation/json_annotation.dart';

part 'production_company.g.dart';

/// Represents a production company in the TMDB API
@JsonSerializable()
class ProductionCompany {
  /// The ID of the production company
  final int id;

  /// The name of the production company
  final String name;

  /// The logo path of the production company
  @JsonKey(name: 'logo_path')
  final String? logoPath;

  /// The origin country of the production company
  @JsonKey(name: 'origin_country')
  final String? originCountry;

  const ProductionCompany({
    required this.id,
    required this.name,
    this.logoPath,
    this.originCountry,
  });

  /// Creates a [ProductionCompany] from JSON
  factory ProductionCompany.fromJson(Map<String, dynamic> json) =>
      _$ProductionCompanyFromJson(json);

  /// Converts this [ProductionCompany] to JSON
  Map<String, dynamic> toJson() => _$ProductionCompanyToJson(this);
}
