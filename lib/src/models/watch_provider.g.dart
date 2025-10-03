// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watch_provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WatchProvider _$WatchProviderFromJson(Map<String, dynamic> json) =>
    WatchProvider(
      logoPath: json['logo_path'] as String?,
      providerId: (json['provider_id'] as num).toInt(),
      providerName: json['provider_name'] as String,
      displayPriority: (json['display_priority'] as num).toInt(),
    );

Map<String, dynamic> _$WatchProviderToJson(WatchProvider instance) =>
    <String, dynamic>{
      'logo_path': instance.logoPath,
      'provider_id': instance.providerId,
      'provider_name': instance.providerName,
      'display_priority': instance.displayPriority,
    };
