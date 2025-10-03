// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_short.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieShort _$MovieShortFromJson(Map<String, dynamic> json) => MovieShort(
      id: (json['id'] as num).toInt(),
      adult: json['adult'] as bool,
      backdropPath: json['backdrop_path'] as String?,
      posterPath: json['poster_path'] as String?,
      title: json['title'] as String,
      originalTitle: json['original_title'] as String,
      originalLanguage: json['original_language'] as String,
      overview: json['overview'] as String,
      releaseDate:
          MovieShort._dateTimeFromJson(json['release_date'] as String?),
      genreIds: (json['genre_ids'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: (json['vote_count'] as num).toInt(),
      popularity: (json['popularity'] as num).toDouble(),
      video: json['video'] as bool,
    );

Map<String, dynamic> _$MovieShortToJson(MovieShort instance) =>
    <String, dynamic>{
      'id': instance.id,
      'adult': instance.adult,
      'backdrop_path': instance.backdropPath,
      'poster_path': instance.posterPath,
      'title': instance.title,
      'original_title': instance.originalTitle,
      'original_language': instance.originalLanguage,
      'overview': instance.overview,
      'release_date': MovieShort._dateTimeToJson(instance.releaseDate),
      'genre_ids': instance.genreIds,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'popularity': instance.popularity,
      'video': instance.video,
    };
