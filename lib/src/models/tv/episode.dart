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
  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      id: _intFromJson(json['id']),
      episodeNumber: _intFromJson(json['episode_number']),
      seasonNumber: _intFromJson(json['season_number']),
      name: _stringFromJson(json['name']),
      overview: _stringFromJson(json['overview']),
      airDate: _dateTimeFromJson(json['air_date'] as String?),
      runtime: _nullableIntFromJson(json['runtime']),
      stillPath: json['still_path'] as String?,
      voteAverage: _doubleFromJson(json['vote_average']),
      voteCount: _intFromJson(json['vote_count']),
      productionCode: json['production_code'] as String?,
      showId: _intFromJson(json['show_id']),
      crew: _crewFromJson(json['crew']),
      guestStars: _guestStarsFromJson(json['guest_stars']),
    );
  }

  /// Converts this [Episode] to JSON
  Map<String, dynamic> toJson() => _$EpisodeToJson(this);

  /// Converts a string to DateTime or returns null if empty
  static DateTime? _dateTimeFromJson(String? date) =>
      date != null && date.isNotEmpty ? DateTime.tryParse(date) : null;

  /// Converts a DateTime to ISO 8601 string or returns null
  static String? _dateTimeToJson(DateTime? date) => date?.toIso8601String();

  static int _intFromJson(dynamic value) {
    if (value is num) {
      return value.toInt();
    }
    if (value is String) {
      return int.tryParse(value) ?? 0;
    }
    return 0;
  }

  static int? _nullableIntFromJson(dynamic value) {
    if (value == null) {
      return null;
    }
    if (value is num) {
      return value.toInt();
    }
    if (value is String) {
      return int.tryParse(value);
    }
    return null;
  }

  static double _doubleFromJson(dynamic value) {
    if (value is num) {
      return value.toDouble();
    }
    if (value is String) {
      return double.tryParse(value) ?? 0.0;
    }
    return 0.0;
  }

  static String _stringFromJson(dynamic value) {
    if (value is String) {
      return value;
    }
    return '';
  }

  static List<Crew>? _crewFromJson(dynamic value) {
    if (value is! List) {
      return null;
    }

    final crew = <Crew>[];
    for (final item in value) {
      if (item is! Map) {
        continue;
      }

      try {
        crew.add(Crew.fromJson(Map<String, dynamic>.from(item)));
      } catch (_) {
        continue;
      }
    }

    return crew;
  }

  static List<Cast>? _guestStarsFromJson(dynamic value) {
    if (value is! List) {
      return null;
    }

    final cast = <Cast>[];
    for (final item in value) {
      if (item is! Map) {
        continue;
      }

      try {
        cast.add(Cast.fromJson(Map<String, dynamic>.from(item)));
      } catch (_) {
        continue;
      }
    }

    return cast;
  }
}
