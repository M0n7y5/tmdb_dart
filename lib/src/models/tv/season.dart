import 'package:json_annotation/json_annotation.dart';

import 'episode.dart';

part 'season.g.dart';

/// Represents a TV show season in the TMDB API
@JsonSerializable()
class Season {
  /// The ID of the season
  final int id;

  /// The season number
  @JsonKey(name: 'season_number')
  final int seasonNumber;

  /// The name of the season
  final String name;

  /// The overview of the season
  final String overview;

  /// The air date of the season
  @JsonKey(
      name: 'air_date', fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  final DateTime? airDate;

  /// The number of episodes in the season
  @JsonKey(name: 'episode_count')
  final int episodeCount;

  /// The poster path of the season
  @JsonKey(name: 'poster_path')
  final String? posterPath;

  /// The vote average of the season
  @JsonKey(name: 'vote_average')
  final double voteAverage;

  /// The episodes in the season (for detailed season info)
  final List<Episode>? episodes;

  const Season({
    required this.id,
    required this.seasonNumber,
    required this.name,
    required this.overview,
    this.airDate,
    required this.episodeCount,
    this.posterPath,
    required this.voteAverage,
    this.episodes,
  });

  /// Creates a [Season] from JSON
  factory Season.fromJson(Map<String, dynamic> json) => _$SeasonFromJson(json);

  /// Converts this [Season] to JSON
  Map<String, dynamic> toJson() => _$SeasonToJson(this);

  /// Converts a string to DateTime or returns null if empty
  static DateTime? _dateTimeFromJson(String? date) =>
      date != null && date.isNotEmpty ? DateTime.tryParse(date) : null;

  /// Converts a DateTime to ISO 8601 string or returns null
  static String? _dateTimeToJson(DateTime? date) => date?.toIso8601String();
}
