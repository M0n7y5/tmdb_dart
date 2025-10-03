import 'package:json_annotation/json_annotation.dart';

part 'external_ids.g.dart';

/// Represents external IDs for a person or media item in the TMDB API
@JsonSerializable()
class ExternalIds {
  /// The IMDB ID
  @JsonKey(name: 'imdb_id')
  final String? imdbId;

  /// The Facebook ID
  @JsonKey(name: 'facebook_id')
  final String? facebookId;

  /// The Instagram ID
  @JsonKey(name: 'instagram_id')
  final String? instagramId;

  /// The Twitter ID
  @JsonKey(name: 'twitter_id')
  final String? twitterId;

  /// The Wikidata ID
  @JsonKey(name: 'wikidata_id')
  final String? wikidataId;

  const ExternalIds({
    this.imdbId,
    this.facebookId,
    this.instagramId,
    this.twitterId,
    this.wikidataId,
  });

  /// Creates a [ExternalIds] from JSON
  factory ExternalIds.fromJson(Map<String, dynamic> json) =>
      _$ExternalIdsFromJson(json);

  /// Converts this [ExternalIds] to JSON
  Map<String, dynamic> toJson() => _$ExternalIdsToJson(this);
}
