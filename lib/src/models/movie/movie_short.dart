import 'package:json_annotation/json_annotation.dart';

part 'movie_short.g.dart';

/// Represents a short movie model for search results and listings in the TMDB API
@JsonSerializable()
class MovieShort {
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

  /// The release date of the movie
  @JsonKey(
      name: 'release_date',
      fromJson: _dateTimeFromJson,
      toJson: _dateTimeToJson)
  final DateTime? releaseDate;

  /// The genre IDs of the movie
  @JsonKey(name: 'genre_ids')
  final List<int> genreIds;

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

  const MovieShort({
    required this.id,
    required this.adult,
    this.backdropPath,
    this.posterPath,
    required this.title,
    required this.originalTitle,
    required this.originalLanguage,
    required this.overview,
    this.releaseDate,
    required this.genreIds,
    required this.voteAverage,
    required this.voteCount,
    required this.popularity,
    required this.video,
  });

  /// Creates a [MovieShort] from JSON
  factory MovieShort.fromJson(Map<String, dynamic> json) =>
      _$MovieShortFromJson(json);

  /// Converts this [MovieShort] to JSON
  Map<String, dynamic> toJson() => _$MovieShortToJson(this);

  /// Converts a string to DateTime or returns null if empty
  static DateTime? _dateTimeFromJson(String? date) =>
      date != null && date.isNotEmpty ? DateTime.tryParse(date) : null;

  /// Converts a DateTime to ISO 8601 string or returns null
  static String? _dateTimeToJson(DateTime? date) => date?.toIso8601String();
}
