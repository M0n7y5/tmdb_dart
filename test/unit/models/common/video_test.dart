import 'package:test/test.dart';
import 'package:tmdb_dart/src/models/common/video.dart';

void main() {
  group('Video', () {
    group('fromJson', () {
      test('should correctly deserialize from JSON with all fields', () {
        // Arrange
        final json = {
          'id': 'abc123',
          'name': 'Official Trailer',
          'key': 'dQw4w9WgXcQ',
          'site': 'YouTube',
          'size': 1080,
          'type': 'Trailer',
          'official': true,
          'published_at': '2023-01-15T10:30:00.000Z',
          'iso_639_1': 'en',
          'iso_3166_1': 'US',
        };

        // Act
        final video = Video.fromJson(json);

        // Assert
        expect(video.id, 'abc123');
        expect(video.name, 'Official Trailer');
        expect(video.key, 'dQw4w9WgXcQ');
        expect(video.site, 'YouTube');
        expect(video.size, 1080);
        expect(video.type, 'Trailer');
        expect(video.official, true);
        expect(video.publishedAt, DateTime.parse('2023-01-15T10:30:00.000Z'));
        expect(video.iso6391, 'en');
        expect(video.iso31661, 'US');
      });

      test('should handle null/optional fields', () {
        // Arrange
        final json = {
          'id': 'abc123',
          'name': 'Official Trailer',
          'key': 'dQw4w9WgXcQ',
          'site': 'YouTube',
          'size': null,
          'type': 'Trailer',
          'official': null,
          'published_at': null,
          'iso_639_1': null,
          'iso_3166_1': null,
        };

        // Act
        final video = Video.fromJson(json);

        // Assert
        expect(video.id, 'abc123');
        expect(video.name, 'Official Trailer');
        expect(video.key, 'dQw4w9WgXcQ');
        expect(video.site, 'YouTube');
        expect(video.size, isNull);
        expect(video.type, 'Trailer');
        expect(video.official, isNull);
        expect(video.publishedAt, isNull);
        expect(video.iso6391, isNull);
        expect(video.iso31661, isNull);
      });

      test('should handle missing optional fields', () {
        // Arrange
        final json = {
          'id': 'abc123',
          'name': 'Official Trailer',
          'key': 'dQw4w9WgXcQ',
          'site': 'YouTube',
          'type': 'Trailer',
        };

        // Act
        final video = Video.fromJson(json);

        // Assert
        expect(video.id, 'abc123');
        expect(video.name, 'Official Trailer');
        expect(video.key, 'dQw4w9WgXcQ');
        expect(video.site, 'YouTube');
        expect(video.size, isNull);
        expect(video.type, 'Trailer');
        expect(video.official, isNull);
        expect(video.publishedAt, isNull);
        expect(video.iso6391, isNull);
        expect(video.iso31661, isNull);
      });

      test('should handle different video types', () {
        // Arrange
        final json = {
          'id': 'def456',
          'name': 'Behind the Scenes',
          'key': 'xyz789',
          'site': 'YouTube',
          'type': 'Featurette',
        };

        // Act
        final video = Video.fromJson(json);

        // Assert
        expect(video.type, 'Featurette');
      });

      test('should handle different date formats for published_at', () {
        // Arrange
        final json = {
          'id': 'ghi789',
          'name': 'Teaser',
          'key': 'mno321',
          'site': 'YouTube',
          'type': 'Teaser',
          'published_at': '2023-01-15',
        };

        // Act
        final video = Video.fromJson(json);

        // Assert
        expect(video.publishedAt, DateTime.parse('2023-01-15'));
      });

      test('should throw error when required fields are missing', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act & Assert
        expect(() => Video.fromJson(json), throwsA(isA<TypeError>()));
      });
    });

    group('toJson', () {
      test('should correctly serialize to JSON with all fields', () {
        // Arrange
        final video = Video(
          id: 'abc123',
          name: 'Official Trailer',
          key: 'dQw4w9WgXcQ',
          site: 'YouTube',
          size: 1080,
          type: 'Trailer',
          official: true,
          publishedAt: DateTime.parse('2023-01-15T10:30:00.000Z'),
          iso6391: 'en',
          iso31661: 'US',
        );

        // Act
        final json = video.toJson();

        // Assert
        expect(json['id'], 'abc123');
        expect(json['name'], 'Official Trailer');
        expect(json['key'], 'dQw4w9WgXcQ');
        expect(json['site'], 'YouTube');
        expect(json['size'], 1080);
        expect(json['type'], 'Trailer');
        expect(json['official'], true);
        expect(json['published_at'], '2023-01-15T10:30:00.000Z');
        expect(json['iso_639_1'], 'en');
        expect(json['iso_3166_1'], 'US');
      });

      test('should correctly serialize to JSON with null fields', () {
        // Arrange
        final video = Video(
          id: 'abc123',
          name: 'Official Trailer',
          key: 'dQw4w9WgXcQ',
          site: 'YouTube',
          type: 'Trailer',
        );

        // Act
        final json = video.toJson();

        // Assert
        expect(json['id'], 'abc123');
        expect(json['name'], 'Official Trailer');
        expect(json['key'], 'dQw4w9WgXcQ');
        expect(json['site'], 'YouTube');
        expect(json['size'], isNull);
        expect(json['type'], 'Trailer');
        expect(json['official'], isNull);
        expect(json['published_at'], isNull);
        expect(json['iso_639_1'], isNull);
        expect(json['iso_3166_1'], isNull);
      });
    });

    group('round-trip', () {
      test(
          'should maintain data integrity through serialization cycle with all fields',
          () {
        // Arrange
        final originalVideo = Video(
          id: 'abc123',
          name: 'Official Trailer',
          key: 'dQw4w9WgXcQ',
          site: 'YouTube',
          size: 1080,
          type: 'Trailer',
          official: true,
          publishedAt: DateTime.parse('2023-01-15T10:30:00.000Z'),
          iso6391: 'en',
          iso31661: 'US',
        );

        // Act
        final json = originalVideo.toJson();
        final deserializedVideo = Video.fromJson(json);

        // Assert
        expect(deserializedVideo.id, originalVideo.id);
        expect(deserializedVideo.name, originalVideo.name);
        expect(deserializedVideo.key, originalVideo.key);
        expect(deserializedVideo.site, originalVideo.site);
        expect(deserializedVideo.size, originalVideo.size);
        expect(deserializedVideo.type, originalVideo.type);
        expect(deserializedVideo.official, originalVideo.official);
        expect(deserializedVideo.publishedAt, originalVideo.publishedAt);
        expect(deserializedVideo.iso6391, originalVideo.iso6391);
        expect(deserializedVideo.iso31661, originalVideo.iso31661);
      });

      test(
          'should maintain data integrity through serialization cycle with null fields',
          () {
        // Arrange
        final originalVideo = Video(
          id: 'abc123',
          name: 'Official Trailer',
          key: 'dQw4w9WgXcQ',
          site: 'YouTube',
          type: 'Trailer',
        );

        // Act
        final json = originalVideo.toJson();
        final deserializedVideo = Video.fromJson(json);

        // Assert
        expect(deserializedVideo.id, originalVideo.id);
        expect(deserializedVideo.name, originalVideo.name);
        expect(deserializedVideo.key, originalVideo.key);
        expect(deserializedVideo.site, originalVideo.site);
        expect(deserializedVideo.size, originalVideo.size);
        expect(deserializedVideo.type, originalVideo.type);
        expect(deserializedVideo.official, originalVideo.official);
        expect(deserializedVideo.publishedAt, originalVideo.publishedAt);
        expect(deserializedVideo.iso6391, originalVideo.iso6391);
        expect(deserializedVideo.iso31661, originalVideo.iso31661);
      });
    });
  });
}
