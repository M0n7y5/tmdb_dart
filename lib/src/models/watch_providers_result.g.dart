// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watch_providers_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WatchProvidersResult _$WatchProvidersResultFromJson(
        Map<String, dynamic> json) =>
    WatchProvidersResult(
      results: (json['results'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k, CountryWatchProviders.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$WatchProvidersResultToJson(
        WatchProvidersResult instance) =>
    <String, dynamic>{
      'results': instance.results,
    };

CountryWatchProviders _$CountryWatchProvidersFromJson(
        Map<String, dynamic> json) =>
    CountryWatchProviders(
      link: json['link'] as String?,
      flatrate: (json['flatrate'] as List<dynamic>?)
          ?.map((e) => WatchProvider.fromJson(e as Map<String, dynamic>))
          .toList(),
      buy: (json['buy'] as List<dynamic>?)
          ?.map((e) => WatchProvider.fromJson(e as Map<String, dynamic>))
          .toList(),
      rent: (json['rent'] as List<dynamic>?)
          ?.map((e) => WatchProvider.fromJson(e as Map<String, dynamic>))
          .toList(),
      ads: (json['ads'] as List<dynamic>?)
          ?.map((e) => WatchProvider.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CountryWatchProvidersToJson(
        CountryWatchProviders instance) =>
    <String, dynamic>{
      'link': instance.link,
      'flatrate': instance.flatrate,
      'buy': instance.buy,
      'rent': instance.rent,
      'ads': instance.ads,
    };
