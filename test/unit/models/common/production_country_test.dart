import 'package:test/test.dart';
import 'package:tmdb_dart/src/models/common/production_country.dart';

void main() {
  group('ProductionCountry', () {
    group('fromJson', () {
      test('should correctly deserialize from JSON', () {
        // Arrange
        final json = {
          'iso_3166_1': 'US',
          'name': 'United States of America',
        };

        // Act
        final country = ProductionCountry.fromJson(json);

        // Assert
        expect(country.iso31661, 'US');
        expect(country.name, 'United States of America');
      });

      test('should handle null values for required fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act & Assert
        expect(
            () => ProductionCountry.fromJson(json), throwsA(isA<TypeError>()));
      });

      test('should handle empty strings', () {
        // Arrange
        final json = {
          'iso_3166_1': '',
          'name': '',
        };

        // Act
        final country = ProductionCountry.fromJson(json);

        // Assert
        expect(country.iso31661, '');
        expect(country.name, '');
      });

      test('should handle special characters in name', () {
        // Arrange
        final json = {
          'iso_3166_1': 'GB',
          'name': 'United Kingdom',
        };

        // Act
        final country = ProductionCountry.fromJson(json);

        // Assert
        expect(country.iso31661, 'GB');
        expect(country.name, 'United Kingdom');
      });

      test('should handle non-ASCII characters in name', () {
        // Arrange
        final json = {
          'iso_3166_1': 'JP',
          'name': '日本',
        };

        // Act
        final country = ProductionCountry.fromJson(json);

        // Assert
        expect(country.iso31661, 'JP');
        expect(country.name, '日本');
      });
    });

    group('toJson', () {
      test('should correctly serialize to JSON', () {
        // Arrange
        const country = ProductionCountry(
          iso31661: 'US',
          name: 'United States of America',
        );

        // Act
        final json = country.toJson();

        // Assert
        expect(json['iso_3166_1'], 'US');
        expect(json['name'], 'United States of America');
      });

      test('should correctly serialize empty strings', () {
        // Arrange
        const country = ProductionCountry(
          iso31661: '',
          name: '',
        );

        // Act
        final json = country.toJson();

        // Assert
        expect(json['iso_3166_1'], '');
        expect(json['name'], '');
      });
    });

    group('round-trip', () {
      test('should maintain data integrity through serialization cycle', () {
        // Arrange
        const originalCountry = ProductionCountry(
          iso31661: 'US',
          name: 'United States of America',
        );

        // Act
        final json = originalCountry.toJson();
        final deserializedCountry = ProductionCountry.fromJson(json);

        // Assert
        expect(deserializedCountry.iso31661, originalCountry.iso31661);
        expect(deserializedCountry.name, originalCountry.name);
      });

      test('should maintain data integrity with empty strings', () {
        // Arrange
        const originalCountry = ProductionCountry(
          iso31661: '',
          name: '',
        );

        // Act
        final json = originalCountry.toJson();
        final deserializedCountry = ProductionCountry.fromJson(json);

        // Assert
        expect(deserializedCountry.iso31661, originalCountry.iso31661);
        expect(deserializedCountry.name, originalCountry.name);
      });

      test('should maintain data integrity with special characters', () {
        // Arrange
        const originalCountry = ProductionCountry(
          iso31661: 'GB',
          name: 'United Kingdom',
        );

        // Act
        final json = originalCountry.toJson();
        final deserializedCountry = ProductionCountry.fromJson(json);

        // Assert
        expect(deserializedCountry.iso31661, originalCountry.iso31661);
        expect(deserializedCountry.name, originalCountry.name);
      });
    });

    group('equality', () {
      test('should consider equal countries with same values', () {
        // Arrange
        const country1 = ProductionCountry(
          iso31661: 'US',
          name: 'United States of America',
        );
        const country2 = ProductionCountry(
          iso31661: 'US',
          name: 'United States of America',
        );

        // Assert
        expect(country1, equals(country2));
      });

      test('should consider different countries with different iso codes', () {
        // Arrange
        const country1 = ProductionCountry(
          iso31661: 'US',
          name: 'United States of America',
        );
        const country2 = ProductionCountry(
          iso31661: 'GB',
          name: 'United Kingdom',
        );

        // Assert
        expect(country1, isNot(equals(country2)));
      });

      test('should consider different countries with different names', () {
        // Arrange
        const country1 = ProductionCountry(
          iso31661: 'US',
          name: 'United States of America',
        );
        const country2 = ProductionCountry(
          iso31661: 'US',
          name: 'USA',
        );

        // Assert
        expect(country1, isNot(equals(country2)));
      });
    });
  });
}
