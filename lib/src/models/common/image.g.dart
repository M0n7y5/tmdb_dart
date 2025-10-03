// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TmdbImage _$TmdbImageFromJson(Map<String, dynamic> json) => TmdbImage(
      aspectRatio: (json['aspect_ratio'] as num?)?.toDouble(),
      height: (json['height'] as num?)?.toInt(),
      width: (json['width'] as num?)?.toInt(),
      filePath: json['file_path'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      voteCount: (json['vote_count'] as num?)?.toInt(),
      iso6391: json['iso_639_1'] as String?,
    );

Map<String, dynamic> _$TmdbImageToJson(TmdbImage instance) => <String, dynamic>{
      'aspect_ratio': instance.aspectRatio,
      'height': instance.height,
      'width': instance.width,
      'file_path': instance.filePath,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'iso_639_1': instance.iso6391,
    };
