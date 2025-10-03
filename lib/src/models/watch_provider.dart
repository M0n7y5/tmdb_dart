import 'package:json_annotation/json_annotation.dart';

part 'watch_provider.g.dart';

/// Represents a watch provider in the TMDB API
@JsonSerializable()
class WatchProvider {
  /// The logo path of the provider
  @JsonKey(name: 'logo_path')
  final String? logoPath;

  /// The ID of the provider
  @JsonKey(name: 'provider_id')
  final int providerId;

  /// The name of the provider
  @JsonKey(name: 'provider_name')
  final String providerName;

  /// The display priority of the provider
  @JsonKey(name: 'display_priority')
  final int displayPriority;

  const WatchProvider({
    this.logoPath,
    required this.providerId,
    required this.providerName,
    required this.displayPriority,
  });

  /// Creates a [WatchProvider] from JSON
  factory WatchProvider.fromJson(Map<String, dynamic> json) =>
      _$WatchProviderFromJson(json);

  /// Converts this [WatchProvider] to JSON
  Map<String, dynamic> toJson() => _$WatchProviderToJson(this);
}
