import 'package:test/test.dart';
import 'package:tmdb_dart/src/models/common/genre.dart';

void main() {
  group('Genre', () {
    group('fromJson', () {
      test('should correctly deserialize from JSON', () {
        // Arrange
        final json = {
          'id': 28,
          'name': 'Action',
        };

        // Act
        final genre = Genre.fromJson(json);

        // Assert
        expect(genre.id, 28);
        expect(genre.name, 'Action');
      });

      test('should handle null values for required fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act & Assert
        expect(() => Genre.fromJson(json), throwsA(isA<TypeError>()));
      });
    });

    group('toJson', () {
      test('should correctly serialize to JSON', () {
        // Arrange
        const genre = Genre(
          id: 28,
          name: 'Action',
        );

        // Act
        final json = genre.toJson();

        // Assert
        expect(json['id'], 28);
        expect(json['name'], 'Action');
      });
    });

    group('round-trip', () {
      test('should maintain data integrity through serialization cycle', () {
        // Arrange
        const originalGenre = Genre(
          id: 28,
          name: 'Action',
        );

        // Act
        final json = originalGenre.toJson();
        final deserializedGenre = Genre.fromJson(json);

        // Assert
        expect(deserializedGenre.id, originalGenre.id);
        expect(deserializedGenre.name, originalGenre.name);
      });
    });

    group('equality', () {
      test('should consider equal genres with same values', () {
        // Arrange
        const genre1 = Genre(id: 28, name: 'Action');
        const genre2 = Genre(id: 28, name: 'Action');

        // Assert
        expect(genre1, equals(genre2));
      });

      test('should consider different genres with different ids', () {
        // Arrange
        const genre1 = Genre(id: 28, name: 'Action');
        const genre2 = Genre(id: 12, name: 'Action');

        // Assert
        expect(genre1, isNot(equals(genre2)));
      });

      test('should consider different genres with different names', () {
        // Arrange
        const genre1 = Genre(id: 28, name: 'Action');
        const genre2 = Genre(id: 28, name: 'Adventure');

        // Assert
        expect(genre1, isNot(equals(genre2)));
      });
    });
  });
}
