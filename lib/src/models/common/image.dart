import 'package:json_annotation/json_annotation.dart';

part 'image.g.dart';

/// Represents an image (poster, backdrop, still, profile) in the TMDB API
@JsonSerializable()
class TmdbImage {
  /// The aspect ratio of the image
  @JsonKey(name: 'aspect_ratio')
  final double? aspectRatio;

  /// The height of the image in pixels
  final int? height;

  /// The width of the image in pixels
  final int? width;

  /// The file path of the image
  @JsonKey(name: 'file_path')
  final String? filePath;

  /// The average vote for this image
  @JsonKey(name: 'vote_average')
  final double? voteAverage;

  /// The number of votes for this image
  @JsonKey(name: 'vote_count')
  final int? voteCount;

  /// The ISO 639-1 language code of the image
  @JsonKey(name: 'iso_639_1')
  final String? iso6391;

  const TmdbImage({
    this.aspectRatio,
    this.height,
    this.width,
    this.filePath,
    this.voteAverage,
    this.voteCount,
    this.iso6391,
  });

  /// Creates a [TmdbImage] from JSON
  factory TmdbImage.fromJson(Map<String, dynamic> json) =>
      _$TmdbImageFromJson(json);

  /// Converts this [TmdbImage] to JSON
  Map<String, dynamic> toJson() => _$TmdbImageToJson(this);
}
