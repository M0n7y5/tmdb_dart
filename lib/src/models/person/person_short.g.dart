// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_short.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonShort _$PersonShortFromJson(Map<String, dynamic> json) => PersonShort(
      id: (json['id'] as num).toInt(),
      adult: json['adult'] as bool,
      name: json['name'] as String,
      gender: (json['gender'] as num?)?.toInt(),
      knownForDepartment: json['known_for_department'] as String?,
      popularity: (json['popularity'] as num).toDouble(),
      profilePath: json['profile_path'] as String?,
      knownFor: json['known_for'] as List<dynamic>?,
    );

Map<String, dynamic> _$PersonShortToJson(PersonShort instance) =>
    <String, dynamic>{
      'id': instance.id,
      'adult': instance.adult,
      'name': instance.name,
      'gender': instance.gender,
      'known_for_department': instance.knownForDepartment,
      'popularity': instance.popularity,
      'profile_path': instance.profilePath,
      'known_for': instance.knownFor,
    };
