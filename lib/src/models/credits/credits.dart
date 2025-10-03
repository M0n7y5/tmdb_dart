import 'package:json_annotation/json_annotation.dart';

import 'cast.dart';
import 'crew.dart';

part 'credits.g.dart';

/// Represents the credits (cast and crew) for a movie or TV show in the TMDB API
@JsonSerializable()
class Credits {
  /// The ID of the movie or TV show
  final int id;

  /// The list of cast members
  final List<Cast> cast;

  /// The list of crew members
  final List<Crew> crew;

  const Credits({
    required this.id,
    required this.cast,
    required this.crew,
  });

  /// Creates a [Credits] from JSON
  factory Credits.fromJson(Map<String, dynamic> json) =>
      _$CreditsFromJson(json);

  /// Converts this [Credits] to JSON
  Map<String, dynamic> toJson() => _$CreditsToJson(this);
}
