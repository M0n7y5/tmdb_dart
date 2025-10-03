import 'package:test/test.dart';
import 'package:tmdb_dart/src/models/common/paginated_response.dart';
import 'package:tmdb_dart/src/models/common/genre.dart';

void main() {
  group('PaginatedResponse', () {
    // Create a simple test model for generic testing
    const testGenreJson = {
      'id': 28,
      'name': 'Action',
    };

    group('fromJson', () {
      test('should correctly deserialize from JSON with Genre type', () {
        // Arrange
        final json = {
          'page': 1,
          'results': [testGenreJson],
          'total_pages': 10,
          'total_results': 200,
        };

        // Act
        final response = PaginatedResponse<Genre>.fromJson(
          json,
          (json) => Genre.fromJson(json as Map<String, dynamic>),
        );

        // Assert
        expect(response.page, 1);
        expect(response.results.length, 1);
        expect(response.results[0].id, 28);
        expect(response.results[0].name, 'Action');
        expect(response.totalPages, 10);
        expect(response.totalResults, 200);
      });

      test('should correctly deserialize from JSON with multiple results', () {
        // Arrange
        final json = {
          'page': 1,
          'results': [
            testGenreJson,
            {'id': 12, 'name': 'Adventure'},
            {'id': 16, 'name': 'Animation'},
          ],
          'total_pages': 5,
          'total_results': 100,
        };

        // Act
        final response = PaginatedResponse<Genre>.fromJson(
          json,
          (json) => Genre.fromJson(json as Map<String, dynamic>),
        );

        // Assert
        expect(response.page, 1);
        expect(response.results.length, 3);
        expect(response.results[0].id, 28);
        expect(response.results[0].name, 'Action');
        expect(response.results[1].id, 12);
        expect(response.results[1].name, 'Adventure');
        expect(response.results[2].id, 16);
        expect(response.results[2].name, 'Animation');
        expect(response.totalPages, 5);
        expect(response.totalResults, 100);
      });

      test('should handle empty results list', () {
        // Arrange
        final json = {
          'page': 1,
          'results': [],
          'total_pages': 10,
          'total_results': 200,
        };

        // Act
        final response = PaginatedResponse<Genre>.fromJson(
          json,
          (json) => Genre.fromJson(json as Map<String, dynamic>),
        );

        // Assert
        expect(response.page, 1);
        expect(response.results.isEmpty, true);
        expect(response.totalPages, 10);
        expect(response.totalResults, 200);
      });

      test('should handle null values for required fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act & Assert
        expect(
          () => PaginatedResponse<Genre>.fromJson(
            json,
            (json) => Genre.fromJson(json as Map<String, dynamic>),
          ),
          throwsA(isA<TypeError>()),
        );
      });

      test('should work with different generic types (Map)', () {
        // Arrange
        final json = {
          'page': 1,
          'results': [
            {'key': 'value1'},
            {'key': 'value2'},
          ],
          'total_pages': 1,
          'total_results': 2,
        };

        // Act
        final response = PaginatedResponse<Map<String, dynamic>>.fromJson(
          json,
          (json) => json as Map<String, dynamic>,
        );

        // Assert
        expect(response.page, 1);
        expect(response.results.length, 2);
        expect(response.results[0]['key'], 'value1');
        expect(response.results[1]['key'], 'value2');
        expect(response.totalPages, 1);
        expect(response.totalResults, 2);
      });

      test('should work with different generic types (String)', () {
        // Arrange
        final json = {
          'page': 1,
          'results': ['item1', 'item2', 'item3'],
          'total_pages': 1,
          'total_results': 3,
        };

        // Act
        final response = PaginatedResponse<String>.fromJson(
          json,
          (json) => json as String,
        );

        // Assert
        expect(response.page, 1);
        expect(response.results.length, 3);
        expect(response.results[0], 'item1');
        expect(response.results[1], 'item2');
        expect(response.results[2], 'item3');
        expect(response.totalPages, 1);
        expect(response.totalResults, 3);
      });
    });

    group('toJson', () {
      test('should correctly serialize to JSON with Genre type', () {
        // Arrange
        const genre = Genre(id: 28, name: 'Action');
        final response = PaginatedResponse<Genre>(
          page: 1,
          results: [genre],
          totalPages: 10,
          totalResults: 200,
        );

        // Act
        final json = response.toJson((genre) => genre.toJson());

        // Assert
        expect(json['page'], 1);
        expect(json['results'].length, 1);
        expect(json['results'][0]['id'], 28);
        expect(json['results'][0]['name'], 'Action');
        expect(json['total_pages'], 10);
        expect(json['total_results'], 200);
      });

      test('should correctly serialize to JSON with multiple results', () {
        // Arrange
        const genre1 = Genre(id: 28, name: 'Action');
        const genre2 = Genre(id: 12, name: 'Adventure');
        const genre3 = Genre(id: 16, name: 'Animation');
        final response = PaginatedResponse<Genre>(
          page: 1,
          results: [genre1, genre2, genre3],
          totalPages: 5,
          totalResults: 100,
        );

        // Act
        final json = response.toJson((genre) => genre.toJson());

        // Assert
        expect(json['page'], 1);
        expect(json['results'].length, 3);
        expect(json['results'][0]['id'], 28);
        expect(json['results'][0]['name'], 'Action');
        expect(json['results'][1]['id'], 12);
        expect(json['results'][1]['name'], 'Adventure');
        expect(json['results'][2]['id'], 16);
        expect(json['results'][2]['name'], 'Animation');
        expect(json['total_pages'], 5);
        expect(json['total_results'], 100);
      });

      test('should correctly serialize to JSON with empty results', () {
        // Arrange
        final response = PaginatedResponse<Genre>(
          page: 1,
          results: [],
          totalPages: 10,
          totalResults: 200,
        );

        // Act
        final json = response.toJson((genre) => genre.toJson());

        // Assert
        expect(json['page'], 1);
        expect(json['results'], []);
        expect(json['total_pages'], 10);
        expect(json['total_results'], 200);
      });

      test('should work with different generic types (String)', () {
        // Arrange
        final response = PaginatedResponse<String>(
          page: 1,
          results: ['item1', 'item2', 'item3'],
          totalPages: 1,
          totalResults: 3,
        );

        // Act
        final json = response.toJson((item) => item);

        // Assert
        expect(json['page'], 1);
        expect(json['results'].length, 3);
        expect(json['results'][0], 'item1');
        expect(json['results'][1], 'item2');
        expect(json['results'][2], 'item3');
        expect(json['total_pages'], 1);
        expect(json['total_results'], 3);
      });
    });

    group('round-trip', () {
      test(
          'should maintain data integrity through serialization cycle with Genre type',
          () {
        // Arrange
        const genre = Genre(id: 28, name: 'Action');
        final originalResponse = PaginatedResponse<Genre>(
          page: 1,
          results: [genre],
          totalPages: 10,
          totalResults: 200,
        );

        // Act
        final json = originalResponse.toJson((genre) => genre.toJson());
        final deserializedResponse = PaginatedResponse<Genre>.fromJson(
          json,
          (json) => Genre.fromJson(json as Map<String, dynamic>),
        );

        // Assert
        expect(deserializedResponse.page, originalResponse.page);
        expect(deserializedResponse.results.length,
            originalResponse.results.length);
        expect(
            deserializedResponse.results[0].id, originalResponse.results[0].id);
        expect(deserializedResponse.results[0].name,
            originalResponse.results[0].name);
        expect(deserializedResponse.totalPages, originalResponse.totalPages);
        expect(
            deserializedResponse.totalResults, originalResponse.totalResults);
      });

      test(
          'should maintain data integrity through serialization cycle with multiple results',
          () {
        // Arrange
        const genre1 = Genre(id: 28, name: 'Action');
        const genre2 = Genre(id: 12, name: 'Adventure');
        const genre3 = Genre(id: 16, name: 'Animation');
        final originalResponse = PaginatedResponse<Genre>(
          page: 1,
          results: [genre1, genre2, genre3],
          totalPages: 5,
          totalResults: 100,
        );

        // Act
        final json = originalResponse.toJson((genre) => genre.toJson());
        final deserializedResponse = PaginatedResponse<Genre>.fromJson(
          json,
          (json) => Genre.fromJson(json as Map<String, dynamic>),
        );

        // Assert
        expect(deserializedResponse.page, originalResponse.page);
        expect(deserializedResponse.results.length,
            originalResponse.results.length);

        for (int i = 0; i < originalResponse.results.length; i++) {
          expect(deserializedResponse.results[i].id,
              originalResponse.results[i].id);
          expect(deserializedResponse.results[i].name,
              originalResponse.results[i].name);
        }

        expect(deserializedResponse.totalPages, originalResponse.totalPages);
        expect(
            deserializedResponse.totalResults, originalResponse.totalResults);
      });

      test(
          'should maintain data integrity through serialization cycle with empty results',
          () {
        // Arrange
        final originalResponse = PaginatedResponse<Genre>(
          page: 1,
          results: [],
          totalPages: 10,
          totalResults: 200,
        );

        // Act
        final json = originalResponse.toJson((genre) => genre.toJson());
        final deserializedResponse = PaginatedResponse<Genre>.fromJson(
          json,
          (json) => Genre.fromJson(json as Map<String, dynamic>),
        );

        // Assert
        expect(deserializedResponse.page, originalResponse.page);
        expect(deserializedResponse.results.length,
            originalResponse.results.length);
        expect(deserializedResponse.totalPages, originalResponse.totalPages);
        expect(
            deserializedResponse.totalResults, originalResponse.totalResults);
      });

      test(
          'should maintain data integrity through serialization cycle with String type',
          () {
        // Arrange
        final originalResponse = PaginatedResponse<String>(
          page: 1,
          results: ['item1', 'item2', 'item3'],
          totalPages: 1,
          totalResults: 3,
        );

        // Act
        final json = originalResponse.toJson((item) => item);
        final deserializedResponse = PaginatedResponse<String>.fromJson(
          json,
          (json) => json as String,
        );

        // Assert
        expect(deserializedResponse.page, originalResponse.page);
        expect(deserializedResponse.results.length,
            originalResponse.results.length);

        for (int i = 0; i < originalResponse.results.length; i++) {
          expect(deserializedResponse.results[i], originalResponse.results[i]);
        }

        expect(deserializedResponse.totalPages, originalResponse.totalPages);
        expect(
            deserializedResponse.totalResults, originalResponse.totalResults);
      });
    });
  });
}
