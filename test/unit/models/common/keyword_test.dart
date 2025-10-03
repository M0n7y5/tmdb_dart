import 'package:test/test.dart';
import 'package:tmdb_dart/src/models/common/keyword.dart';

void main() {
  group('Keyword', () {
    group('fromJson', () {
      test('should correctly deserialize from JSON', () {
        // Arrange
        final json = {
          'id': 12345,
          'name': 'superhero',
        };

        // Act
        final keyword = Keyword.fromJson(json);

        // Assert
        expect(keyword.id, 12345);
        expect(keyword.name, 'superhero');
      });

      test('should handle null values for required fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act & Assert
        expect(() => Keyword.fromJson(json), throwsA(isA<TypeError>()));
      });

      test('should handle empty string for name', () {
        // Arrange
        final json = {
          'id': 12345,
          'name': '',
        };

        // Act
        final keyword = Keyword.fromJson(json);

        // Assert
        expect(keyword.id, 12345);
        expect(keyword.name, '');
      });

      test('should handle special characters in name', () {
        // Arrange
        final json = {
          'id': 12345,
          'name': 'sci-fi & fantasy',
        };

        // Act
        final keyword = Keyword.fromJson(json);

        // Assert
        expect(keyword.id, 12345);
        expect(keyword.name, 'sci-fi & fantasy');
      });
    });

    group('toJson', () {
      test('should correctly serialize to JSON', () {
        // Arrange
        const keyword = Keyword(
          id: 12345,
          name: 'superhero',
        );

        // Act
        final json = keyword.toJson();

        // Assert
        expect(json['id'], 12345);
        expect(json['name'], 'superhero');
      });

      test('should correctly serialize empty string name', () {
        // Arrange
        const keyword = Keyword(
          id: 12345,
          name: '',
        );

        // Act
        final json = keyword.toJson();

        // Assert
        expect(json['id'], 12345);
        expect(json['name'], '');
      });
    });

    group('round-trip', () {
      test('should maintain data integrity through serialization cycle', () {
        // Arrange
        const originalKeyword = Keyword(
          id: 12345,
          name: 'superhero',
        );

        // Act
        final json = originalKeyword.toJson();
        final deserializedKeyword = Keyword.fromJson(json);

        // Assert
        expect(deserializedKeyword.id, originalKeyword.id);
        expect(deserializedKeyword.name, originalKeyword.name);
      });

      test('should maintain data integrity with empty string name', () {
        // Arrange
        const originalKeyword = Keyword(
          id: 12345,
          name: '',
        );

        // Act
        final json = originalKeyword.toJson();
        final deserializedKeyword = Keyword.fromJson(json);

        // Assert
        expect(deserializedKeyword.id, originalKeyword.id);
        expect(deserializedKeyword.name, originalKeyword.name);
      });

      test('should maintain data integrity with special characters', () {
        // Arrange
        const originalKeyword = Keyword(
          id: 12345,
          name: 'sci-fi & fantasy',
        );

        // Act
        final json = originalKeyword.toJson();
        final deserializedKeyword = Keyword.fromJson(json);

        // Assert
        expect(deserializedKeyword.id, originalKeyword.id);
        expect(deserializedKeyword.name, originalKeyword.name);
      });
    });

    group('equality', () {
      test('should consider equal keywords with same values', () {
        // Arrange
        const keyword1 = Keyword(id: 12345, name: 'superhero');
        const keyword2 = Keyword(id: 12345, name: 'superhero');

        // Assert
        expect(keyword1, equals(keyword2));
      });

      test('should consider different keywords with different ids', () {
        // Arrange
        const keyword1 = Keyword(id: 12345, name: 'superhero');
        const keyword2 = Keyword(id: 54321, name: 'superhero');

        // Assert
        expect(keyword1, isNot(equals(keyword2)));
      });

      test('should consider different keywords with different names', () {
        // Arrange
        const keyword1 = Keyword(id: 12345, name: 'superhero');
        const keyword2 = Keyword(id: 12345, name: 'action');

        // Assert
        expect(keyword1, isNot(equals(keyword2)));
      });
    });
  });
}
