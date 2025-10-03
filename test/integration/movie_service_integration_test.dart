import 'package:test/test.dart';
import 'package:tmdb_dart/tmdb_dart.dart';

import 'config/integration_test_config.dart';
import 'helpers/integration_test_helper.dart';
import 'helpers/known_test_ids.dart';

/// Integration tests for the MovieService.
///
/// These tests validate the MovieService methods against the real TMDB API.
/// They require a valid TMDB API key to run.
@Tags(['integration'])
void main() {
  group('MovieService Integration Tests', () {
    late TmdbClient client;
    late MovieService movieService;

    // Set up the test client before running tests
    setUpAll(() {
      // Skip all tests if no API key is provided
      if (!IntegrationTestConfig.hasApiKey) {
        print(IntegrationTestConfig.skipMessage);
        return;
      }
      
      client = IntegrationTestConfig.createClient();
      movieService = client.movies;
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

    group('getDetails', () {
      test('returns valid movie details for Inception', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final movie = await movieService.getDetails(KnownTestIds.inception);

        // Verify required fields
        expect(movie.id, equals(KnownTestIds.inception), reason: 'Movie ID should match requested ID');
        expect(movie.title, isNotEmpty, reason: 'Movie title should not be empty');
        expect(movie.overview, isNotEmpty, reason: 'Movie overview should not be empty');
        expect(movie.releaseDate, isNotNull, reason: 'Movie should have a release date');
        
        // Verify collections
        expect(movie.genres, isNotEmpty, reason: 'Movie should have at least one genre');
        expect(movie.productionCompanies, isNotEmpty, reason: 'Movie should have production companies');
        
        // Verify numeric fields
        expect(movie.budget, greaterThan(0), reason: 'Movie budget should be greater than 0');
        expect(movie.revenue, greaterThan(0), reason: 'Movie revenue should be greater than 0');
        expect(movie.runtime, greaterThan(0), reason: 'Movie runtime should be greater than 0');
        expect(movie.voteAverage, greaterThan(0), reason: 'Movie vote average should be greater than 0');
        expect(movie.voteAverage, lessThanOrEqualTo(10), reason: 'Movie vote average should be <= 10');
        
        // Verify specific details for Inception
        expect(movie.title, equals('Inception'), reason: 'Movie title should be Inception');
        expect(movie.originalTitle, equals('Inception'), reason: 'Original title should be Inception');
        expect(movie.originalLanguage, equals('en'), reason: 'Original language should be English');
      }, timeout: const Timeout(Duration(seconds: 30)));

      test('throws TmdbNotFoundException for invalid movie ID', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        // Use an ID that's very unlikely to exist
        const invalidMovieId = 999999999;

        expect(
          () => movieService.getDetails(invalidMovieId),
          throwsA(isA<TmdbNotFoundException>()),
          reason: 'Should throw TmdbNotFoundException for invalid movie ID',
        );
      }, timeout: const Timeout(Duration(seconds: 30)));
    });

    group('getPopular', () {
      test('returns paginated response with valid popular movies', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final response = await movieService.getPopular();

        // Validate paginated response structure
        IntegrationTestHelper.validatePaginatedResponse(
          response,
          expectedPage: 1,
          minResults: 1,
        );

        // Verify results are not empty
        expect(response.results, isNotEmpty, reason: 'Popular movies list should not be empty');

        // Verify first movie has proper structure
        final firstMovie = response.results.first;
        IntegrationTestHelper.validateCommonEntityProperties(
          firstMovie,
          firstMovie.title,
        );
        expect(firstMovie.popularity, greaterThan(0), reason: 'Movie popularity should be greater than 0');
        expect(firstMovie.voteAverage, greaterThanOrEqualTo(0), reason: 'Movie vote average should be non-negative');
        expect(firstMovie.voteAverage, lessThanOrEqualTo(10), reason: 'Movie vote average should be <= 10');
      }, timeout: const Timeout(Duration(seconds: 30)));

      test('returns different results for page 2', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final page1Response = await movieService.getPopular(page: 1);
        await IntegrationTestHelper.addRateLimitDelay();
        final page2Response = await movieService.getPopular(page: 2);

        // Verify pagination metadata
        expect(page1Response.page, equals(1), reason: 'First response should be page 1');
        expect(page2Response.page, equals(2), reason: 'Second response should be page 2');
        expect(page2Response.totalPages, greaterThan(1), reason: 'Should have more than 1 page of results');
        expect(page2Response.totalResults, greaterThan(page1Response.results.length), 
               reason: 'Total results should be greater than page 1 results');

        // Verify different results
        final page1Ids = page1Response.results.map((m) => m.id).toSet();
        final page2Ids = page2Response.results.map((m) => m.id).toSet();
        
        expect(page2Ids.intersection(page1Ids), isEmpty, 
               reason: 'Page 2 should have different movies from page 1');
      }, timeout: const Timeout(Duration(seconds: 30)));
    });

    group('getNowPlaying', () {
      test('returns paginated response with valid now playing movies', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final response = await movieService.getNowPlaying();

        // Validate paginated response structure
        IntegrationTestHelper.validatePaginatedResponse(
          response,
          expectedPage: 1,
          minResults: 1,
        );

        // Verify results are not empty
        expect(response.results, isNotEmpty, reason: 'Now playing movies list should not be empty');

        // Verify movie data presence
        for (final movie in response.results) {
          IntegrationTestHelper.validateCommonEntityProperties(
            movie,
            movie.title,
          );
          expect(movie.releaseDate, isNotNull, reason: 'Now playing movie should have a release date');
        }
      }, timeout: const Timeout(Duration(seconds: 30)));
    });

    group('getTopRated', () {
      test('returns movies sorted by rating', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final response = await movieService.getTopRated();

        // Validate paginated response structure
        IntegrationTestHelper.validatePaginatedResponse(
          response,
          expectedPage: 1,
          minResults: 1,
        );

        // Verify results are not empty
        expect(response.results, isNotEmpty, reason: 'Top rated movies list should not be empty');

        // Verify high vote averages
        for (final movie in response.results.take(5)) {
          expect(movie.voteAverage, greaterThan(7.0), 
                 reason: 'Top rated movies should have high vote averages (> 7.0)');
          expect(movie.voteCount, greaterThan(100), 
                 reason: 'Top rated movies should have sufficient vote counts (> 100)');
        }

        // Verify sorting (first movie should have high rating)
        expect(response.results.first.voteAverage, greaterThan(8.0), 
               reason: 'First movie in top rated should have very high rating (> 8.0)');
      }, timeout: const Timeout(Duration(seconds: 30)));
    });

    group('getCredits', () {
      test('returns valid credits for Inception', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final credits = await movieService.getCredits(KnownTestIds.inception);

        // Verify credits structure
        expect(credits.id, equals(KnownTestIds.inception), reason: 'Credits ID should match movie ID');
        expect(credits.cast, isNotEmpty, reason: 'Movie should have cast members');
        expect(credits.crew, isNotEmpty, reason: 'Movie should have crew members');

        // Verify cast member structure
        for (final castMember in credits.cast.take(5)) {
          expect(castMember.id, greaterThan(0), reason: 'Cast member should have valid ID');
          expect(castMember.name, isNotEmpty, reason: 'Cast member should have a name');
          expect(castMember.character, isNotEmpty, reason: 'Cast member should have a character');
        }

        // Verify crew member structure
        for (final crewMember in credits.crew.take(5)) {
          expect(crewMember.id, greaterThan(0), reason: 'Crew member should have valid ID');
          expect(crewMember.name, isNotEmpty, reason: 'Crew member should have a name');
          expect(crewMember.job, isNotEmpty, reason: 'Crew member should have a job');
          expect(crewMember.department, isNotEmpty, reason: 'Crew member should have a department');
        }

        // Verify key people for Inception
        final director = credits.crew.firstWhere(
          (crew) => crew.job.toLowerCase() == 'director',
          orElse: () => throw Exception('Director not found'),
        );
        expect(director.name, equals('Christopher Nolan'), reason: 'Christopher Nolan should be the director');
      }, timeout: const Timeout(Duration(seconds: 30)));
    });

    group('getImages', () {
      test('returns valid images for Inception', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final images = await movieService.getImages(KnownTestIds.inception);

        // Verify images are not empty
        expect(images, isNotEmpty, reason: 'Movie should have images');

        // Verify image types
        // TmdbImage doesn't have imageType property, so we'll check if we have different image types
        // by checking the aspect ratios which typically differ between posters, backdrops, and logos
        final hasWideImages = images.any((img) => img.aspectRatio != null && img.aspectRatio! > 1.5);
        final hasTallImages = images.any((img) => img.aspectRatio != null && img.aspectRatio! < 1.0);

        expect(hasWideImages, isTrue, reason: 'Movie should have wide images (backdrops)');
        expect(hasTallImages, isTrue, reason: 'Movie should have tall images (posters)');
        // Logos might not always be present, so we don't require them

        // Verify image paths
        for (final image in images.take(5)) {
          IntegrationTestHelper.validateImagePath(image.filePath);
          expect(image.aspectRatio, greaterThan(0), reason: 'Image should have positive aspect ratio');
        }
      }, timeout: const Timeout(Duration(seconds: 30)));
    });

    group('getVideos', () {
      test('returns valid videos for Inception', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final videos = await movieService.getVideos(KnownTestIds.inception);

        // Verify videos list is not empty
        expect(videos, isNotEmpty, reason: 'Movie should have videos');

        // Verify video properties
        for (final video in videos.take(5)) {
          expect(video.key, isNotEmpty, reason: 'Video should have a key');
          expect(video.site, isNotEmpty, reason: 'Video should have a site (e.g., YouTube)');
          expect(video.type, isNotEmpty, reason: 'Video should have a type (e.g., Trailer)');
          expect(video.name, isNotEmpty, reason: 'Video should have a name');
        }

        // Verify at least one trailer exists
        final hasTrailer = videos.any((v) => v.type.toLowerCase() == 'trailer');
        expect(hasTrailer, isTrue, reason: 'Movie should have at least one trailer');
      }, timeout: const Timeout(Duration(seconds: 30)));
    });

    // Optional tests (MEDIUM PRIORITY)
    group('getUpcoming', () {
      test('returns valid upcoming movies', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final response = await movieService.getUpcoming();

        // Validate paginated response structure
        IntegrationTestHelper.validatePaginatedResponse(
          response,
          expectedPage: 1,
        );

        // Verify upcoming movies have future release dates
        final now = DateTime.now();
        for (final movie in response.results.take(5)) {
          if (movie.releaseDate != null) {
            expect(
              movie.releaseDate!.isAfter(now.subtract(const Duration(days: 30))), 
              isTrue,
              reason: 'Upcoming movie should have recent or future release date'
            );
          }
        }
      }, timeout: const Timeout(Duration(seconds: 30)));
    });

    group('getReviews', () {
      test('returns valid reviews for The Shawshank Redemption', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final response = await movieService.getReviews(KnownTestIds.shawshankRedemption);

        // Validate paginated response structure
        IntegrationTestHelper.validatePaginatedResponse(response);

        // Verify review content if present
        for (final review in response.results.take(3)) {
          expect(review.id, isNotEmpty, reason: 'Review should have an ID');
          expect(review.author, isNotEmpty, reason: 'Review should have an author');
          expect(review.content, isNotEmpty, reason: 'Review should have content');
        }
      }, timeout: const Timeout(Duration(seconds: 30)));
    });

    group('getKeywords', () {
      test('returns valid keywords for Inception', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final keywords = await movieService.getKeywords(KnownTestIds.inception);

        // Verify keywords are not empty
        expect(keywords, isNotEmpty, reason: 'Movie should have keywords');

        // Verify keyword structure
        for (final keyword in keywords.take(5)) {
          expect(keyword.id, greaterThan(0), reason: 'Keyword should have valid ID');
          expect(keyword.name, isNotEmpty, reason: 'Keyword should have a name');
        }

        // Verify expected keywords for Inception
        final keywordNames = keywords.map((k) => k.name.toLowerCase()).toList();
        expect(keywordNames, contains('dream'), reason: 'Inception should have "dream" keyword');
        expect(keywordNames, contains('theft'), reason: 'Inception should have "theft" keyword');
      }, timeout: const Timeout(Duration(seconds: 30)));
    });

    group('getSimilar', () {
      test('returns valid similar movies for Inception', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final response = await movieService.getSimilar(KnownTestIds.inception);

        // Validate paginated response structure
        IntegrationTestHelper.validatePaginatedResponse(response);

        // Verify similar movies are not the same movie
        for (final movie in response.results) {
          expect(movie.id, isNot(equals(KnownTestIds.inception)), 
                 reason: 'Similar movies should not include the original movie');
        }

        // Verify at least some similar movies exist
        expect(response.results.length, greaterThan(0), reason: 'Should have at least one similar movie');
      }, timeout: const Timeout(Duration(seconds: 30)));
    });

    group('getRecommendations', () {
      test('returns valid recommended movies for Inception', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final response = await movieService.getRecommendations(KnownTestIds.inception);

        // Validate paginated response structure
        IntegrationTestHelper.validatePaginatedResponse(response);

        // Verify recommendations are not the same movie
        for (final movie in response.results) {
          expect(movie.id, isNot(equals(KnownTestIds.inception)), 
                 reason: 'Recommended movies should not include the original movie');
        }

        // Verify at least some recommendations exist
        expect(response.results.length, greaterThan(0), reason: 'Should have at least one recommendation');
      }, timeout: const Timeout(Duration(seconds: 30)));
    });

    group('getExternalIds', () {
      test('returns valid external IDs for Inception', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final externalIds = await movieService.getExternalIds(KnownTestIds.inception);

        // Verify external IDs structure
        // ExternalIds doesn't have an id property, so we'll just verify it has content
        expect(externalIds.imdbId, isNotEmpty, reason: 'Movie should have an IMDB ID');
      }, timeout: const Timeout(Duration(seconds: 30)));
    });

    group('getWatchProviders', () {
      test('returns valid watch providers for Inception', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final watchProviders = await movieService.getWatchProviders(KnownTestIds.inception);

        // Verify watch providers structure
        // WatchProvidersResult doesn't have an id property, so we'll just verify it has content
        expect(watchProviders.results, isNotEmpty, reason: 'Should have watch providers for at least one region');
      }, timeout: const Timeout(Duration(seconds: 30)));
    });

    group('getAlternativeTitles', () {
      test('returns valid alternative titles for Inception', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final titles = await movieService.getAlternativeTitles(KnownTestIds.inception);

        // Verify alternative titles structure
        expect(titles, isNotEmpty, reason: 'Movie should have alternative titles');
        
        // Verify title format
        for (final entry in titles.entries.take(5)) {
          expect(entry.key, isNotEmpty, reason: 'Country code should not be empty');
          expect(entry.value, isNotEmpty, reason: 'Alternative title should not be empty');
        }
      }, timeout: const Timeout(Duration(seconds: 30)));
    });
  });
}