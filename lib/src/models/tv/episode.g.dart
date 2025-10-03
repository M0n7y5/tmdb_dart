// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Episode _$EpisodeFromJson(Map<String, dynamic> json) => Episode(
      id: (json['id'] as num).toInt(),
      episodeNumber: (json['episode_number'] as num).toInt(),
      seasonNumber: (json['season_number'] as num).toInt(),
      name: json['name'] as String,
      overview: json['overview'] as String,
      airDate: Episode._dateTimeFromJson(json['air_date'] as String?),
      runtime: (json['runtime'] as num?)?.toInt(),
      stillPath: json['still_path'] as String?,
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: (json['vote_count'] as num).toInt(),
      productionCode: json['production_code'] as String?,
      showId: (json['show_id'] as num).toInt(),
      crew: (json['crew'] as List<dynamic>?)
          ?.map((e) => Crew.fromJson(e as Map<String, dynamic>))
          .toList(),
      guestStars: (json['guest_stars'] as List<dynamic>?)
          ?.map((e) => Cast.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EpisodeToJson(Episode instance) => <String, dynamic>{
      'id': instance.id,
      'episode_number': instance.episodeNumber,
      'season_number': instance.seasonNumber,
      'name': instance.name,
      'overview': instance.overview,
      'air_date': Episode._dateTimeToJson(instance.airDate),
      'runtime': instance.runtime,
      'still_path': instance.stillPath,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'production_code': instance.productionCode,
      'show_id': instance.showId,
      'crew': instance.crew,
      'guest_stars': instance.guestStars,
    };
