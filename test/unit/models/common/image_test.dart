import 'package:test/test.dart';
import 'package:tmdb_dart/src/models/common/image.dart';

void main() {
  group('TmdbImage', () {
    group('fromJson', () {
      test('should correctly deserialize from JSON with all fields', () {
        // Arrange
        final json = {
          'aspect_ratio': 1.78,
          'file_path': '/path/to/image.jpg',
          'height': 1080,
          'width': 1920,
          'vote_average': 7.5,
          'vote_count': 100,
          'iso_639_1': 'en',
        };

        // Act
        final image = TmdbImage.fromJson(json);

        // Assert
        expect(image.aspectRatio, 1.78);
        expect(image.filePath, '/path/to/image.jpg');
        expect(image.height, 1080);
        expect(image.width, 1920);
        expect(image.voteAverage, 7.5);
        expect(image.voteCount, 100);
        expect(image.iso6391, 'en');
      });

      test('should handle null/optional fields', () {
        // Arrange
        final json = {
          'aspect_ratio': null,
          'file_path': null,
          'height': null,
          'width': null,
          'vote_average': null,
          'vote_count': null,
          'iso_639_1': null,
        };

        // Act
        final image = TmdbImage.fromJson(json);

        // Assert
        expect(image.aspectRatio, isNull);
        expect(image.filePath, isNull);
        expect(image.height, isNull);
        expect(image.width, isNull);
        expect(image.voteAverage, isNull);
        expect(image.voteCount, isNull);
        expect(image.iso6391, isNull);
      });

      test('should handle missing fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final image = TmdbImage.fromJson(json);

        // Assert
        expect(image.aspectRatio, isNull);
        expect(image.filePath, isNull);
        expect(image.height, isNull);
        expect(image.width, isNull);
        expect(image.voteAverage, isNull);
        expect(image.voteCount, isNull);
        expect(image.iso6391, isNull);
      });

      test('should handle empty strings', () {
        // Arrange
        final json = {
          'file_path': '',
          'iso_639_1': '',
        };

        // Act
        final image = TmdbImage.fromJson(json);

        // Assert
        expect(image.filePath, '');
        expect(image.iso6391, '');
      });

      test('should handle decimal values for aspect_ratio and vote_average',
          () {
        // Arrange
        final json = {
          'aspect_ratio': 1.7777777777777777,
          'vote_average': 8.333333333333334,
        };

        // Act
        final image = TmdbImage.fromJson(json);

        // Assert
        expect(image.aspectRatio, 1.7777777777777777);
        expect(image.voteAverage, 8.333333333333334);
      });
    });

    group('toJson', () {
      test('should correctly serialize to JSON with all fields', () {
        // Arrange
        const image = TmdbImage(
          aspectRatio: 1.78,
          filePath: '/path/to/image.jpg',
          height: 1080,
          width: 1920,
          voteAverage: 7.5,
          voteCount: 100,
          iso6391: 'en',
        );

        // Act
        final json = image.toJson();

        // Assert
        expect(json['aspect_ratio'], 1.78);
        expect(json['file_path'], '/path/to/image.jpg');
        expect(json['height'], 1080);
        expect(json['width'], 1920);
        expect(json['vote_average'], 7.5);
        expect(json['vote_count'], 100);
        expect(json['iso_639_1'], 'en');
      });

      test('should correctly serialize to JSON with null fields', () {
        // Arrange
        const image = TmdbImage(
          filePath: '/path/to/image.jpg',
        );

        // Act
        final json = image.toJson();

        // Assert
        expect(json['aspect_ratio'], isNull);
        expect(json['file_path'], '/path/to/image.jpg');
        expect(json['height'], isNull);
        expect(json['width'], isNull);
        expect(json['vote_average'], isNull);
        expect(json['vote_count'], isNull);
        expect(json['iso_639_1'], isNull);
      });
    });

    group('round-trip', () {
      test(
          'should maintain data integrity through serialization cycle with all fields',
          () {
        // Arrange
        const originalImage = TmdbImage(
          aspectRatio: 1.78,
          filePath: '/path/to/image.jpg',
          height: 1080,
          width: 1920,
          voteAverage: 7.5,
          voteCount: 100,
          iso6391: 'en',
        );

        // Act
        final json = originalImage.toJson();
        final deserializedImage = TmdbImage.fromJson(json);

        // Assert
        expect(deserializedImage.aspectRatio, originalImage.aspectRatio);
        expect(deserializedImage.filePath, originalImage.filePath);
        expect(deserializedImage.height, originalImage.height);
        expect(deserializedImage.width, originalImage.width);
        expect(deserializedImage.voteAverage, originalImage.voteAverage);
        expect(deserializedImage.voteCount, originalImage.voteCount);
        expect(deserializedImage.iso6391, originalImage.iso6391);
      });

      test(
          'should maintain data integrity through serialization cycle with null fields',
          () {
        // Arrange
        const originalImage = TmdbImage(
          filePath: '/path/to/image.jpg',
        );

        // Act
        final json = originalImage.toJson();
        final deserializedImage = TmdbImage.fromJson(json);

        // Assert
        expect(deserializedImage.aspectRatio, originalImage.aspectRatio);
        expect(deserializedImage.filePath, originalImage.filePath);
        expect(deserializedImage.height, originalImage.height);
        expect(deserializedImage.width, originalImage.width);
        expect(deserializedImage.voteAverage, originalImage.voteAverage);
        expect(deserializedImage.voteCount, originalImage.voteCount);
        expect(deserializedImage.iso6391, originalImage.iso6391);
      });
    });

    group('equality', () {
      test('should consider equal images with same values', () {
        // Arrange
        const image1 = TmdbImage(
          aspectRatio: 1.78,
          filePath: '/path/to/image.jpg',
          height: 1080,
          width: 1920,
          voteAverage: 7.5,
          voteCount: 100,
          iso6391: 'en',
        );
        const image2 = TmdbImage(
          aspectRatio: 1.78,
          filePath: '/path/to/image.jpg',
          height: 1080,
          width: 1920,
          voteAverage: 7.5,
          voteCount: 100,
          iso6391: 'en',
        );

        // Assert
        expect(image1, equals(image2));
      });

      test('should consider different images with different file paths', () {
        // Arrange
        const image1 = TmdbImage(filePath: '/path/to/image1.jpg');
        const image2 = TmdbImage(filePath: '/path/to/image2.jpg');

        // Assert
        expect(image1, isNot(equals(image2)));
      });
    });
  });
}
