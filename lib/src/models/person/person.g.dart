// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) => Person(
      id: (json['id'] as num).toInt(),
      adult: json['adult'] as bool,
      name: json['name'] as String,
      alsoKnownAs: (json['also_known_as'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      biography: json['biography'] as String,
      birthday: Person._dateTimeFromJson(json['birthday'] as String?),
      deathday: Person._dateTimeFromJson(json['deathday'] as String?),
      gender: (json['gender'] as num?)?.toInt(),
      homepage: json['homepage'] as String?,
      knownForDepartment: json['known_for_department'] as String?,
      placeOfBirth: json['place_of_birth'] as String?,
      popularity: (json['popularity'] as num).toDouble(),
      profilePath: json['profile_path'] as String?,
      imdbId: json['imdb_id'] as String?,
    );

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'id': instance.id,
      'adult': instance.adult,
      'name': instance.name,
      'also_known_as': instance.alsoKnownAs,
      'biography': instance.biography,
      'birthday': Person._dateTimeToJson(instance.birthday),
      'deathday': Person._dateTimeToJson(instance.deathday),
      'gender': instance.gender,
      'homepage': instance.homepage,
      'known_for_department': instance.knownForDepartment,
      'place_of_birth': instance.placeOfBirth,
      'popularity': instance.popularity,
      'profile_path': instance.profilePath,
      'imdb_id': instance.imdbId,
    };
