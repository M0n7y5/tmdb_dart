import 'package:json_annotation/json_annotation.dart';

import '../common/genre.dart';
import '../common/production_company.dart';
import '../common/production_country.dart';
import '../common/spoken_language.dart';

part 'movie.g.dart';

/// Represents a detailed movie in the TMDB API
@JsonSerializable()
class Movie {
  /// The ID of the movie
  final int id;

  /// Whether the movie is adult
  final bool adult;

  /// The backdrop path of the movie
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;

  /// The poster path of the movie
  @JsonKey(name: 'poster_path')
  final String? posterPath;

  /// The title of the movie
  final String title;

  /// The original title of the movie
  @JsonKey(name: 'original_title')
  final String originalTitle;

  /// The original language of the movie
  @JsonKey(name: 'original_language')
  final String originalLanguage;

  /// The overview of the movie
  final String overview;

  /// The tagline of the movie
  final String? tagline;

  /// The release date of the movie
  @JsonKey(
      name: 'release_date',
      fromJson: _dateTimeFromJson,
      toJson: _dateTimeToJson)
  final DateTime? releaseDate;

  /// The genres of the movie
  final List<Genre> genres;

  /// The budget of the movie
  final int budget;

  /// The revenue of the movie
  final int revenue;

  /// The runtime of the movie in minutes
  final int? runtime;

  /// The vote average of the movie
  @JsonKey(name: 'vote_average')
  final double voteAverage;

  /// The vote count of the movie
  @JsonKey(name: 'vote_count')
  final int voteCount;

  /// The popularity of the movie
  final double popularity;

  /// Whether the movie has a video
  final bool video;

  /// The homepage of the movie
  final String? homepage;

  /// The IMDb ID of the movie
  @JsonKey(name: 'imdb_id')
  final String? imdbId;

  /// The status of the movie
  final String? status;

  /// The production companies of the movie
  @JsonKey(name: 'production_companies')
  final List<ProductionCompany> productionCompanies;

  /// The production countries of the movie
  @JsonKey(name: 'production_countries')
  final List<ProductionCountry> productionCountries;

  /// The spoken languages of the movie
  @JsonKey(name: 'spoken_languages')
  final List<SpokenLanguage> spokenLanguages;

  /// The collection this movie belongs to
  @JsonKey(name: 'belongs_to_collection')
  final MovieCollection? belongsToCollection;

  const Movie({
    required this.id,
    required this.adult,
    this.backdropPath,
    this.posterPath,
    required this.title,
    required this.originalTitle,
    required this.originalLanguage,
    required this.overview,
    this.tagline,
    this.releaseDate,
    required this.genres,
    required this.budget,
    required this.revenue,
    this.runtime,
    required this.voteAverage,
    required this.voteCount,
    required this.popularity,
    required this.video,
    this.homepage,
    this.imdbId,
    this.status,
    required this.productionCompanies,
    required this.productionCountries,
    required this.spokenLanguages,
    this.belongsToCollection,
  });

  /// Creates a [Movie] from JSON
  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  /// Converts this [Movie] to JSON
  Map<String, dynamic> toJson() => _$MovieToJson(this);

  /// Converts a string to DateTime or returns null if empty
  static DateTime? _dateTimeFromJson(String? date) =>
      date != null && date.isNotEmpty ? DateTime.tryParse(date) : null;

  /// Converts a DateTime to ISO 8601 string or returns null
  static String? _dateTimeToJson(DateTime? date) => date?.toIso8601String();
}

/// Represents a movie collection in the TMDB API
@JsonSerializable()
class MovieCollection {
  /// The ID of the collection
  final int id;

  /// The name of the collection
  final String name;

  /// The poster path of the collection
  @JsonKey(name: 'poster_path')
  final String? posterPath;

  /// The backdrop path of the collection
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;

  const MovieCollection({
    required this.id,
    required this.name,
    this.posterPath,
    this.backdropPath,
  });

  /// Creates a [MovieCollection] from JSON
  factory MovieCollection.fromJson(Map<String, dynamic> json) =>
      _$MovieCollectionFromJson(json);

  /// Converts this [MovieCollection] to JSON
  Map<String, dynamic> toJson() => _$MovieCollectionToJson(this);
}
