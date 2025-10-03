// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_credits.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonCredits _$PersonCreditsFromJson(Map<String, dynamic> json) =>
    PersonCredits(
      id: (json['id'] as num).toInt(),
      cast: json['cast'] as List<dynamic>,
      crew: json['crew'] as List<dynamic>,
    );

Map<String, dynamic> _$PersonCreditsToJson(PersonCredits instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cast': instance.cast,
      'crew': instance.crew,
    };

CastCredit _$CastCreditFromJson(Map<String, dynamic> json) => CastCredit(
      id: (json['id'] as num).toInt(),
      adult: json['adult'] as bool,
      backdropPath: json['backdrop_path'] as String?,
      posterPath: json['poster_path'] as String?,
      title: json['title'] as String?,
      originalTitle: json['original_title'] as String?,
      name: json['name'] as String?,
      originalName: json['original_name'] as String?,
      overview: json['overview'] as String,
      releaseDate:
          CastCredit._dateTimeFromJson(json['release_date'] as String?),
      firstAirDate:
          CastCredit._dateTimeFromJson(json['first_air_date'] as String?),
      genreIds: (json['genre_ids'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: (json['vote_count'] as num).toInt(),
      popularity: (json['popularity'] as num).toDouble(),
      character: json['character'] as String,
      creditId: json['credit_id'] as String,
      order: (json['order'] as num?)?.toInt(),
      mediaType: json['media_type'] as String?,
      originCountry: (json['origin_country'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      video: json['video'] as bool?,
    );

Map<String, dynamic> _$CastCreditToJson(CastCredit instance) =>
    <String, dynamic>{
      'id': instance.id,
      'adult': instance.adult,
      'backdrop_path': instance.backdropPath,
      'poster_path': instance.posterPath,
      'title': instance.title,
      'original_title': instance.originalTitle,
      'name': instance.name,
      'original_name': instance.originalName,
      'overview': instance.overview,
      'release_date': CastCredit._dateTimeToJson(instance.releaseDate),
      'first_air_date': CastCredit._dateTimeToJson(instance.firstAirDate),
      'genre_ids': instance.genreIds,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'popularity': instance.popularity,
      'character': instance.character,
      'credit_id': instance.creditId,
      'order': instance.order,
      'media_type': instance.mediaType,
      'origin_country': instance.originCountry,
      'video': instance.video,
    };

CrewCredit _$CrewCreditFromJson(Map<String, dynamic> json) => CrewCredit(
      id: (json['id'] as num).toInt(),
      adult: json['adult'] as bool,
      backdropPath: json['backdrop_path'] as String?,
      posterPath: json['poster_path'] as String?,
      title: json['title'] as String?,
      originalTitle: json['original_title'] as String?,
      name: json['name'] as String?,
      originalName: json['original_name'] as String?,
      overview: json['overview'] as String,
      releaseDate:
          CrewCredit._dateTimeFromJson(json['release_date'] as String?),
      firstAirDate:
          CrewCredit._dateTimeFromJson(json['first_air_date'] as String?),
      genreIds: (json['genre_ids'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: (json['vote_count'] as num).toInt(),
      popularity: (json['popularity'] as num).toDouble(),
      department: json['department'] as String,
      job: json['job'] as String,
      creditId: json['credit_id'] as String,
      mediaType: json['media_type'] as String?,
      originCountry: (json['origin_country'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      video: json['video'] as bool?,
    );

Map<String, dynamic> _$CrewCreditToJson(CrewCredit instance) =>
    <String, dynamic>{
      'id': instance.id,
      'adult': instance.adult,
      'backdrop_path': instance.backdropPath,
      'poster_path': instance.posterPath,
      'title': instance.title,
      'original_title': instance.originalTitle,
      'name': instance.name,
      'original_name': instance.originalName,
      'overview': instance.overview,
      'release_date': CrewCredit._dateTimeToJson(instance.releaseDate),
      'first_air_date': CrewCredit._dateTimeToJson(instance.firstAirDate),
      'genre_ids': instance.genreIds,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'popularity': instance.popularity,
      'department': instance.department,
      'job': instance.job,
      'credit_id': instance.creditId,
      'media_type': instance.mediaType,
      'origin_country': instance.originCountry,
      'video': instance.video,
    };
