import 'package:json_annotation/json_annotation.dart';

import '../common/genre.dart';
import '../common/production_company.dart';
import '../common/production_country.dart';
import '../common/spoken_language.dart';
import 'season.dart';

part 'tv_show.g.dart';

/// Represents a detailed TV show in the TMDB API
@JsonSerializable()
class TvShow {
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

  /// The tagline of the TV show
  final String? tagline;

  /// The first air date of the TV show
  @JsonKey(
      name: 'first_air_date',
      fromJson: _dateTimeFromJson,
      toJson: _dateTimeToJson)
  final DateTime? firstAirDate;

  /// The last air date of the TV show
  @JsonKey(
      name: 'last_air_date',
      fromJson: _dateTimeFromJson,
      toJson: _dateTimeToJson)
  final DateTime? lastAirDate;

  /// The genres of the TV show
  final List<Genre> genres;

  /// The episode run times in minutes
  @JsonKey(name: 'episode_run_time')
  final List<int> episodeRunTime;

  /// The number of episodes
  @JsonKey(name: 'number_of_episodes')
  final int? numberOfEpisodes;

  /// The number of seasons
  @JsonKey(name: 'number_of_seasons')
  final int? numberOfSeasons;

  /// The vote average of the TV show
  @JsonKey(name: 'vote_average')
  final double voteAverage;

  /// The vote count of the TV show
  @JsonKey(name: 'vote_count')
  final int voteCount;

  /// The popularity of the TV show
  final double popularity;

  /// The homepage of the TV show
  final String? homepage;

  /// The status of the TV show
  final String? status;

  /// The type of the TV show
  final String? type;

  /// Whether the TV show is in production
  @JsonKey(name: 'in_production')
  final bool? inProduction;

  /// The languages of the TV show
  final List<String> languages;

  /// The origin countries of the TV show
  @JsonKey(name: 'origin_country')
  final List<String> originCountry;

  /// The production companies of the TV show
  @JsonKey(name: 'production_companies')
  final List<ProductionCompany> productionCompanies;

  /// The production countries of the TV show
  @JsonKey(name: 'production_countries')
  final List<ProductionCountry> productionCountries;

  /// The spoken languages of the TV show
  @JsonKey(name: 'spoken_languages')
  final List<SpokenLanguage> spokenLanguages;

  /// The networks of the TV show
  final List<Network> networks;

  /// The seasons of the TV show
  final List<Season> seasons;

  /// The creators of the TV show
  @JsonKey(name: 'created_by')
  final List<Creator> createdBy;

  const TvShow({
    required this.id,
    required this.adult,
    this.backdropPath,
    this.posterPath,
    required this.name,
    required this.originalName,
    required this.originalLanguage,
    required this.overview,
    this.tagline,
    this.firstAirDate,
    this.lastAirDate,
    required this.genres,
    required this.episodeRunTime,
    this.numberOfEpisodes,
    this.numberOfSeasons,
    required this.voteAverage,
    required this.voteCount,
    required this.popularity,
    this.homepage,
    this.status,
    this.type,
    this.inProduction,
    required this.languages,
    required this.originCountry,
    required this.productionCompanies,
    required this.productionCountries,
    required this.spokenLanguages,
    required this.networks,
    required this.seasons,
    required this.createdBy,
  });

  /// Creates a [TvShow] from JSON
  factory TvShow.fromJson(Map<String, dynamic> json) => _$TvShowFromJson(json);

  /// Converts this [TvShow] to JSON
  Map<String, dynamic> toJson() => _$TvShowToJson(this);

  /// Converts a string to DateTime or returns null if empty
  static DateTime? _dateTimeFromJson(String? date) =>
      date != null && date.isNotEmpty ? DateTime.tryParse(date) : null;

  /// Converts a DateTime to ISO 8601 string or returns null
  static String? _dateTimeToJson(DateTime? date) => date?.toIso8601String();
}

/// Represents a network in the TMDB API
@JsonSerializable()
class Network {
  /// The ID of the network
  final int id;

  /// The name of the network
  final String name;

  /// The logo path of the network
  @JsonKey(name: 'logo_path')
  final String? logoPath;

  /// The origin country of the network
  @JsonKey(name: 'origin_country')
  final String? originCountry;

  const Network({
    required this.id,
    required this.name,
    this.logoPath,
    this.originCountry,
  });

  /// Creates a [Network] from JSON
  factory Network.fromJson(Map<String, dynamic> json) =>
      _$NetworkFromJson(json);

  /// Converts this [Network] to JSON
  Map<String, dynamic> toJson() => _$NetworkToJson(this);
}

/// Represents a creator of a TV show in the TMDB API
@JsonSerializable()
class Creator {
  /// The ID of the creator
  final int id;

  /// The name of the creator
  final String name;

  /// The profile path of the creator
  @JsonKey(name: 'profile_path')
  final String? profilePath;

  /// The credit ID of the creator
  @JsonKey(name: 'credit_id')
  final String creditId;

  /// The gender of the creator (0: Not specified, 1: Female, 2: Male, 3: Non-binary)
  final int? gender;

  const Creator({
    required this.id,
    required this.name,
    this.profilePath,
    required this.creditId,
    this.gender,
  });

  /// Creates a [Creator] from JSON
  factory Creator.fromJson(Map<String, dynamic> json) =>
      _$CreatorFromJson(json);

  /// Converts this [Creator] to JSON
  Map<String, dynamic> toJson() => _$CreatorToJson(this);
}
