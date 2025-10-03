import 'package:test/test.dart';
import 'package:tmdb_dart/src/models/credits/cast.dart';

void main() {
  group('Cast', () {
    // Sample complete JSON data
    const completeCastJson = {
      'id': 819,
      'adult': false,
      'gender': 2,
      'known_for_department': 'Acting',
      'name': 'Edward Norton',
      'original_name': 'Edward Norton',
      'popularity': 7.842,
      'profile_path': '/5XBzD5WuTyVQZeS4VI25z2moMeY.jpg',
      'cast_id': 3,
      'character': 'The Narrator',
      'credit_id': '52fe4250c3a36847f8014983',
      'order': 0,
    };

    // Sample minimal JSON data (required fields only)
    const minimalCastJson = {
      'id': 819,
      'adult': false,
      'name': 'Edward Norton',
      'original_name': 'Edward Norton',
      'popularity': 7.842,
      'cast_id': 3,
      'character': 'The Narrator',
      'credit_id': '52fe4250c3a36847f8014983',
      'order': 0,
    };

    // Sample JSON with null optional fields
    const nullOptionalFieldsJson = {
      'id': 819,
      'adult': false,
      'gender': null,
      'known_for_department': null,
      'name': 'Edward Norton',
      'original_name': 'Edward Norton',
      'popularity': 7.842,
      'profile_path': null,
      'cast_id': 3,
      'character': 'The Narrator',
      'credit_id': '52fe4250c3a36847f8014983',
      'order': 0,
    };

    // Sample JSON with empty strings
    const emptyStringsJson = {
      'id': 819,
      'adult': false,
      'gender': 2,
      'known_for_department': '',
      'name': 'Edward Norton',
      'original_name': 'Edward Norton',
      'popularity': 7.842,
      'profile_path': '',
      'cast_id': 3,
      'character': '',
      'credit_id': '52fe4250c3a36847f8014983',
      'order': 0,
    };

    group('fromJson', () {
      test('should correctly deserialize from JSON with all fields', () {
        // Act
        final cast = Cast.fromJson(completeCastJson);

        // Assert
        expect(cast.id, 819);
        expect(cast.adult, false);
        expect(cast.gender, 2);
        expect(cast.knownForDepartment, 'Acting');
        expect(cast.name, 'Edward Norton');
        expect(cast.originalName, 'Edward Norton');
        expect(cast.popularity, 7.842);
        expect(cast.profilePath, '/5XBzD5WuTyVQZeS4VI25z2moMeY.jpg');
        expect(cast.castId, 3);
        expect(cast.character, 'The Narrator');
        expect(cast.creditId, '52fe4250c3a36847f8014983');
        expect(cast.order, 0);
      });

      test(
          'should correctly deserialize from JSON with minimal required fields',
          () {
        // Act
        final cast = Cast.fromJson(minimalCastJson);

        // Assert
        expect(cast.id, 819);
        expect(cast.adult, false);
        expect(cast.gender, null);
        expect(cast.knownForDepartment, null);
        expect(cast.name, 'Edward Norton');
        expect(cast.originalName, 'Edward Norton');
        expect(cast.popularity, 7.842);
        expect(cast.profilePath, null);
        expect(cast.castId, 3);
        expect(cast.character, 'The Narrator');
        expect(cast.creditId, '52fe4250c3a36847f8014983');
        expect(cast.order, 0);
      });

      test('should correctly deserialize from JSON with null optional fields',
          () {
        // Act
        final cast = Cast.fromJson(nullOptionalFieldsJson);

        // Assert
        expect(cast.id, 819);
        expect(cast.adult, false);
        expect(cast.gender, null);
        expect(cast.knownForDepartment, null);
        expect(cast.name, 'Edward Norton');
        expect(cast.originalName, 'Edward Norton');
        expect(cast.popularity, 7.842);
        expect(cast.profilePath, null);
        expect(cast.castId, 3);
        expect(cast.character, 'The Narrator');
        expect(cast.creditId, '52fe4250c3a36847f8014983');
        expect(cast.order, 0);
      });

      test('should correctly deserialize from JSON with empty strings', () {
        // Act
        final cast = Cast.fromJson(emptyStringsJson);

        // Assert
        expect(cast.id, 819);
        expect(cast.adult, false);
        expect(cast.gender, 2);
        expect(cast.knownForDepartment, '');
        expect(cast.name, 'Edward Norton');
        expect(cast.originalName, 'Edward Norton');
        expect(cast.popularity, 7.842);
        expect(cast.profilePath, '');
        expect(cast.castId, 3);
        expect(cast.character, '');
        expect(cast.creditId, '52fe4250c3a36847f8014983');
        expect(cast.order, 0);
      });

      test('should handle different order values', () {
        // Arrange
        final jsonWithDifferentOrder =
            Map<String, dynamic>.from(completeCastJson);
        jsonWithDifferentOrder['order'] = 5;

        // Act
        final cast = Cast.fromJson(jsonWithDifferentOrder);

        // Assert
        expect(cast.order, 5);
      });

      test('should handle different gender values', () {
        // Arrange
        final jsonWithFemaleGender =
            Map<String, dynamic>.from(completeCastJson);
        jsonWithFemaleGender['gender'] = 1;

        final jsonWithNonBinaryGender =
            Map<String, dynamic>.from(completeCastJson);
        jsonWithNonBinaryGender['gender'] = 3;

        final jsonWithNotSpecifiedGender =
            Map<String, dynamic>.from(completeCastJson);
        jsonWithNotSpecifiedGender['gender'] = 0;

        // Act & Assert
        expect(Cast.fromJson(jsonWithFemaleGender).gender, 1);
        expect(Cast.fromJson(jsonWithNonBinaryGender).gender, 3);
        expect(Cast.fromJson(jsonWithNotSpecifiedGender).gender, 0);
      });
    });

    group('toJson', () {
      test('should correctly serialize to JSON with all fields', () {
        // Arrange
        const cast = Cast(
          id: 819,
          adult: false,
          gender: 2,
          knownForDepartment: 'Acting',
          name: 'Edward Norton',
          originalName: 'Edward Norton',
          popularity: 7.842,
          profilePath: '/5XBzD5WuTyVQZeS4VI25z2moMeY.jpg',
          castId: 3,
          character: 'The Narrator',
          creditId: '52fe4250c3a36847f8014983',
          order: 0,
        );

        // Act
        final json = cast.toJson();

        // Assert
        expect(json['id'], 819);
        expect(json['adult'], false);
        expect(json['gender'], 2);
        expect(json['known_for_department'], 'Acting');
        expect(json['name'], 'Edward Norton');
        expect(json['original_name'], 'Edward Norton');
        expect(json['popularity'], 7.842);
        expect(json['profile_path'], '/5XBzD5WuTyVQZeS4VI25z2moMeY.jpg');
        expect(json['cast_id'], 3);
        expect(json['character'], 'The Narrator');
        expect(json['credit_id'], '52fe4250c3a36847f8014983');
        expect(json['order'], 0);
      });

      test('should correctly serialize to JSON with null optional fields', () {
        // Arrange
        const cast = Cast(
          id: 819,
          adult: false,
          gender: null,
          knownForDepartment: null,
          name: 'Edward Norton',
          originalName: 'Edward Norton',
          popularity: 7.842,
          profilePath: null,
          castId: 3,
          character: 'The Narrator',
          creditId: '52fe4250c3a36847f8014983',
          order: 0,
        );

        // Act
        final json = cast.toJson();

        // Assert
        expect(json['id'], 819);
        expect(json['adult'], false);
        expect(json['gender'], null);
        expect(json['known_for_department'], null);
        expect(json['name'], 'Edward Norton');
        expect(json['original_name'], 'Edward Norton');
        expect(json['popularity'], 7.842);
        expect(json['profile_path'], null);
        expect(json['cast_id'], 3);
        expect(json['character'], 'The Narrator');
        expect(json['credit_id'], '52fe4250c3a36847f8014983');
        expect(json['order'], 0);
      });

      test('should correctly serialize to JSON with empty strings', () {
        // Arrange
        const cast = Cast(
          id: 819,
          adult: false,
          gender: 2,
          knownForDepartment: '',
          name: 'Edward Norton',
          originalName: 'Edward Norton',
          popularity: 7.842,
          profilePath: '',
          castId: 3,
          character: '',
          creditId: '52fe4250c3a36847f8014983',
          order: 0,
        );

        // Act
        final json = cast.toJson();

        // Assert
        expect(json['id'], 819);
        expect(json['adult'], false);
        expect(json['gender'], 2);
        expect(json['known_for_department'], '');
        expect(json['name'], 'Edward Norton');
        expect(json['original_name'], 'Edward Norton');
        expect(json['popularity'], 7.842);
        expect(json['profile_path'], '');
        expect(json['cast_id'], 3);
        expect(json['character'], '');
        expect(json['credit_id'], '52fe4250c3a36847f8014983');
        expect(json['order'], 0);
      });
    });

    group('round-trip', () {
      test(
          'should maintain data integrity through serialization cycle with all fields',
          () {
        // Arrange
        const originalCast = Cast(
          id: 819,
          adult: false,
          gender: 2,
          knownForDepartment: 'Acting',
          name: 'Edward Norton',
          originalName: 'Edward Norton',
          popularity: 7.842,
          profilePath: '/5XBzD5WuTyVQZeS4VI25z2moMeY.jpg',
          castId: 3,
          character: 'The Narrator',
          creditId: '52fe4250c3a36847f8014983',
          order: 0,
        );

        // Act
        final json = originalCast.toJson();
        final deserializedCast = Cast.fromJson(json);

        // Assert
        expect(deserializedCast.id, originalCast.id);
        expect(deserializedCast.adult, originalCast.adult);
        expect(deserializedCast.gender, originalCast.gender);
        expect(deserializedCast.knownForDepartment,
            originalCast.knownForDepartment);
        expect(deserializedCast.name, originalCast.name);
        expect(deserializedCast.originalName, originalCast.originalName);
        expect(deserializedCast.popularity, originalCast.popularity);
        expect(deserializedCast.profilePath, originalCast.profilePath);
        expect(deserializedCast.castId, originalCast.castId);
        expect(deserializedCast.character, originalCast.character);
        expect(deserializedCast.creditId, originalCast.creditId);
        expect(deserializedCast.order, originalCast.order);
      });

      test(
          'should maintain data integrity through serialization cycle with null optional fields',
          () {
        // Arrange
        const originalCast = Cast(
          id: 819,
          adult: false,
          gender: null,
          knownForDepartment: null,
          name: 'Edward Norton',
          originalName: 'Edward Norton',
          popularity: 7.842,
          profilePath: null,
          castId: 3,
          character: 'The Narrator',
          creditId: '52fe4250c3a36847f8014983',
          order: 0,
        );

        // Act
        final json = originalCast.toJson();
        final deserializedCast = Cast.fromJson(json);

        // Assert
        expect(deserializedCast.id, originalCast.id);
        expect(deserializedCast.adult, originalCast.adult);
        expect(deserializedCast.gender, originalCast.gender);
        expect(deserializedCast.knownForDepartment,
            originalCast.knownForDepartment);
        expect(deserializedCast.name, originalCast.name);
        expect(deserializedCast.originalName, originalCast.originalName);
        expect(deserializedCast.popularity, originalCast.popularity);
        expect(deserializedCast.profilePath, originalCast.profilePath);
        expect(deserializedCast.castId, originalCast.castId);
        expect(deserializedCast.character, originalCast.character);
        expect(deserializedCast.creditId, originalCast.creditId);
        expect(deserializedCast.order, originalCast.order);
      });

      test(
          'should maintain data integrity through serialization cycle with empty strings',
          () {
        // Arrange
        const originalCast = Cast(
          id: 819,
          adult: false,
          gender: 2,
          knownForDepartment: '',
          name: 'Edward Norton',
          originalName: 'Edward Norton',
          popularity: 7.842,
          profilePath: '',
          castId: 3,
          character: '',
          creditId: '52fe4250c3a36847f8014983',
          order: 0,
        );

        // Act
        final json = originalCast.toJson();
        final deserializedCast = Cast.fromJson(json);

        // Assert
        expect(deserializedCast.id, originalCast.id);
        expect(deserializedCast.adult, originalCast.adult);
        expect(deserializedCast.gender, originalCast.gender);
        expect(deserializedCast.knownForDepartment,
            originalCast.knownForDepartment);
        expect(deserializedCast.name, originalCast.name);
        expect(deserializedCast.originalName, originalCast.originalName);
        expect(deserializedCast.popularity, originalCast.popularity);
        expect(deserializedCast.profilePath, originalCast.profilePath);
        expect(deserializedCast.castId, originalCast.castId);
        expect(deserializedCast.character, originalCast.character);
        expect(deserializedCast.creditId, originalCast.creditId);
        expect(deserializedCast.order, originalCast.order);
      });
    });

    group('edge cases', () {
      test('should handle adult flag set to true', () {
        // Arrange
        final jsonWithAdult = Map<String, dynamic>.from(completeCastJson);
        jsonWithAdult['adult'] = true;

        // Act
        final cast = Cast.fromJson(jsonWithAdult);

        // Assert
        expect(cast.adult, true);
      });

      test('should handle zero popularity', () {
        // Arrange
        final jsonWithZeroPopularity =
            Map<String, dynamic>.from(completeCastJson);
        jsonWithZeroPopularity['popularity'] = 0.0;

        // Act
        final cast = Cast.fromJson(jsonWithZeroPopularity);

        // Assert
        expect(cast.popularity, 0.0);
      });

      test('should handle negative order value', () {
        // Arrange
        final jsonWithNegativeOrder =
            Map<String, dynamic>.from(completeCastJson);
        jsonWithNegativeOrder['order'] = -1;

        // Act
        final cast = Cast.fromJson(jsonWithNegativeOrder);

        // Assert
        expect(cast.order, -1);
      });

      test('should handle very large order value', () {
        // Arrange
        final jsonWithLargeOrder = Map<String, dynamic>.from(completeCastJson);
        jsonWithLargeOrder['order'] = 999999;

        // Act
        final cast = Cast.fromJson(jsonWithLargeOrder);

        // Assert
        expect(cast.order, 999999);
      });
    });
  });
}
