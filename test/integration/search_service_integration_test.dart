import 'package:test/test.dart';
import 'package:tmdb_dart/tmdb_dart.dart';

import 'config/integration_test_config.dart';
import 'helpers/integration_test_helper.dart';
import 'helpers/known_test_ids.dart';

/// Integration tests for the SearchService.
///
/// These tests validate the SearchService methods against the real TMDB API.
/// They require a valid TMDB API key to run.
@Tags(['integration'])
void main() {
  group('SearchService Integration Tests', () {
    late TmdbClient client;
    late SearchService searchService;

    // Set up the test client before running tests
    setUpAll(() {
      // Skip all tests if no API key is provided
      if (!IntegrationTestConfig.hasApiKey) {
        print(IntegrationTestConfig.skipMessage);
        return;
      }
      
      client = IntegrationTestConfig.createClient();
      searchService = client.search;
    });

    // Clean up after all tests are done
    tearDownAll(() async {
      if (IntegrationTestConfig.hasApiKey) {
        await client.close();
      }
    });

    // Add rate limit delay between tests
    setUp(() async {
      if (IntegrationTestConfig.hasApiKey) {
        await IntegrationTestHelper.addRateLimitDelay();
      }
    });

    group('searchMovies', () {
      test('returns paginated response with valid movies for Matrix query', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final response = await searchService.searchMovies(KnownTestIds.searchMovieQuery);

        // Validate paginated response structure
        IntegrationTestHelper.validatePaginatedResponse(
          response,
          expectedPage: 1,
          minResults: 1,
        );

        // Verify results are not empty
        expect(response.results, isNotEmpty, reason: 'Search results should not be empty');

        // Verify first result is movie-related (has title field)
        final firstResult = response.results.first;
        expect(firstResult.title, isNotEmpty, reason: 'Movie should have a title');
        expect(firstResult.id, greaterThan(0), reason: 'Movie should have a valid ID');

        // Check for The Matrix in results
        final matrixTitles = response.results
            .where((movie) => movie.title.toLowerCase().contains('matrix'))
            .toList();
        expect(matrixTitles, isNotEmpty, reason: 'Results should contain Matrix movies');
      }, timeout: const Timeout(Duration(seconds: 30)));

      test('returns movies filtered by year', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final response = await searchService.searchMovies(
          KnownTestIds.searchMovieQuery,
          year: 1999,
        );

        // Validate paginated response structure
        IntegrationTestHelper.validatePaginatedResponse(
          response,
          expectedPage: 1,
        );

        // Verify results match the year constraint
        for (final movie in response.results) {
          if (movie.releaseDate != null) {
            expect(movie.releaseDate!.year, equals(1999),
                reason: 'Movie release year should match filter');
          }
        }
      }, timeout: const Timeout(Duration(seconds: 30)));

      test('returns different results for page 2', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final page1Response = await searchService.searchMovies(KnownTestIds.searchMovieQuery);
        await IntegrationTestHelper.addRateLimitDelay();
        final page2Response = await searchService.searchMovies(
          KnownTestIds.searchMovieQuery,
          page: 2,
        );

        // Verify pagination metadata
        expect(page1Response.page, equals(1), reason: 'First response should be page 1');
        expect(page2Response.page, equals(2), reason: 'Second response should be page 2');
        expect(page2Response.totalPages, greaterThan(1), reason: 'Should have more than 1 page of results');

        // Verify different results
        final page1Ids = page1Response.results.map((m) => m.id).toSet();
        final page2Ids = page2Response.results.map((m) => m.id).toSet();
        
        expect(page2Ids.intersection(page1Ids), isEmpty, 
               reason: 'Page 2 should have different movies from page 1');
      }, timeout: const Timeout(Duration(seconds: 30)));
    });

    group('searchTvShows', () {
      test('returns paginated response with valid TV shows for Friends query', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final response = await searchService.searchTvShows(KnownTestIds.searchTvQuery);

        // Validate paginated response structure
        IntegrationTestHelper.validatePaginatedResponse(
          response,
          expectedPage: 1,
          minResults: 1,
        );

        // Verify results are not empty
        expect(response.results, isNotEmpty, reason: 'Search results should not be empty');

        // Verify first result is TV-related (has name field)
        final firstResult = response.results.first;
        expect(firstResult.name, isNotEmpty, reason: 'TV show should have a name');
        expect(firstResult.id, greaterThan(0), reason: 'TV show should have a valid ID');
      }, timeout: const Timeout(Duration(seconds: 30)));
    });

    group('searchPeople', () {
      test('returns paginated response with valid people for Tom Cruise query', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final response = await searchService.searchPeople(KnownTestIds.searchPersonQuery);

        // Validate paginated response structure
        IntegrationTestHelper.validatePaginatedResponse(
          response,
          expectedPage: 1,
          minResults: 1,
        );

        // Verify results are not empty
        expect(response.results, isNotEmpty, reason: 'Search results should not be empty');

        // Verify first result has person properties
        final firstResult = response.results.first;
        expect(firstResult.name, isNotEmpty, reason: 'Person should have a name');
        expect(firstResult.id, greaterThan(0), reason: 'Person should have a valid ID');
        expect(firstResult.knownForDepartment, isNotNull, 
               reason: 'Person should have a known for department');

        // Check for Tom Cruise in results
        final tomCruiseResults = response.results
            .where((person) => person.name.toLowerCase().contains('tom cruise'))
            .toList();
        expect(tomCruiseResults, isNotEmpty, reason: 'Results should contain Tom Cruise');
      }, timeout: const Timeout(Duration(seconds: 30)));
    });

    group('searchMulti', () {
      test('returns paginated response with mixed media types for Matrix query', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final response = await searchService.searchMulti(KnownTestIds.searchMovieQuery);

        // Validate paginated response structure
        IntegrationTestHelper.validatePaginatedResponse(
          response,
          expectedPage: 1,
          minResults: 1,
        );

        // Verify results are not empty
        expect(response.results, isNotEmpty, reason: 'Search results should not be empty');

        // Verify mediaType field exists on results
        for (final result in response.results.take(5)) {
          expect(result, containsPair('media_type', isNotNull),
                 reason: 'Each result should have a media_type field');
        }

        // Check that results include both movie and other types
        final mediaTypes = response.results
            .map((result) => result['media_type'] as String)
            .toSet();
        
        expect(mediaTypes.length, greaterThan(1),
               reason: 'Results should contain multiple media types');
        expect(mediaTypes, contains('movie'),
               reason: 'Results should include movies');
      }, timeout: const Timeout(Duration(seconds: 30)));
    });

    // Optional tests (MEDIUM PRIORITY)
    group('searchCompanies', () {
      test('returns valid companies for Marvel query', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final response = await searchService.searchCompanies(KnownTestIds.searchCompanyQuery);

        // Validate paginated response structure
        IntegrationTestHelper.validatePaginatedResponse(
          response,
          expectedPage: 1,
        );

        // Verify results are not empty
        expect(response.results, isNotEmpty, reason: 'Search results should not be empty');

        // Check company structure
        for (final company in response.results.take(5)) {
          expect(company, containsPair('id', isA<int>()),
                 reason: 'Company should have an integer ID');
          expect(company, containsPair('name', isNotEmpty),
                 reason: 'Company should have a name');
          // logoPath might be null, so we don't require it
        }
      }, timeout: const Timeout(Duration(seconds: 30)));
    });

    group('searchCollections', () {
      test('returns valid collections for Avengers query', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final response = await searchService.searchCollections(KnownTestIds.searchCollectionQuery);

        // Validate paginated response structure
        IntegrationTestHelper.validatePaginatedResponse(
          response,
          expectedPage: 1,
        );

        // Verify results are not empty
        expect(response.results, isNotEmpty, reason: 'Search results should not be empty');

        // Check collection structure
        for (final collection in response.results.take(5)) {
          expect(collection, containsPair('id', isA<int>()),
                 reason: 'Collection should have an integer ID');
          expect(collection, containsPair('name', isNotEmpty),
                 reason: 'Collection should have a name');
          // posterPath might be null, so we don't require it
        }
      }, timeout: const Timeout(Duration(seconds: 30)));
    });

    group('searchKeywords', () {
      test('returns valid keywords for dream query', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final response = await searchService.searchKeywords(KnownTestIds.searchKeywordQuery);

        // Validate paginated response structure
        IntegrationTestHelper.validatePaginatedResponse(
          response,
          expectedPage: 1,
        );

        // Verify results are not empty
        expect(response.results, isNotEmpty, reason: 'Search results should not be empty');

        // Check keyword structure
        for (final keyword in response.results.take(5)) {
          expect(keyword.id, greaterThan(0), reason: 'Keyword should have a valid ID');
          expect(keyword.name, isNotEmpty, reason: 'Keyword should have a name');
        }
      }, timeout: const Timeout(Duration(seconds: 30)));
    });
  });
}