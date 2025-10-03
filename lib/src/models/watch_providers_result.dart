import 'package:json_annotation/json_annotation.dart';

import 'watch_provider.dart';

part 'watch_providers_result.g.dart';

/// Represents the watch providers result in the TMDB API
@JsonSerializable()
class WatchProvidersResult {
  /// The results mapped by country code
  final Map<String, CountryWatchProviders> results;

  const WatchProvidersResult({
    required this.results,
  });

  /// Creates a [WatchProvidersResult] from JSON
  factory WatchProvidersResult.fromJson(Map<String, dynamic> json) =>
      _$WatchProvidersResultFromJson(json);

  /// Converts this [WatchProvidersResult] to JSON
  Map<String, dynamic> toJson() => _$WatchProvidersResultToJson(this);
}

/// Represents the watch providers for a specific country
@JsonSerializable()
class CountryWatchProviders {
  /// The link to the watch providers page
  final String? link;

  /// The flatrate (subscription) providers
  final List<WatchProvider>? flatrate;

  /// The buy providers
  final List<WatchProvider>? buy;

  /// The rent providers
  final List<WatchProvider>? rent;

  /// The ad-supported providers
  final List<WatchProvider>? ads;

  const CountryWatchProviders({
    this.link,
    this.flatrate,
    this.buy,
    this.rent,
    this.ads,
  });

  /// Creates a [CountryWatchProviders] from JSON
  factory CountryWatchProviders.fromJson(Map<String, dynamic> json) =>
      _$CountryWatchProvidersFromJson(json);

  /// Converts this [CountryWatchProviders] to JSON
  Map<String, dynamic> toJson() => _$CountryWatchProvidersToJson(this);
}
