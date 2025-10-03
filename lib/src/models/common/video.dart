import 'package:json_annotation/json_annotation.dart';

part 'video.g.dart';

/// Represents a video (trailer, clip, teaser) in the TMDB API
@JsonSerializable()
class Video {
  /// The ID of the video
  final String id;

  /// The name of the video
  final String name;

  /// The key of the video (used to construct the YouTube URL)
  final String key;

  /// The site where the video is hosted (e.g., "YouTube")
  final String site;

  /// The size of the video
  final int? size;

  /// The type of the video (e.g., "Trailer", "Teaser", "Clip")
  final String type;

  /// Whether the video is official
  final bool? official;

  /// The date when the video was published
  @JsonKey(name: 'published_at')
  final DateTime? publishedAt;

  /// The ISO 639-1 language code of the video
  @JsonKey(name: 'iso_639_1')
  final String? iso6391;

  /// The ISO 3166-1 country code of the video
  @JsonKey(name: 'iso_3166_1')
  final String? iso31661;

  const Video({
    required this.id,
    required this.name,
    required this.key,
    required this.site,
    this.size,
    required this.type,
    this.official,
    this.publishedAt,
    this.iso6391,
    this.iso31661,
  });

  /// Creates a [Video] from JSON
  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);

  /// Converts this [Video] to JSON
  Map<String, dynamic> toJson() => _$VideoToJson(this);
}
