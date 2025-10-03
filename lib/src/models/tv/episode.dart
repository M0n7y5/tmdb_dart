import 'package:json_annotation/json_annotation.dart';

import '../credits/cast.dart';
import '../credits/crew.dart';

part 'episode.g.dart';

/// Represents a TV show episode in the TMDB API
@JsonSerializable()
class Episode {
  /// The ID of the episode
  final int id;

  /// The episode number
  @JsonKey(name: 'episode_number')
  final int episodeNumber;

  /// The season number
  @JsonKey(name: 'season_number')
  final int seasonNumber;

  /// The name of the episode
  final String name;

  /// The overview of the episode
  final String overview;

  /// The air date of the episode
  @JsonKey(
      name: 'air_date', fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  final DateTime? airDate;

  /// The runtime of the episode in minutes
  final int? runtime;

  /// The still path of the episode
  @JsonKey(name: 'still_path')
  final String? stillPath;

  /// The vote average of the episode
  @JsonKey(name: 'vote_average')
  final double voteAverage;

  /// The vote count of the episode
  @JsonKey(name: 'vote_count')
  final int voteCount;

  /// The production code of the episode
  @JsonKey(name: 'production_code')
  final String? productionCode;

  /// The show ID of the episode
  @JsonKey(name: 'show_id')
  final int showId;

  /// The crew of the episode
  final List<Crew>? crew;

  /// The guest stars of the episode
  @JsonKey(name: 'guest_stars')
  final List<Cast>? guestStars;

  const Episode({
    required this.id,
    required this.episodeNumber,
    required this.seasonNumber,
    required this.name,
    required this.overview,
    this.airDate,
    this.runtime,
    this.stillPath,
    required this.voteAverage,
    required this.voteCount,
    this.productionCode,
    required this.showId,
    this.crew,
    this.guestStars,
  });

  /// Creates a [Episode] from JSON
  factory Episode.fromJson(Map<String, dynamic> json) =>
      _$EpisodeFromJson(json);

  /// Converts this [Episode] to JSON
  Map<String, dynamic> toJson() => _$EpisodeToJson(this);

  /// Converts a string to DateTime or returns null if empty
  static DateTime? _dateTimeFromJson(String? date) =>
      date != null && date.isNotEmpty ? DateTime.tryParse(date) : null;

  /// Converts a DateTime to ISO 8601 string or returns null
  static String? _dateTimeToJson(DateTime? date) => date?.toIso8601String();
}
