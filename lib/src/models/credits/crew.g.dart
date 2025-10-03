// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crew.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Crew _$CrewFromJson(Map<String, dynamic> json) => Crew(
      id: (json['id'] as num).toInt(),
      adult: json['adult'] as bool,
      gender: (json['gender'] as num?)?.toInt(),
      knownForDepartment: json['known_for_department'] as String?,
      name: json['name'] as String,
      originalName: json['original_name'] as String,
      popularity: (json['popularity'] as num).toDouble(),
      profilePath: json['profile_path'] as String?,
      creditId: json['credit_id'] as String,
      department: json['department'] as String,
      job: json['job'] as String,
    );

Map<String, dynamic> _$CrewToJson(Crew instance) => <String, dynamic>{
      'id': instance.id,
      'adult': instance.adult,
      'gender': instance.gender,
      'known_for_department': instance.knownForDepartment,
      'name': instance.name,
      'original_name': instance.originalName,
      'popularity': instance.popularity,
      'profile_path': instance.profilePath,
      'credit_id': instance.creditId,
      'department': instance.department,
      'job': instance.job,
    };
