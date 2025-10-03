import 'package:test/test.dart';
import 'package:tmdb_dart/src/models/common/external_ids.dart';

void main() {
  group('ExternalIds', () {
    group('fromJson', () {
      test('should correctly deserialize from JSON with all fields', () {
        // Arrange
        final json = {
          'imdb_id': 'tt1234567',
          'facebook_id': 'facebook123',
          'instagram_id': 'instagram123',
          'twitter_id': 'twitter123',
          'wikidata_id': 'Q123456',
        };

        // Act
        final externalIds = ExternalIds.fromJson(json);

        // Assert
        expect(externalIds.imdbId, 'tt1234567');
        expect(externalIds.facebookId, 'facebook123');
        expect(externalIds.instagramId, 'instagram123');
        expect(externalIds.twitterId, 'twitter123');
        expect(externalIds.wikidataId, 'Q123456');
      });

      test('should handle null/optional fields', () {
        // Arrange
        final json = {
          'imdb_id': 'tt1234567',
          'facebook_id': null,
          'instagram_id': null,
          'twitter_id': null,
          'wikidata_id': null,
        };

        // Act
        final externalIds = ExternalIds.fromJson(json);

        // Assert
        expect(externalIds.imdbId, 'tt1234567');
        expect(externalIds.facebookId, isNull);
        expect(externalIds.instagramId, isNull);
        expect(externalIds.twitterId, isNull);
        expect(externalIds.wikidataId, isNull);
      });

      test('should handle missing fields', () {
        // Arrange
        final json = {
          'imdb_id': 'tt1234567',
        };

        // Act
        final externalIds = ExternalIds.fromJson(json);

        // Assert
        expect(externalIds.imdbId, 'tt1234567');
        expect(externalIds.facebookId, isNull);
        expect(externalIds.instagramId, isNull);
        expect(externalIds.twitterId, isNull);
        expect(externalIds.wikidataId, isNull);
      });

      test('should handle empty JSON', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final externalIds = ExternalIds.fromJson(json);

        // Assert
        expect(externalIds.imdbId, isNull);
        expect(externalIds.facebookId, isNull);
        expect(externalIds.instagramId, isNull);
        expect(externalIds.twitterId, isNull);
        expect(externalIds.wikidataId, isNull);
      });
    });

    group('toJson', () {
      test('should correctly serialize to JSON with all fields', () {
        // Arrange
        const externalIds = ExternalIds(
          imdbId: 'tt1234567',
          facebookId: 'facebook123',
          instagramId: 'instagram123',
          twitterId: 'twitter123',
          wikidataId: 'Q123456',
        );

        // Act
        final json = externalIds.toJson();

        // Assert
        expect(json['imdb_id'], 'tt1234567');
        expect(json['facebook_id'], 'facebook123');
        expect(json['instagram_id'], 'instagram123');
        expect(json['twitter_id'], 'twitter123');
        expect(json['wikidata_id'], 'Q123456');
      });

      test('should correctly serialize to JSON with null fields', () {
        // Arrange
        const externalIds = ExternalIds(
          imdbId: 'tt1234567',
        );

        // Act
        final json = externalIds.toJson();

        // Assert
        expect(json['imdb_id'], 'tt1234567');
        expect(json['facebook_id'], isNull);
        expect(json['instagram_id'], isNull);
        expect(json['twitter_id'], isNull);
        expect(json['wikidata_id'], isNull);
      });
    });

    group('round-trip', () {
      test(
          'should maintain data integrity through serialization cycle with all fields',
          () {
        // Arrange
        const originalExternalIds = ExternalIds(
          imdbId: 'tt1234567',
          facebookId: 'facebook123',
          instagramId: 'instagram123',
          twitterId: 'twitter123',
          wikidataId: 'Q123456',
        );

        // Act
        final json = originalExternalIds.toJson();
        final deserializedExternalIds = ExternalIds.fromJson(json);

        // Assert
        expect(deserializedExternalIds.imdbId, originalExternalIds.imdbId);
        expect(
            deserializedExternalIds.facebookId, originalExternalIds.facebookId);
        expect(deserializedExternalIds.instagramId,
            originalExternalIds.instagramId);
        expect(
            deserializedExternalIds.twitterId, originalExternalIds.twitterId);
        expect(
            deserializedExternalIds.wikidataId, originalExternalIds.wikidataId);
      });

      test(
          'should maintain data integrity through serialization cycle with null fields',
          () {
        // Arrange
        const originalExternalIds = ExternalIds(
          imdbId: 'tt1234567',
        );

        // Act
        final json = originalExternalIds.toJson();
        final deserializedExternalIds = ExternalIds.fromJson(json);

        // Assert
        expect(deserializedExternalIds.imdbId, originalExternalIds.imdbId);
        expect(
            deserializedExternalIds.facebookId, originalExternalIds.facebookId);
        expect(deserializedExternalIds.instagramId,
            originalExternalIds.instagramId);
        expect(
            deserializedExternalIds.twitterId, originalExternalIds.twitterId);
        expect(
            deserializedExternalIds.wikidataId, originalExternalIds.wikidataId);
      });
    });

    group('equality', () {
      test('should consider equal external IDs with same values', () {
        // Arrange
        const externalIds1 = ExternalIds(
          imdbId: 'tt1234567',
          facebookId: 'facebook123',
          instagramId: 'instagram123',
          twitterId: 'twitter123',
          wikidataId: 'Q123456',
        );
        const externalIds2 = ExternalIds(
          imdbId: 'tt1234567',
          facebookId: 'facebook123',
          instagramId: 'instagram123',
          twitterId: 'twitter123',
          wikidataId: 'Q123456',
        );

        // Assert
        expect(externalIds1, equals(externalIds2));
      });

      test('should consider different external IDs with different imdb IDs',
          () {
        // Arrange
        const externalIds1 = ExternalIds(imdbId: 'tt1234567');
        const externalIds2 = ExternalIds(imdbId: 'tt7654321');

        // Assert
        expect(externalIds1, isNot(equals(externalIds2)));
      });
    });
  });
}
