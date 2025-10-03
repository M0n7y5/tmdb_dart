import 'package:json_annotation/json_annotation.dart';

part 'api_configuration.g.dart';

/// Represents the API configuration in the TMDB API
@JsonSerializable()
class ApiConfiguration {
  /// The images configuration
  final ImagesConfiguration images;

  /// The list of change keys
  @JsonKey(name: 'change_keys')
  final List<String> changeKeys;

  const ApiConfiguration({
    required this.images,
    required this.changeKeys,
  });

  /// Creates a [ApiConfiguration] from JSON
  factory ApiConfiguration.fromJson(Map<String, dynamic> json) =>
      _$ApiConfigurationFromJson(json);

  /// Converts this [ApiConfiguration] to JSON
  Map<String, dynamic> toJson() => _$ApiConfigurationToJson(this);
}

/// Represents the images configuration in the TMDB API
@JsonSerializable()
class ImagesConfiguration {
  /// The base URL for images
  @JsonKey(name: 'base_url')
  final String baseUrl;

  /// The secure base URL for images
  @JsonKey(name: 'secure_base_url')
  final String secureBaseUrl;

  /// The available backdrop sizes
  @JsonKey(name: 'backdrop_sizes')
  final List<String> backdropSizes;

  /// The available logo sizes
  @JsonKey(name: 'logo_sizes')
  final List<String> logoSizes;

  /// The available poster sizes
  @JsonKey(name: 'poster_sizes')
  final List<String> posterSizes;

  /// The available profile sizes
  @JsonKey(name: 'profile_sizes')
  final List<String> profileSizes;

  /// The available still sizes
  @JsonKey(name: 'still_sizes')
  final List<String> stillSizes;

  const ImagesConfiguration({
    required this.baseUrl,
    required this.secureBaseUrl,
    required this.backdropSizes,
    required this.logoSizes,
    required this.posterSizes,
    required this.profileSizes,
    required this.stillSizes,
  });

  /// Creates a [ImagesConfiguration] from JSON
  factory ImagesConfiguration.fromJson(Map<String, dynamic> json) =>
      _$ImagesConfigurationFromJson(json);

  /// Converts this [ImagesConfiguration] to JSON
  Map<String, dynamic> toJson() => _$ImagesConfigurationToJson(this);
}
