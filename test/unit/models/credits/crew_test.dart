import 'package:test/test.dart';
import 'package:tmdb_dart/src/models/credits/crew.dart';

void main() {
  group('Crew', () {
    // Sample complete JSON data
    const completeCrewJson = {
      'id': 819,
      'adult': false,
      'gender': 2,
      'known_for_department': 'Acting',
      'name': 'Edward Norton',
      'original_name': 'Edward Norton',
      'popularity': 7.842,
      'profile_path': '/5XBzD5WuTyVQZeS4VI25z2moMeY.jpg',
      'credit_id': '52fe4250c3a36847f8014983',
      'department': 'Directing',
      'job': 'Director',
    };

    // Sample minimal JSON data (required fields only)
    const minimalCrewJson = {
      'id': 819,
      'adult': false,
      'name': 'Edward Norton',
      'original_name': 'Edward Norton',
      'popularity': 7.842,
      'credit_id': '52fe4250c3a36847f8014983',
      'department': 'Directing',
      'job': 'Director',
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
      'credit_id': '52fe4250c3a36847f8014983',
      'department': 'Directing',
      'job': 'Director',
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
      'credit_id': '52fe4250c3a36847f8014983',
      'department': '',
      'job': '',
    };

    group('fromJson', () {
      test('should correctly deserialize from JSON with all fields', () {
        // Act
        final crew = Crew.fromJson(completeCrewJson);

        // Assert
        expect(crew.id, 819);
        expect(crew.adult, false);
        expect(crew.gender, 2);
        expect(crew.knownForDepartment, 'Acting');
        expect(crew.name, 'Edward Norton');
        expect(crew.originalName, 'Edward Norton');
        expect(crew.popularity, 7.842);
        expect(crew.profilePath, '/5XBzD5WuTyVQZeS4VI25z2moMeY.jpg');
        expect(crew.creditId, '52fe4250c3a36847f8014983');
        expect(crew.department, 'Directing');
        expect(crew.job, 'Director');
      });

      test(
          'should correctly deserialize from JSON with minimal required fields',
          () {
        // Act
        final crew = Crew.fromJson(minimalCrewJson);

        // Assert
        expect(crew.id, 819);
        expect(crew.adult, false);
        expect(crew.gender, null);
        expect(crew.knownForDepartment, null);
        expect(crew.name, 'Edward Norton');
        expect(crew.originalName, 'Edward Norton');
        expect(crew.popularity, 7.842);
        expect(crew.profilePath, null);
        expect(crew.creditId, '52fe4250c3a36847f8014983');
        expect(crew.department, 'Directing');
        expect(crew.job, 'Director');
      });

      test('should correctly deserialize from JSON with null optional fields',
          () {
        // Act
        final crew = Crew.fromJson(nullOptionalFieldsJson);

        // Assert
        expect(crew.id, 819);
        expect(crew.adult, false);
        expect(crew.gender, null);
        expect(crew.knownForDepartment, null);
        expect(crew.name, 'Edward Norton');
        expect(crew.originalName, 'Edward Norton');
        expect(crew.popularity, 7.842);
        expect(crew.profilePath, null);
        expect(crew.creditId, '52fe4250c3a36847f8014983');
        expect(crew.department, 'Directing');
        expect(crew.job, 'Director');
      });

      test('should correctly deserialize from JSON with empty strings', () {
        // Act
        final crew = Crew.fromJson(emptyStringsJson);

        // Assert
        expect(crew.id, 819);
        expect(crew.adult, false);
        expect(crew.gender, 2);
        expect(crew.knownForDepartment, '');
        expect(crew.name, 'Edward Norton');
        expect(crew.originalName, 'Edward Norton');
        expect(crew.popularity, 7.842);
        expect(crew.profilePath, '');
        expect(crew.creditId, '52fe4250c3a36847f8014983');
        expect(crew.department, '');
        expect(crew.job, '');
      });

      test('should handle different department values', () {
        // Arrange
        final jsonWithProductionDept =
            Map<String, dynamic>.from(completeCrewJson);
        jsonWithProductionDept['department'] = 'Production';

        final jsonWithWritingDept = Map<String, dynamic>.from(completeCrewJson);
        jsonWithWritingDept['department'] = 'Writing';

        final jsonWithSoundDept = Map<String, dynamic>.from(completeCrewJson);
        jsonWithSoundDept['department'] = 'Sound';

        // Act & Assert
        expect(Crew.fromJson(jsonWithProductionDept).department, 'Production');
        expect(Crew.fromJson(jsonWithWritingDept).department, 'Writing');
        expect(Crew.fromJson(jsonWithSoundDept).department, 'Sound');
      });

      test('should handle different job values', () {
        // Arrange
        final jsonWithProducer = Map<String, dynamic>.from(completeCrewJson);
        jsonWithProducer['job'] = 'Producer';

        final jsonWithWriter = Map<String, dynamic>.from(completeCrewJson);
        jsonWithWriter['job'] = 'Writer';

        final jsonWithEditor = Map<String, dynamic>.from(completeCrewJson);
        jsonWithEditor['job'] = 'Editor';

        // Act & Assert
        expect(Crew.fromJson(jsonWithProducer).job, 'Producer');
        expect(Crew.fromJson(jsonWithWriter).job, 'Writer');
        expect(Crew.fromJson(jsonWithEditor).job, 'Editor');
      });

      test('should handle different gender values', () {
        // Arrange
        final jsonWithFemaleGender =
            Map<String, dynamic>.from(completeCrewJson);
        jsonWithFemaleGender['gender'] = 1;

        final jsonWithNonBinaryGender =
            Map<String, dynamic>.from(completeCrewJson);
        jsonWithNonBinaryGender['gender'] = 3;

        final jsonWithNotSpecifiedGender =
            Map<String, dynamic>.from(completeCrewJson);
        jsonWithNotSpecifiedGender['gender'] = 0;

        // Act & Assert
        expect(Crew.fromJson(jsonWithFemaleGender).gender, 1);
        expect(Crew.fromJson(jsonWithNonBinaryGender).gender, 3);
        expect(Crew.fromJson(jsonWithNotSpecifiedGender).gender, 0);
      });
    });

    group('toJson', () {
      test('should correctly serialize to JSON with all fields', () {
        // Arrange
        const crew = Crew(
          id: 819,
          adult: false,
          gender: 2,
          knownForDepartment: 'Acting',
          name: 'Edward Norton',
          originalName: 'Edward Norton',
          popularity: 7.842,
          profilePath: '/5XBzD5WuTyVQZeS4VI25z2moMeY.jpg',
          creditId: '52fe4250c3a36847f8014983',
          department: 'Directing',
          job: 'Director',
        );

        // Act
        final json = crew.toJson();

        // Assert
        expect(json['id'], 819);
        expect(json['adult'], false);
        expect(json['gender'], 2);
        expect(json['known_for_department'], 'Acting');
        expect(json['name'], 'Edward Norton');
        expect(json['original_name'], 'Edward Norton');
        expect(json['popularity'], 7.842);
        expect(json['profile_path'], '/5XBzD5WuTyVQZeS4VI25z2moMeY.jpg');
        expect(json['credit_id'], '52fe4250c3a36847f8014983');
        expect(json['department'], 'Directing');
        expect(json['job'], 'Director');
      });

      test('should correctly serialize to JSON with null optional fields', () {
        // Arrange
        const crew = Crew(
          id: 819,
          adult: false,
          gender: null,
          knownForDepartment: null,
          name: 'Edward Norton',
          originalName: 'Edward Norton',
          popularity: 7.842,
          profilePath: null,
          creditId: '52fe4250c3a36847f8014983',
          department: 'Directing',
          job: 'Director',
        );

        // Act
        final json = crew.toJson();

        // Assert
        expect(json['id'], 819);
        expect(json['adult'], false);
        expect(json['gender'], null);
        expect(json['known_for_department'], null);
        expect(json['name'], 'Edward Norton');
        expect(json['original_name'], 'Edward Norton');
        expect(json['popularity'], 7.842);
        expect(json['profile_path'], null);
        expect(json['credit_id'], '52fe4250c3a36847f8014983');
        expect(json['department'], 'Directing');
        expect(json['job'], 'Director');
      });

      test('should correctly serialize to JSON with empty strings', () {
        // Arrange
        const crew = Crew(
          id: 819,
          adult: false,
          gender: 2,
          knownForDepartment: '',
          name: 'Edward Norton',
          originalName: 'Edward Norton',
          popularity: 7.842,
          profilePath: '',
          creditId: '52fe4250c3a36847f8014983',
          department: '',
          job: '',
        );

        // Act
        final json = crew.toJson();

        // Assert
        expect(json['id'], 819);
        expect(json['adult'], false);
        expect(json['gender'], 2);
        expect(json['known_for_department'], '');
        expect(json['name'], 'Edward Norton');
        expect(json['original_name'], 'Edward Norton');
        expect(json['popularity'], 7.842);
        expect(json['profile_path'], '');
        expect(json['credit_id'], '52fe4250c3a36847f8014983');
        expect(json['department'], '');
        expect(json['job'], '');
      });
    });

    group('round-trip', () {
      test(
          'should maintain data integrity through serialization cycle with all fields',
          () {
        // Arrange
        const originalCrew = Crew(
          id: 819,
          adult: false,
          gender: 2,
          knownForDepartment: 'Acting',
          name: 'Edward Norton',
          originalName: 'Edward Norton',
          popularity: 7.842,
          profilePath: '/5XBzD5WuTyVQZeS4VI25z2moMeY.jpg',
          creditId: '52fe4250c3a36847f8014983',
          department: 'Directing',
          job: 'Director',
        );

        // Act
        final json = originalCrew.toJson();
        final deserializedCrew = Crew.fromJson(json);

        // Assert
        expect(deserializedCrew.id, originalCrew.id);
        expect(deserializedCrew.adult, originalCrew.adult);
        expect(deserializedCrew.gender, originalCrew.gender);
        expect(deserializedCrew.knownForDepartment,
            originalCrew.knownForDepartment);
        expect(deserializedCrew.name, originalCrew.name);
        expect(deserializedCrew.originalName, originalCrew.originalName);
        expect(deserializedCrew.popularity, originalCrew.popularity);
        expect(deserializedCrew.profilePath, originalCrew.profilePath);
        expect(deserializedCrew.creditId, originalCrew.creditId);
        expect(deserializedCrew.department, originalCrew.department);
        expect(deserializedCrew.job, originalCrew.job);
      });

      test(
          'should maintain data integrity through serialization cycle with null optional fields',
          () {
        // Arrange
        const originalCrew = Crew(
          id: 819,
          adult: false,
          gender: null,
          knownForDepartment: null,
          name: 'Edward Norton',
          originalName: 'Edward Norton',
          popularity: 7.842,
          profilePath: null,
          creditId: '52fe4250c3a36847f8014983',
          department: 'Directing',
          job: 'Director',
        );

        // Act
        final json = originalCrew.toJson();
        final deserializedCrew = Crew.fromJson(json);

        // Assert
        expect(deserializedCrew.id, originalCrew.id);
        expect(deserializedCrew.adult, originalCrew.adult);
        expect(deserializedCrew.gender, originalCrew.gender);
        expect(deserializedCrew.knownForDepartment,
            originalCrew.knownForDepartment);
        expect(deserializedCrew.name, originalCrew.name);
        expect(deserializedCrew.originalName, originalCrew.originalName);
        expect(deserializedCrew.popularity, originalCrew.popularity);
        expect(deserializedCrew.profilePath, originalCrew.profilePath);
        expect(deserializedCrew.creditId, originalCrew.creditId);
        expect(deserializedCrew.department, originalCrew.department);
        expect(deserializedCrew.job, originalCrew.job);
      });

      test(
          'should maintain data integrity through serialization cycle with empty strings',
          () {
        // Arrange
        const originalCrew = Crew(
          id: 819,
          adult: false,
          gender: 2,
          knownForDepartment: '',
          name: 'Edward Norton',
          originalName: 'Edward Norton',
          popularity: 7.842,
          profilePath: '',
          creditId: '52fe4250c3a36847f8014983',
          department: '',
          job: '',
        );

        // Act
        final json = originalCrew.toJson();
        final deserializedCrew = Crew.fromJson(json);

        // Assert
        expect(deserializedCrew.id, originalCrew.id);
        expect(deserializedCrew.adult, originalCrew.adult);
        expect(deserializedCrew.gender, originalCrew.gender);
        expect(deserializedCrew.knownForDepartment,
            originalCrew.knownForDepartment);
        expect(deserializedCrew.name, originalCrew.name);
        expect(deserializedCrew.originalName, originalCrew.originalName);
        expect(deserializedCrew.popularity, originalCrew.popularity);
        expect(deserializedCrew.profilePath, originalCrew.profilePath);
        expect(deserializedCrew.creditId, originalCrew.creditId);
        expect(deserializedCrew.department, originalCrew.department);
        expect(deserializedCrew.job, originalCrew.job);
      });
    });

    group('edge cases', () {
      test('should handle adult flag set to true', () {
        // Arrange
        final jsonWithAdult = Map<String, dynamic>.from(completeCrewJson);
        jsonWithAdult['adult'] = true;

        // Act
        final crew = Crew.fromJson(jsonWithAdult);

        // Assert
        expect(crew.adult, true);
      });

      test('should handle zero popularity', () {
        // Arrange
        final jsonWithZeroPopularity =
            Map<String, dynamic>.from(completeCrewJson);
        jsonWithZeroPopularity['popularity'] = 0.0;

        // Act
        final crew = Crew.fromJson(jsonWithZeroPopularity);

        // Assert
        expect(crew.popularity, 0.0);
      });

      test('should handle multi-word job titles', () {
        // Arrange
        final jsonWithMultiWordJob =
            Map<String, dynamic>.from(completeCrewJson);
        jsonWithMultiWordJob['job'] = 'Executive Producer';

        // Act
        final crew = Crew.fromJson(jsonWithMultiWordJob);

        // Assert
        expect(crew.job, 'Executive Producer');
      });

      test('should handle special characters in job titles', () {
        // Arrange
        final jsonWithSpecialChars =
            Map<String, dynamic>.from(completeCrewJson);
        jsonWithSpecialChars['job'] = 'Co-Producer / Assistant Director';

        // Act
        final crew = Crew.fromJson(jsonWithSpecialChars);

        // Assert
        expect(crew.job, 'Co-Producer / Assistant Director');
      });

      test('should handle multi-word department names', () {
        // Arrange
        final jsonWithMultiWordDept =
            Map<String, dynamic>.from(completeCrewJson);
        jsonWithMultiWordDept['department'] = 'Visual Effects';

        // Act
        final crew = Crew.fromJson(jsonWithMultiWordDept);

        // Assert
        expect(crew.department, 'Visual Effects');
      });

      test('should handle various production departments', () {
        // Arrange
        final departments = [
          'Directing',
          'Writing',
          'Production',
          'Camera',
          'Editing',
          'Art',
          'Sound',
          'Costume & Make-Up',
          'Visual Effects',
          'Lighting'
        ];

        for (final dept in departments) {
          final json = Map<String, dynamic>.from(completeCrewJson);
          json['department'] = dept;

          // Act & Assert
          expect(Crew.fromJson(json).department, dept);
        }
      });

      test('should handle various job titles', () {
        // Arrange
        final jobs = [
          'Director',
          'Producer',
          'Writer',
          'Editor',
          'Cinematographer',
          'Composer',
          'Production Designer',
          'Costume Designer',
          'Makeup Artist'
        ];

        for (final job in jobs) {
          final json = Map<String, dynamic>.from(completeCrewJson);
          json['job'] = job;

          // Act & Assert
          expect(Crew.fromJson(json).job, job);
        }
      });
    });
  });
}
