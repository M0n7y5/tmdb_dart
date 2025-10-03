import 'package:json_annotation/json_annotation.dart';

part 'person_credits.g.dart';

/// Represents a person's combined movie and TV credits in the TMDB API
@JsonSerializable()
class PersonCredits {
  /// The ID of the person
  final int id;

  /// The cast credits (can contain MovieShort or TvShowShort with character)
  final List<dynamic> cast;

  /// The crew credits (can contain MovieShort or TvShowShort with job)
  final List<dynamic> crew;

  const PersonCredits({
    required this.id,
    required this.cast,
    required this.crew,
  });

  /// Creates a [PersonCredits] from JSON
  factory PersonCredits.fromJson(Map<String, dynamic> json) =>
      _$PersonCreditsFromJson(json);

  /// Converts this [PersonCredits] to JSON
  Map<String, dynamic> toJson() => _$PersonCreditsToJson(this);
}

/// Represents a cast credit for a person in the TMDB API
@JsonSerializable()
class CastCredit {
  /// The ID of the person
  final int id;

  /// Whether the content is adult
  final bool adult;

  /// The backdrop path of the content
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;

  /// The poster path of the content
  @JsonKey(name: 'poster_path')
  final String? posterPath;

  /// The title of the movie (if movie)
  final String? title;

  /// The original title of the movie (if movie)
  @JsonKey(name: 'original_title')
  final String? originalTitle;

  /// The name of the TV show (if TV show)
  final String? name;

  /// The original name of the TV show (if TV show)
  @JsonKey(name: 'original_name')
  final String? originalName;

  /// The overview of the content
  final String overview;

  /// The release date of the movie (if movie)
  @JsonKey(
      name: 'release_date',
      fromJson: _dateTimeFromJson,
      toJson: _dateTimeToJson)
  final DateTime? releaseDate;

  /// The first air date of the TV show (if TV show)
  @JsonKey(
      name: 'first_air_date',
      fromJson: _dateTimeFromJson,
      toJson: _dateTimeToJson)
  final DateTime? firstAirDate;

  /// The genre IDs of the content
  @JsonKey(name: 'genre_ids')
  final List<int> genreIds;

  /// The vote average of the content
  @JsonKey(name: 'vote_average')
  final double voteAverage;

  /// The vote count of the content
  @JsonKey(name: 'vote_count')
  final int voteCount;

  /// The popularity of the content
  final double popularity;

  /// The character name
  final String character;

  /// The credit ID
  @JsonKey(name: 'credit_id')
  final String creditId;

  /// The order of the person in the cast
  final int? order;

  /// The media type (movie or tv)
  @JsonKey(name: 'media_type')
  final String? mediaType;

  /// The origin country (if TV show)
  @JsonKey(name: 'origin_country')
  final List<String>? originCountry;

  /// Whether the content has a video (if movie)
  final bool? video;

  const CastCredit({
    required this.id,
    required this.adult,
    this.backdropPath,
    this.posterPath,
    this.title,
    this.originalTitle,
    this.name,
    this.originalName,
    required this.overview,
    this.releaseDate,
    this.firstAirDate,
    required this.genreIds,
    required this.voteAverage,
    required this.voteCount,
    required this.popularity,
    required this.character,
    required this.creditId,
    this.order,
    this.mediaType,
    this.originCountry,
    this.video,
  });

  /// Creates a [CastCredit] from JSON
  factory CastCredit.fromJson(Map<String, dynamic> json) =>
      _$CastCreditFromJson(json);

  /// Converts this [CastCredit] to JSON
  Map<String, dynamic> toJson() => _$CastCreditToJson(this);

  /// Converts a string to DateTime or returns null if empty
  static DateTime? _dateTimeFromJson(String? date) =>
      date != null && date.isNotEmpty ? DateTime.tryParse(date) : null;

  /// Converts a DateTime to ISO 8601 string or returns null
  static String? _dateTimeToJson(DateTime? date) => date?.toIso8601String();
}

/// Represents a crew credit for a person in the TMDB API
@JsonSerializable()
class CrewCredit {
  /// The ID of the person
  final int id;

  /// Whether the content is adult
  final bool adult;

  /// The backdrop path of the content
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;

  /// The poster path of the content
  @JsonKey(name: 'poster_path')
  final String? posterPath;

  /// The title of the movie (if movie)
  final String? title;

  /// The original title of the movie (if movie)
  @JsonKey(name: 'original_title')
  final String? originalTitle;

  /// The name of the TV show (if TV show)
  final String? name;

  /// The original name of the TV show (if TV show)
  @JsonKey(name: 'original_name')
  final String? originalName;

  /// The overview of the content
  final String overview;

  /// The release date of the movie (if movie)
  @JsonKey(
      name: 'release_date',
      fromJson: _dateTimeFromJson,
      toJson: _dateTimeToJson)
  final DateTime? releaseDate;

  /// The first air date of the TV show (if TV show)
  @JsonKey(
      name: 'first_air_date',
      fromJson: _dateTimeFromJson,
      toJson: _dateTimeToJson)
  final DateTime? firstAirDate;

  /// The genre IDs of the content
  @JsonKey(name: 'genre_ids')
  final List<int> genreIds;

  /// The vote average of the content
  @JsonKey(name: 'vote_average')
  final double voteAverage;

  /// The vote count of the content
  @JsonKey(name: 'vote_count')
  final int voteCount;

  /// The popularity of the content
  final double popularity;

  /// The department the person worked in
  final String department;

  /// The job the person performed
  final String job;

  /// The credit ID
  @JsonKey(name: 'credit_id')
  final String creditId;

  /// The media type (movie or tv)
  @JsonKey(name: 'media_type')
  final String? mediaType;

  /// The origin country (if TV show)
  @JsonKey(name: 'origin_country')
  final List<String>? originCountry;

  /// Whether the content has a video (if movie)
  final bool? video;

  const CrewCredit({
    required this.id,
    required this.adult,
    this.backdropPath,
    this.posterPath,
    this.title,
    this.originalTitle,
    this.name,
    this.originalName,
    required this.overview,
    this.releaseDate,
    this.firstAirDate,
    required this.genreIds,
    required this.voteAverage,
    required this.voteCount,
    required this.popularity,
    required this.department,
    required this.job,
    required this.creditId,
    this.mediaType,
    this.originCountry,
    this.video,
  });

  /// Creates a [CrewCredit] from JSON
  factory CrewCredit.fromJson(Map<String, dynamic> json) =>
      _$CrewCreditFromJson(json);

  /// Converts this [CrewCredit] to JSON
  Map<String, dynamic> toJson() => _$CrewCreditToJson(this);

  /// Converts a string to DateTime or returns null if empty
  static DateTime? _dateTimeFromJson(String? date) =>
      date != null && date.isNotEmpty ? DateTime.tryParse(date) : null;

  /// Converts a DateTime to ISO 8601 string or returns null
  static String? _dateTimeToJson(DateTime? date) => date?.toIso8601String();
}
