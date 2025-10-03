// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tv_show_short.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TvShowShort _$TvShowShortFromJson(Map<String, dynamic> json) => TvShowShort(
      id: (json['id'] as num).toInt(),
      adult: json['adult'] as bool,
      backdropPath: json['backdrop_path'] as String?,
      posterPath: json['poster_path'] as String?,
      name: json['name'] as String,
      originalName: json['original_name'] as String,
      originalLanguage: json['original_language'] as String,
      overview: json['overview'] as String,
      firstAirDate:
          TvShowShort._dateTimeFromJson(json['first_air_date'] as String?),
      genreIds: (json['genre_ids'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: (json['vote_count'] as num).toInt(),
      popularity: (json['popularity'] as num).toDouble(),
      originCountry: (json['origin_country'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$TvShowShortToJson(TvShowShort instance) =>
    <String, dynamic>{
      'id': instance.id,
      'adult': instance.adult,
      'backdrop_path': instance.backdropPath,
      'poster_path': instance.posterPath,
      'name': instance.name,
      'original_name': instance.originalName,
      'original_language': instance.originalLanguage,
      'overview': instance.overview,
      'first_air_date': TvShowShort._dateTimeToJson(instance.firstAirDate),
      'genre_ids': instance.genreIds,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'popularity': instance.popularity,
      'origin_country': instance.originCountry,
    };
