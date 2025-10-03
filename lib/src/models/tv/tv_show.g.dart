// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tv_show.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TvShow _$TvShowFromJson(Map<String, dynamic> json) => TvShow(
      id: (json['id'] as num).toInt(),
      adult: json['adult'] as bool,
      backdropPath: json['backdrop_path'] as String?,
      posterPath: json['poster_path'] as String?,
      name: json['name'] as String,
      originalName: json['original_name'] as String,
      originalLanguage: json['original_language'] as String,
      overview: json['overview'] as String,
      tagline: json['tagline'] as String?,
      firstAirDate: TvShow._dateTimeFromJson(json['first_air_date'] as String?),
      lastAirDate: TvShow._dateTimeFromJson(json['last_air_date'] as String?),
      genres: (json['genres'] as List<dynamic>)
          .map((e) => Genre.fromJson(e as Map<String, dynamic>))
          .toList(),
      episodeRunTime: (json['episode_run_time'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      numberOfEpisodes: (json['number_of_episodes'] as num?)?.toInt(),
      numberOfSeasons: (json['number_of_seasons'] as num?)?.toInt(),
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: (json['vote_count'] as num).toInt(),
      popularity: (json['popularity'] as num).toDouble(),
      homepage: json['homepage'] as String?,
      status: json['status'] as String?,
      type: json['type'] as String?,
      inProduction: json['in_production'] as bool?,
      languages:
          (json['languages'] as List<dynamic>).map((e) => e as String).toList(),
      originCountry: (json['origin_country'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      productionCompanies: (json['production_companies'] as List<dynamic>)
          .map((e) => ProductionCompany.fromJson(e as Map<String, dynamic>))
          .toList(),
      productionCountries: (json['production_countries'] as List<dynamic>)
          .map((e) => ProductionCountry.fromJson(e as Map<String, dynamic>))
          .toList(),
      spokenLanguages: (json['spoken_languages'] as List<dynamic>)
          .map((e) => SpokenLanguage.fromJson(e as Map<String, dynamic>))
          .toList(),
      networks: (json['networks'] as List<dynamic>)
          .map((e) => Network.fromJson(e as Map<String, dynamic>))
          .toList(),
      seasons: (json['seasons'] as List<dynamic>)
          .map((e) => Season.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdBy: (json['created_by'] as List<dynamic>)
          .map((e) => Creator.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TvShowToJson(TvShow instance) => <String, dynamic>{
      'id': instance.id,
      'adult': instance.adult,
      'backdrop_path': instance.backdropPath,
      'poster_path': instance.posterPath,
      'name': instance.name,
      'original_name': instance.originalName,
      'original_language': instance.originalLanguage,
      'overview': instance.overview,
      'tagline': instance.tagline,
      'first_air_date': TvShow._dateTimeToJson(instance.firstAirDate),
      'last_air_date': TvShow._dateTimeToJson(instance.lastAirDate),
      'genres': instance.genres,
      'episode_run_time': instance.episodeRunTime,
      'number_of_episodes': instance.numberOfEpisodes,
      'number_of_seasons': instance.numberOfSeasons,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'popularity': instance.popularity,
      'homepage': instance.homepage,
      'status': instance.status,
      'type': instance.type,
      'in_production': instance.inProduction,
      'languages': instance.languages,
      'origin_country': instance.originCountry,
      'production_companies': instance.productionCompanies,
      'production_countries': instance.productionCountries,
      'spoken_languages': instance.spokenLanguages,
      'networks': instance.networks,
      'seasons': instance.seasons,
      'created_by': instance.createdBy,
    };

Network _$NetworkFromJson(Map<String, dynamic> json) => Network(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      logoPath: json['logo_path'] as String?,
      originCountry: json['origin_country'] as String?,
    );

Map<String, dynamic> _$NetworkToJson(Network instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo_path': instance.logoPath,
      'origin_country': instance.originCountry,
    };

Creator _$CreatorFromJson(Map<String, dynamic> json) => Creator(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      profilePath: json['profile_path'] as String?,
      creditId: json['credit_id'] as String,
      gender: (json['gender'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CreatorToJson(Creator instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'profile_path': instance.profilePath,
      'credit_id': instance.creditId,
      'gender': instance.gender,
    };
