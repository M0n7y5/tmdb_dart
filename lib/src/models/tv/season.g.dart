// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'season.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Season _$SeasonFromJson(Map<String, dynamic> json) => Season(
      id: (json['id'] as num).toInt(),
      seasonNumber: (json['season_number'] as num).toInt(),
      name: json['name'] as String,
      overview: json['overview'] as String,
      airDate: Season._dateTimeFromJson(json['air_date'] as String?),
      episodeCount: (json['episode_count'] as num).toInt(),
      posterPath: json['poster_path'] as String?,
      voteAverage: (json['vote_average'] as num).toDouble(),
      episodes: (json['episodes'] as List<dynamic>?)
          ?.map((e) => Episode.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SeasonToJson(Season instance) => <String, dynamic>{
      'id': instance.id,
      'season_number': instance.seasonNumber,
      'name': instance.name,
      'overview': instance.overview,
      'air_date': Season._dateTimeToJson(instance.airDate),
      'episode_count': instance.episodeCount,
      'poster_path': instance.posterPath,
      'vote_average': instance.voteAverage,
      'episodes': instance.episodes,
    };
