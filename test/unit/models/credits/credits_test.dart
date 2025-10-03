import 'package:test/test.dart';
import 'package:tmdb_dart/src/models/credits/credits.dart';
import 'package:tmdb_dart/src/models/credits/cast.dart';
import 'package:tmdb_dart/src/models/credits/crew.dart';

void main() {
  group('Credits', () {
    // Sample cast members
    const castMember1 = Cast(
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

    const castMember2 = Cast(
      id: 819,
      adult: false,
      gender: 1,
      knownForDepartment: 'Acting',
      name: 'Helena Bonham Carter',
      originalName: 'Helena Bonham Carter',
      popularity: 6.842,
      profilePath: '/58oJAGbCKvW5YvN3dZ6w6WcQKp.jpg',
      castId: 4,
      character: 'Marla Singer',
      creditId: '52fe4250c3a36847f8014987',
      order: 1,
    );

    // Sample crew members
    const crewMember1 = Crew(
      id: 7467,
      adult: false,
      gender: 2,
      knownForDepartment: 'Directing',
      name: 'David Fincher',
      originalName: 'David Fincher',
      popularity: 8.421,
      profilePath: '/dcBHejOsKvzVZVozWJAPzYthb8X.jpg',
      creditId: '52fe4250c3a36847f8014937',
      department: 'Directing',
      job: 'Director',
    );

    const crewMember2 = Crew(
      id: 7467,
      adult: false,
      gender: 2,
      knownForDepartment: 'Writing',
      name: 'Chuck Palahniuk',
      originalName: 'Chuck Palahniuk',
      popularity: 3.141,
      profilePath: null,
      creditId: '52fe4250c3a36847f801493d',
      department: 'Writing',
      job: 'Novel',
    );

    // Sample complete JSON data
    final completeCreditsJson = {
      'id': 550,
      'cast': [
        {
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
        },
        {
          'id': 819,
          'adult': false,
          'gender': 1,
          'known_for_department': 'Acting',
          'name': 'Helena Bonham Carter',
          'original_name': 'Helena Bonham Carter',
          'popularity': 6.842,
          'profile_path': '/58oJAGbCKvW5YvN3dZ6w6WcQKp.jpg',
          'cast_id': 4,
          'character': 'Marla Singer',
          'credit_id': '52fe4250c3a36847f8014987',
          'order': 1,
        },
      ],
      'crew': [
        {
          'id': 7467,
          'adult': false,
          'gender': 2,
          'known_for_department': 'Directing',
          'name': 'David Fincher',
          'original_name': 'David Fincher',
          'popularity': 8.421,
          'profile_path': '/dcBHejOsKvzVZVozWJAPzYthb8X.jpg',
          'credit_id': '52fe4250c3a36847f8014937',
          'department': 'Directing',
          'job': 'Director',
        },
        {
          'id': 7467,
          'adult': false,
          'gender': 2,
          'known_for_department': 'Writing',
          'name': 'Chuck Palahniuk',
          'original_name': 'Chuck Palahniuk',
          'popularity': 3.141,
          'profile_path': null,
          'credit_id': '52fe4250c3a36847f801493d',
          'department': 'Writing',
          'job': 'Novel',
        },
      ],
    };

    // Sample JSON with empty arrays
    const emptyArraysJson = {
      'id': 550,
      'cast': [],
      'crew': [],
    };

    // Sample JSON with only cast
    final onlyCastJson = {
      'id': 550,
      'cast': [
        {
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
        },
      ],
      'crew': [],
    };

    // Sample JSON with only crew
    final onlyCrewJson = {
      'id': 550,
      'cast': [],
      'crew': [
        {
          'id': 7467,
          'adult': false,
          'gender': 2,
          'known_for_department': 'Directing',
          'name': 'David Fincher',
          'original_name': 'David Fincher',
          'popularity': 8.421,
          'profile_path': '/dcBHejOsKvzVZVozWJAPzYthb8X.jpg',
          'credit_id': '52fe4250c3a36847f8014937',
          'department': 'Directing',
          'job': 'Director',
        },
      ],
    };

    group('fromJson', () {
      test('should correctly deserialize from JSON with all fields', () {
        // Act
        final credits = Credits.fromJson(completeCreditsJson);

        // Assert
        expect(credits.id, 550);
        expect(credits.cast.length, 2);
        expect(credits.crew.length, 2);

        // Verify first cast member
        expect(credits.cast[0].id, 819);
        expect(credits.cast[0].name, 'Edward Norton');
        expect(credits.cast[0].character, 'The Narrator');
        expect(credits.cast[0].order, 0);

        // Verify second cast member
        expect(credits.cast[1].id, 819);
        expect(credits.cast[1].name, 'Helena Bonham Carter');
        expect(credits.cast[1].character, 'Marla Singer');
        expect(credits.cast[1].order, 1);

        // Verify first crew member
        expect(credits.crew[0].id, 7467);
        expect(credits.crew[0].name, 'David Fincher');
        expect(credits.crew[0].department, 'Directing');
        expect(credits.crew[0].job, 'Director');

        // Verify second crew member
        expect(credits.crew[1].id, 7467);
        expect(credits.crew[1].name, 'Chuck Palahniuk');
        expect(credits.crew[1].department, 'Writing');
        expect(credits.crew[1].job, 'Novel');
      });

      test('should correctly deserialize from JSON with empty arrays', () {
        // Act
        final credits = Credits.fromJson(emptyArraysJson);

        // Assert
        expect(credits.id, 550);
        expect(credits.cast.isEmpty, true);
        expect(credits.crew.isEmpty, true);
      });

      test('should correctly deserialize from JSON with only cast', () {
        // Act
        final credits = Credits.fromJson(onlyCastJson);

        // Assert
        expect(credits.id, 550);
        expect(credits.cast.length, 1);
        expect(credits.crew.isEmpty, true);

        expect(credits.cast[0].id, 819);
        expect(credits.cast[0].name, 'Edward Norton');
        expect(credits.cast[0].character, 'The Narrator');
      });

      test('should correctly deserialize from JSON with only crew', () {
        // Act
        final credits = Credits.fromJson(onlyCrewJson);

        // Assert
        expect(credits.id, 550);
        expect(credits.cast.isEmpty, true);
        expect(credits.crew.length, 1);

        expect(credits.crew[0].id, 7467);
        expect(credits.crew[0].name, 'David Fincher');
        expect(credits.crew[0].department, 'Directing');
        expect(credits.crew[0].job, 'Director');
      });

      test('should handle large cast and crew arrays', () {
        // Arrange
        final largeJson = {
          'id': 550,
          'cast': List.generate(
              50,
              (index) => {
                    'id': 819 + index,
                    'adult': false,
                    'name': 'Actor $index',
                    'original_name': 'Actor $index',
                    'popularity': 7.842,
                    'cast_id': 3 + index,
                    'character': 'Character $index',
                    'credit_id': '52fe4250c3a36847f8014983$index',
                    'order': index,
                  }),
          'crew': List.generate(
              30,
              (index) => {
                    'id': 7467 + index,
                    'adult': false,
                    'name': 'Crew $index',
                    'original_name': 'Crew $index',
                    'popularity': 8.421,
                    'credit_id': '52fe4250c3a36847f8014937$index',
                    'department': 'Department $index',
                    'job': 'Job $index',
                  }),
        };

        // Act
        final credits = Credits.fromJson(largeJson);

        // Assert
        expect(credits.id, 550);
        expect(credits.cast.length, 50);
        expect(credits.crew.length, 30);

        for (int i = 0; i < 50; i++) {
          expect(credits.cast[i].id, 819 + i);
          expect(credits.cast[i].name, 'Actor $i');
          expect(credits.cast[i].character, 'Character $i');
          expect(credits.cast[i].order, i);
        }

        for (int i = 0; i < 30; i++) {
          expect(credits.crew[i].id, 7467 + i);
          expect(credits.crew[i].name, 'Crew $i');
          expect(credits.crew[i].department, 'Department $i');
          expect(credits.crew[i].job, 'Job $i');
        }
      });

      test('should handle different ID values', () {
        // Arrange
        final jsonWithDifferentId =
            Map<String, dynamic>.from(completeCreditsJson);
        jsonWithDifferentId['id'] = 12345;

        // Act
        final credits = Credits.fromJson(jsonWithDifferentId);

        // Assert
        expect(credits.id, 12345);
        expect(credits.cast.length, 2);
        expect(credits.crew.length, 2);
      });
    });

    group('toJson', () {
      test('should correctly serialize to JSON with all fields', () {
        // Arrange
        const credits = Credits(
          id: 550,
          cast: [castMember1, castMember2],
          crew: [crewMember1, crewMember2],
        );

        // Act
        final json = credits.toJson();

        // Assert
        expect(json['id'], 550);
        expect(json['cast'].length, 2);
        expect(json['crew'].length, 2);

        // Verify cast objects (they should be Cast objects, not maps)
        expect(json['cast'][0], isA<Cast>());
        expect(json['cast'][1], isA<Cast>());
        expect(json['crew'][0], isA<Crew>());
        expect(json['crew'][1], isA<Crew>());

        // Verify first cast member
        expect(json['cast'][0].id, 819);
        expect(json['cast'][0].name, 'Edward Norton');
        expect(json['cast'][0].character, 'The Narrator');
        expect(json['cast'][0].order, 0);

        // Verify second cast member
        expect(json['cast'][1].id, 819);
        expect(json['cast'][1].name, 'Helena Bonham Carter');
        expect(json['cast'][1].character, 'Marla Singer');
        expect(json['cast'][1].order, 1);

        // Verify first crew member
        expect(json['crew'][0].id, 7467);
        expect(json['crew'][0].name, 'David Fincher');
        expect(json['crew'][0].department, 'Directing');
        expect(json['crew'][0].job, 'Director');

        // Verify second crew member
        expect(json['crew'][1].id, 7467);
        expect(json['crew'][1].name, 'Chuck Palahniuk');
        expect(json['crew'][1].department, 'Writing');
        expect(json['crew'][1].job, 'Novel');
      });

      test('should correctly serialize to JSON with empty arrays', () {
        // Arrange
        const credits = Credits(
          id: 550,
          cast: [],
          crew: [],
        );

        // Act
        final json = credits.toJson();

        // Assert
        expect(json['id'], 550);
        expect(json['cast'], []);
        expect(json['crew'], []);
      });

      test('should correctly serialize to JSON with only cast', () {
        // Arrange
        const credits = Credits(
          id: 550,
          cast: [castMember1],
          crew: [],
        );

        // Act
        final json = credits.toJson();

        // Assert
        expect(json['id'], 550);
        expect(json['cast'].length, 1);
        expect(json['crew'], []);

        // Verify cast object
        expect(json['cast'][0], isA<Cast>());
        expect(json['cast'][0].id, 819);
        expect(json['cast'][0].name, 'Edward Norton');
        expect(json['cast'][0].character, 'The Narrator');
      });

      test('should correctly serialize to JSON with only crew', () {
        // Arrange
        const credits = Credits(
          id: 550,
          cast: [],
          crew: [crewMember1],
        );

        // Act
        final json = credits.toJson();

        // Assert
        expect(json['id'], 550);
        expect(json['cast'], []);
        expect(json['crew'].length, 1);

        // Verify crew object
        expect(json['crew'][0], isA<Crew>());
        expect(json['crew'][0].id, 7467);
        expect(json['crew'][0].name, 'David Fincher');
        expect(json['crew'][0].department, 'Directing');
        expect(json['crew'][0].job, 'Director');
      });
    });

    group('round-trip', () {
      test(
          'should maintain data integrity through serialization cycle with all fields',
          () {
        // Arrange
        const originalCredits = Credits(
          id: 550,
          cast: [castMember1, castMember2],
          crew: [crewMember1, crewMember2],
        );

        // Act
        final json = originalCredits.toJson();

        // Convert Cast and Crew objects to maps for deserialization
        final jsonForDeserialization = {
          'id': json['id'],
          'cast': (json['cast'] as List<Cast>)
              .map((cast) => cast.toJson())
              .toList(),
          'crew': (json['crew'] as List<Crew>)
              .map((crew) => crew.toJson())
              .toList(),
        };

        final deserializedCredits = Credits.fromJson(jsonForDeserialization);

        // Assert
        expect(deserializedCredits.id, originalCredits.id);
        expect(deserializedCredits.cast.length, originalCredits.cast.length);
        expect(deserializedCredits.crew.length, originalCredits.crew.length);

        // Verify cast members
        for (int i = 0; i < originalCredits.cast.length; i++) {
          expect(deserializedCredits.cast[i].id, originalCredits.cast[i].id);
          expect(
              deserializedCredits.cast[i].name, originalCredits.cast[i].name);
          expect(deserializedCredits.cast[i].character,
              originalCredits.cast[i].character);
          expect(
              deserializedCredits.cast[i].order, originalCredits.cast[i].order);
        }

        // Verify crew members
        for (int i = 0; i < originalCredits.crew.length; i++) {
          expect(deserializedCredits.crew[i].id, originalCredits.crew[i].id);
          expect(
              deserializedCredits.crew[i].name, originalCredits.crew[i].name);
          expect(deserializedCredits.crew[i].department,
              originalCredits.crew[i].department);
          expect(deserializedCredits.crew[i].job, originalCredits.crew[i].job);
        }
      });

      test(
          'should maintain data integrity through serialization cycle with empty arrays',
          () {
        // Arrange
        const originalCredits = Credits(
          id: 550,
          cast: [],
          crew: [],
        );

        // Act
        final json = originalCredits.toJson();

        // Convert empty lists to maps for deserialization
        final jsonForDeserialization = {
          'id': json['id'],
          'cast': (json['cast'] as List<Cast>)
              .map((cast) => cast.toJson())
              .toList(),
          'crew': (json['crew'] as List<Crew>)
              .map((crew) => crew.toJson())
              .toList(),
        };

        final deserializedCredits = Credits.fromJson(jsonForDeserialization);

        // Assert
        expect(deserializedCredits.id, originalCredits.id);
        expect(deserializedCredits.cast.length, originalCredits.cast.length);
        expect(deserializedCredits.crew.length, originalCredits.crew.length);
        expect(deserializedCredits.cast.isEmpty, true);
        expect(deserializedCredits.crew.isEmpty, true);
      });

      test(
          'should maintain data integrity through serialization cycle with only cast',
          () {
        // Arrange
        const originalCredits = Credits(
          id: 550,
          cast: [castMember1],
          crew: [],
        );

        // Act
        final json = originalCredits.toJson();

        // Convert Cast objects to maps for deserialization
        final jsonForDeserialization = {
          'id': json['id'],
          'cast': (json['cast'] as List<Cast>)
              .map((cast) => cast.toJson())
              .toList(),
          'crew': (json['crew'] as List<Crew>)
              .map((crew) => crew.toJson())
              .toList(),
        };

        final deserializedCredits = Credits.fromJson(jsonForDeserialization);

        // Assert
        expect(deserializedCredits.id, originalCredits.id);
        expect(deserializedCredits.cast.length, originalCredits.cast.length);
        expect(deserializedCredits.crew.length, originalCredits.crew.length);
        expect(deserializedCredits.cast[0].id, originalCredits.cast[0].id);
        expect(deserializedCredits.cast[0].name, originalCredits.cast[0].name);
        expect(deserializedCredits.cast[0].character,
            originalCredits.cast[0].character);
        expect(deserializedCredits.crew.isEmpty, true);
      });

      test(
          'should maintain data integrity through serialization cycle with only crew',
          () {
        // Arrange
        const originalCredits = Credits(
          id: 550,
          cast: [],
          crew: [crewMember1],
        );

        // Act
        final json = originalCredits.toJson();

        // Convert Crew objects to maps for deserialization
        final jsonForDeserialization = {
          'id': json['id'],
          'cast': (json['cast'] as List<Cast>)
              .map((cast) => cast.toJson())
              .toList(),
          'crew': (json['crew'] as List<Crew>)
              .map((crew) => crew.toJson())
              .toList(),
        };

        final deserializedCredits = Credits.fromJson(jsonForDeserialization);

        // Assert
        expect(deserializedCredits.id, originalCredits.id);
        expect(deserializedCredits.cast.length, originalCredits.cast.length);
        expect(deserializedCredits.crew.length, originalCredits.crew.length);
        expect(deserializedCredits.cast.isEmpty, true);
        expect(deserializedCredits.crew[0].id, originalCredits.crew[0].id);
        expect(deserializedCredits.crew[0].name, originalCredits.crew[0].name);
        expect(deserializedCredits.crew[0].department,
            originalCredits.crew[0].department);
        expect(deserializedCredits.crew[0].job, originalCredits.crew[0].job);
      });
    });

    group('edge cases', () {
      test('should handle zero ID', () {
        // Arrange
        final jsonWithZeroId = Map<String, dynamic>.from(completeCreditsJson);
        jsonWithZeroId['id'] = 0;

        // Act
        final credits = Credits.fromJson(jsonWithZeroId);

        // Assert
        expect(credits.id, 0);
        expect(credits.cast.length, 2);
        expect(credits.crew.length, 2);
      });

      test('should handle negative ID', () {
        // Arrange
        final jsonWithNegativeId =
            Map<String, dynamic>.from(completeCreditsJson);
        jsonWithNegativeId['id'] = -1;

        // Act
        final credits = Credits.fromJson(jsonWithNegativeId);

        // Assert
        expect(credits.id, -1);
        expect(credits.cast.length, 2);
        expect(credits.crew.length, 2);
      });

      test('should handle very large ID', () {
        // Arrange
        final jsonWithLargeId = Map<String, dynamic>.from(completeCreditsJson);
        jsonWithLargeId['id'] = 999999999;

        // Act
        final credits = Credits.fromJson(jsonWithLargeId);

        // Assert
        expect(credits.id, 999999999);
        expect(credits.cast.length, 2);
        expect(credits.crew.length, 2);
      });

      test('should handle cast members with different order values', () {
        // Arrange
        final jsonWithDifferentOrders = {
          'id': 550,
          'cast': [
            {
              'id': 819,
              'adult': false,
              'name': 'Actor 1',
              'original_name': 'Actor 1',
              'popularity': 7.842,
              'cast_id': 3,
              'character': 'Character 1',
              'credit_id': '52fe4250c3a36847f8014983',
              'order': 10,
            },
            {
              'id': 820,
              'adult': false,
              'name': 'Actor 2',
              'original_name': 'Actor 2',
              'popularity': 6.842,
              'cast_id': 4,
              'character': 'Character 2',
              'credit_id': '52fe4250c3a36847f8014987',
              'order': 5,
            },
            {
              'id': 821,
              'adult': false,
              'name': 'Actor 3',
              'original_name': 'Actor 3',
              'popularity': 5.842,
              'cast_id': 5,
              'character': 'Character 3',
              'credit_id': '52fe4250c3a36847f8014987',
              'order': 0,
            },
          ],
          'crew': [],
        };

        // Act
        final credits = Credits.fromJson(jsonWithDifferentOrders);

        // Assert
        expect(credits.cast.length, 3);
        expect(credits.cast[0].order, 10);
        expect(credits.cast[1].order, 5);
        expect(credits.cast[2].order, 0);
      });

      test('should handle crew members with various departments and jobs', () {
        // Arrange
        final jsonWithVariousCrew = {
          'id': 550,
          'cast': [],
          'crew': [
            {
              'id': 7467,
              'adult': false,
              'name': 'Director',
              'original_name': 'Director',
              'popularity': 8.421,
              'credit_id': '52fe4250c3a36847f8014937',
              'department': 'Directing',
              'job': 'Director',
            },
            {
              'id': 7468,
              'adult': false,
              'name': 'Writer',
              'original_name': 'Writer',
              'popularity': 7.421,
              'credit_id': '52fe4250c3a36847f8014938',
              'department': 'Writing',
              'job': 'Screenplay',
            },
            {
              'id': 7469,
              'adult': false,
              'name': 'Producer',
              'original_name': 'Producer',
              'popularity': 6.421,
              'credit_id': '52fe4250c3a36847f8014939',
              'department': 'Production',
              'job': 'Producer',
            },
            {
              'id': 7470,
              'adult': false,
              'name': 'Editor',
              'original_name': 'Editor',
              'popularity': 5.421,
              'credit_id': '52fe4250c3a36847f8014940',
              'department': 'Editing',
              'job': 'Editor',
            },
          ],
        };

        // Act
        final credits = Credits.fromJson(jsonWithVariousCrew);

        // Assert
        expect(credits.crew.length, 4);
        expect(credits.crew[0].department, 'Directing');
        expect(credits.crew[0].job, 'Director');
        expect(credits.crew[1].department, 'Writing');
        expect(credits.crew[1].job, 'Screenplay');
        expect(credits.crew[2].department, 'Production');
        expect(credits.crew[2].job, 'Producer');
        expect(credits.crew[3].department, 'Editing');
        expect(credits.crew[3].job, 'Editor');
      });
    });
  });
}
