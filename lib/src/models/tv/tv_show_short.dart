import 'package:json_annotation/json_annotation.dart';

part 'tv_show_short.g.dart';

/// Represents a short TV show model for search results and listings in the TMDB API
@JsonSerializable()
class TvShowShort {
  /// The ID of the TV show
  final int id;

  /// Whether the TV show is adult
  final bool adult;

  /// The backdrop path of the TV show
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;

  /// The poster path of the TV show
  @JsonKey(name: 'poster_path')
  final String? posterPath;

  /// The name of the TV show
  final String name;

  /// The original name of the TV show
  @JsonKey(name: 'original_name')
  final String originalName;

  /// The original language of the TV show
  @JsonKey(name: 'original_language')
  final String originalLanguage;

  /// The overview of the TV show
  final String overview;

  /// The first air date of the TV show
  @JsonKey(
      name: 'first_air_date',
      fromJson: _dateTimeFromJson,
      toJson: _dateTimeToJson)
  final DateTime? firstAirDate;

  /// The genre IDs of the TV show
  @JsonKey(name: 'genre_ids')
  final List<int> genreIds;

  /// The vote average of the TV show
  @JsonKey(name: 'vote_average')
  final double voteAverage;

  /// The vote count of the TV show
  @JsonKey(name: 'vote_count')
  final int voteCount;

  /// The popularity of the TV show
  final double popularity;

  /// The origin countries of the TV show
  @JsonKey(name: 'origin_country')
  final List<String> originCountry;

  const TvShowShort({
    required this.id,
    required this.adult,
    this.backdropPath,
    this.posterPath,
    required this.name,
    required this.originalName,
    required this.originalLanguage,
    required this.overview,
    this.firstAirDate,
    required this.genreIds,
    required this.voteAverage,
    required this.voteCount,
    required this.popularity,
    required this.originCountry,
  });

  /// Creates a [TvShowShort] from JSON
  factory TvShowShort.fromJson(Map<String, dynamic> json) =>
      _$TvShowShortFromJson(json);

  /// Converts this [TvShowShort] to JSON
  Map<String, dynamic> toJson() => _$TvShowShortToJson(this);

  /// Converts a string to DateTime or returns null if empty
  static DateTime? _dateTimeFromJson(String? date) =>
      date != null && date.isNotEmpty ? DateTime.tryParse(date) : null;

  /// Converts a DateTime to ISO 8601 string or returns null
  static String? _dateTimeToJson(DateTime? date) => date?.toIso8601String();
}
