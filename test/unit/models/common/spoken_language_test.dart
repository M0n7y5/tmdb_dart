import 'package:test/test.dart';
import 'package:tmdb_dart/src/models/common/spoken_language.dart';

void main() {
  group('SpokenLanguage', () {
    group('fromJson', () {
      test('should correctly deserialize from JSON', () {
        // Arrange
        final json = {
          'iso_639_1': 'en',
          'name': 'English',
          'english_name': 'English',
        };

        // Act
        final language = SpokenLanguage.fromJson(json);

        // Assert
        expect(language.iso6391, 'en');
        expect(language.name, 'English');
        expect(language.englishName, 'English');
      });

      test('should handle null values for required fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act & Assert
        expect(() => SpokenLanguage.fromJson(json), throwsA(isA<TypeError>()));
      });

      test('should handle empty strings', () {
        // Arrange
        final json = {
          'iso_639_1': '',
          'name': '',
          'english_name': '',
        };

        // Act
        final language = SpokenLanguage.fromJson(json);

        // Assert
        expect(language.iso6391, '');
        expect(language.name, '');
        expect(language.englishName, '');
      });

      test('should handle different language codes', () {
        // Arrange
        final json = {
          'iso_639_1': 'fr',
          'name': 'Français',
          'english_name': 'French',
        };

        // Act
        final language = SpokenLanguage.fromJson(json);

        // Assert
        expect(language.iso6391, 'fr');
        expect(language.name, 'Français');
        expect(language.englishName, 'French');
      });

      test('should handle non-ASCII characters in name', () {
        // Arrange
        final json = {
          'iso_639_1': 'ja',
          'name': '日本語',
          'english_name': 'Japanese',
        };

        // Act
        final language = SpokenLanguage.fromJson(json);

        // Assert
        expect(language.iso6391, 'ja');
        expect(language.name, '日本語');
        expect(language.englishName, 'Japanese');
      });

      test('should handle different names for same language', () {
        // Arrange
        final json = {
          'iso_639_1': 'zh',
          'name': '中文',
          'english_name': 'Chinese',
        };

        // Act
        final language = SpokenLanguage.fromJson(json);

        // Assert
        expect(language.iso6391, 'zh');
        expect(language.name, '中文');
        expect(language.englishName, 'Chinese');
      });
    });

    group('toJson', () {
      test('should correctly serialize to JSON', () {
        // Arrange
        const language = SpokenLanguage(
          iso6391: 'en',
          name: 'English',
          englishName: 'English',
        );

        // Act
        final json = language.toJson();

        // Assert
        expect(json['iso_639_1'], 'en');
        expect(json['name'], 'English');
        expect(json['english_name'], 'English');
      });

      test('should correctly serialize empty strings', () {
        // Arrange
        const language = SpokenLanguage(
          iso6391: '',
          name: '',
          englishName: '',
        );

        // Act
        final json = language.toJson();

        // Assert
        expect(json['iso_639_1'], '');
        expect(json['name'], '');
        expect(json['english_name'], '');
      });
    });

    group('round-trip', () {
      test('should maintain data integrity through serialization cycle', () {
        // Arrange
        const originalLanguage = SpokenLanguage(
          iso6391: 'en',
          name: 'English',
          englishName: 'English',
        );

        // Act
        final json = originalLanguage.toJson();
        final deserializedLanguage = SpokenLanguage.fromJson(json);

        // Assert
        expect(deserializedLanguage.iso6391, originalLanguage.iso6391);
        expect(deserializedLanguage.name, originalLanguage.name);
        expect(deserializedLanguage.englishName, originalLanguage.englishName);
      });

      test('should maintain data integrity with empty strings', () {
        // Arrange
        const originalLanguage = SpokenLanguage(
          iso6391: '',
          name: '',
          englishName: '',
        );

        // Act
        final json = originalLanguage.toJson();
        final deserializedLanguage = SpokenLanguage.fromJson(json);

        // Assert
        expect(deserializedLanguage.iso6391, originalLanguage.iso6391);
        expect(deserializedLanguage.name, originalLanguage.name);
        expect(deserializedLanguage.englishName, originalLanguage.englishName);
      });

      test('should maintain data integrity with non-ASCII characters', () {
        // Arrange
        const originalLanguage = SpokenLanguage(
          iso6391: 'ja',
          name: '日本語',
          englishName: 'Japanese',
        );

        // Act
        final json = originalLanguage.toJson();
        final deserializedLanguage = SpokenLanguage.fromJson(json);

        // Assert
        expect(deserializedLanguage.iso6391, originalLanguage.iso6391);
        expect(deserializedLanguage.name, originalLanguage.name);
        expect(deserializedLanguage.englishName, originalLanguage.englishName);
      });
    });

    group('equality', () {
      test('should consider equal languages with same values', () {
        // Arrange
        const language1 = SpokenLanguage(
          iso6391: 'en',
          name: 'English',
          englishName: 'English',
        );
        const language2 = SpokenLanguage(
          iso6391: 'en',
          name: 'English',
          englishName: 'English',
        );

        // Assert
        expect(language1, equals(language2));
      });

      test('should consider different languages with different iso codes', () {
        // Arrange
        const language1 = SpokenLanguage(
          iso6391: 'en',
          name: 'English',
          englishName: 'English',
        );
        const language2 = SpokenLanguage(
          iso6391: 'fr',
          name: 'Français',
          englishName: 'French',
        );

        // Assert
        expect(language1, isNot(equals(language2)));
      });

      test('should consider different languages with different names', () {
        // Arrange
        const language1 = SpokenLanguage(
          iso6391: 'en',
          name: 'English',
          englishName: 'English',
        );
        const language2 = SpokenLanguage(
          iso6391: 'en',
          name: 'American English',
          englishName: 'English',
        );

        // Assert
        expect(language1, isNot(equals(language2)));
      });

      test('should consider different languages with different english names',
          () {
        // Arrange
        const language1 = SpokenLanguage(
          iso6391: 'zh',
          name: '中文',
          englishName: 'Chinese',
        );
        const language2 = SpokenLanguage(
          iso6391: 'zh',
          name: '中文',
          englishName: 'Mandarin',
        );

        // Assert
        expect(language1, isNot(equals(language2)));
      });
    });
  });
}
