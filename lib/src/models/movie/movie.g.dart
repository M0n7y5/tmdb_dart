// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie(
      id: (json['id'] as num).toInt(),
      adult: json['adult'] as bool,
      backdropPath: json['backdrop_path'] as String?,
      posterPath: json['poster_path'] as String?,
      title: json['title'] as String,
      originalTitle: json['original_title'] as String,
      originalLanguage: json['original_language'] as String,
      overview: json['overview'] as String,
      tagline: json['tagline'] as String?,
      releaseDate: Movie._dateTimeFromJson(json['release_date'] as String?),
      genres: (json['genres'] as List<dynamic>)
          .map((e) => Genre.fromJson(e as Map<String, dynamic>))
          .toList(),
      budget: (json['budget'] as num).toInt(),
      revenue: (json['revenue'] as num).toInt(),
      runtime: (json['runtime'] as num?)?.toInt(),
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: (json['vote_count'] as num).toInt(),
      popularity: (json['popularity'] as num).toDouble(),
      video: json['video'] as bool,
      homepage: json['homepage'] as String?,
      imdbId: json['imdb_id'] as String?,
      status: json['status'] as String?,
      productionCompanies: (json['production_companies'] as List<dynamic>)
          .map((e) => ProductionCompany.fromJson(e as Map<String, dynamic>))
          .toList(),
      productionCountries: (json['production_countries'] as List<dynamic>)
          .map((e) => ProductionCountry.fromJson(e as Map<String, dynamic>))
          .toList(),
      spokenLanguages: (json['spoken_languages'] as List<dynamic>)
          .map((e) => SpokenLanguage.fromJson(e as Map<String, dynamic>))
          .toList(),
      belongsToCollection: json['belongs_to_collection'] == null
          ? null
          : MovieCollection.fromJson(
              json['belongs_to_collection'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'id': instance.id,
      'adult': instance.adult,
      'backdrop_path': instance.backdropPath,
      'poster_path': instance.posterPath,
      'title': instance.title,
      'original_title': instance.originalTitle,
      'original_language': instance.originalLanguage,
      'overview': instance.overview,
      'tagline': instance.tagline,
      'release_date': Movie._dateTimeToJson(instance.releaseDate),
      'genres': instance.genres,
      'budget': instance.budget,
      'revenue': instance.revenue,
      'runtime': instance.runtime,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'popularity': instance.popularity,
      'video': instance.video,
      'homepage': instance.homepage,
      'imdb_id': instance.imdbId,
      'status': instance.status,
      'production_companies': instance.productionCompanies,
      'production_countries': instance.productionCountries,
      'spoken_languages': instance.spokenLanguages,
      'belongs_to_collection': instance.belongsToCollection,
    };

MovieCollection _$MovieCollectionFromJson(Map<String, dynamic> json) =>
    MovieCollection(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
    );

Map<String, dynamic> _$MovieCollectionToJson(MovieCollection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'poster_path': instance.posterPath,
      'backdrop_path': instance.backdropPath,
    };
