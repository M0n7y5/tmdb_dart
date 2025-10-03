import 'package:test/test.dart';
import 'package:tmdb_dart/tmdb_dart.dart';

import 'config/integration_test_config.dart';
import 'helpers/integration_test_helper.dart';
import 'helpers/known_test_ids.dart';

/// Integration tests for the TvService.
///
/// These tests validate the TvService methods against the real TMDB API.
/// They require a valid TMDB API key to run.
@Tags(['integration'])
void main() {
  group('TvService Integration Tests', () {
    late TmdbClient client;
    late TvService tvService;

    // Set up the test client before running tests
    setUpAll(() {
      // Skip all tests if no API key is provided
      if (!IntegrationTestConfig.hasApiKey) {
        print(IntegrationTestConfig.skipMessage);
        return;
      }
      
      client = IntegrationTestConfig.createClient();
      tvService = client.tv;
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
      test('returns valid TV show details for Breaking Bad', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final tvShow = await tvService.getDetails(KnownTestIds.breakingBad);

        // Verify required fields
        expect(tvShow.id, equals(KnownTestIds.breakingBad), reason: 'TV show ID should match requested ID');
        expect(tvShow.name, isNotEmpty, reason: 'TV show name should not be empty');
        expect(tvShow.overview, isNotEmpty, reason: 'TV show overview should not be empty');
        expect(tvShow.firstAirDate, isNotNull, reason: 'TV show should have a first air date');
        
        // Verify collections
        expect(tvShow.genres, isNotEmpty, reason: 'TV show should have at least one genre');
        expect(tvShow.seasons, isNotEmpty, reason: 'TV show should have seasons');
        expect(tvShow.networks, isNotEmpty, reason: 'TV show should have networks');
        
        // Verify numeric fields
        expect(tvShow.numberOfSeasons, greaterThan(0), reason: 'TV show should have at least one season');
        expect(tvShow.numberOfEpisodes, greaterThan(0), reason: 'TV show should have at least one episode');
        expect(tvShow.voteAverage, greaterThan(0), reason: 'TV show vote average should be greater than 0');
        expect(tvShow.voteAverage, lessThanOrEqualTo(10), reason: 'TV show vote average should be <= 10');
        
        // Verify specific details for Breaking Bad
        expect(tvShow.name, equals('Breaking Bad'), reason: 'TV show name should be Breaking Bad');
        expect(tvShow.originalName, equals('Breaking Bad'), reason: 'Original name should be Breaking Bad');
        expect(tvShow.originalLanguage, equals('en'), reason: 'Original language should be English');
      }, timeout: const Timeout(Duration(seconds: 30)));

      test('throws TmdbNotFoundException for invalid TV show ID', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        // Use an ID that's very unlikely to exist
        const invalidTvId = 999999999;

        expect(
          () => tvService.getDetails(invalidTvId),
          throwsA(isA<TmdbNotFoundException>()),
          reason: 'Should throw TmdbNotFoundException for invalid TV show ID',
        );
      }, timeout: const Timeout(Duration(seconds: 30)));
    });

    group('getPopular', () {
      test('returns paginated response with valid popular TV shows', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final response = await tvService.getPopular();

        // Validate paginated response structure
        IntegrationTestHelper.validatePaginatedResponse(
          response,
          expectedPage: 1,
          minResults: 1,
        );

        // Verify results are not empty
        expect(response.results, isNotEmpty, reason: 'Popular TV shows list should not be empty');

        // Verify first TV show has proper structure
        final firstTvShow = response.results.first;
        IntegrationTestHelper.validateCommonEntityProperties(
          firstTvShow,
          firstTvShow.name,
        );
        expect(firstTvShow.popularity, greaterThan(0), reason: 'TV show popularity should be greater than 0');
        expect(firstTvShow.voteAverage, greaterThanOrEqualTo(0), reason: 'TV show vote average should be non-negative');
        expect(firstTvShow.voteAverage, lessThanOrEqualTo(10), reason: 'TV show vote average should be <= 10');
      }, timeout: const Timeout(Duration(seconds: 30)));

      test('returns different results for page 2', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final page1Response = await tvService.getPopular(page: 1);
        await IntegrationTestHelper.addRateLimitDelay();
        final page2Response = await tvService.getPopular(page: 2);

        // Verify pagination metadata
        expect(page1Response.page, equals(1), reason: 'First response should be page 1');
        expect(page2Response.page, equals(2), reason: 'Second response should be page 2');
        expect(page2Response.totalPages, greaterThan(1), reason: 'Should have more than 1 page of results');
        expect(page2Response.totalResults, greaterThan(page1Response.results.length), 
               reason: 'Total results should be greater than page 1 results');

        // Verify different results
        final page1Ids = page1Response.results.map((tv) => tv.id).toSet();
        final page2Ids = page2Response.results.map((tv) => tv.id).toSet();
        
        expect(page2Ids.intersection(page1Ids), isEmpty, 
               reason: 'Page 2 should have different TV shows from page 1');
      }, timeout: const Timeout(Duration(seconds: 30)));
    });

    group('getAiringToday', () {
      test('returns paginated response with valid TV shows airing today', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final response = await tvService.getAiringToday();

        // Validate paginated response structure
        IntegrationTestHelper.validatePaginatedResponse(
          response,
          expectedPage: 1,
        );

        // Verify TV show data presence
        for (final tvShow in response.results) {
          IntegrationTestHelper.validateCommonEntityProperties(
            tvShow,
            tvShow.name,
          );
          expect(tvShow.firstAirDate, isNotNull, reason: 'Airing today TV show should have a first air date');
        }
      }, timeout: const Timeout(Duration(seconds: 30)));
    });

    group('getTopRated', () {
      test('returns TV shows sorted by rating', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final response = await tvService.getTopRated();

        // Validate paginated response structure
        IntegrationTestHelper.validatePaginatedResponse(
          response,
          expectedPage: 1,
          minResults: 1,
        );

        // Verify results are not empty
        expect(response.results, isNotEmpty, reason: 'Top rated TV shows list should not be empty');

        // Verify high vote averages
        for (final tvShow in response.results.take(5)) {
          expect(tvShow.voteAverage, greaterThan(7.0), 
                 reason: 'Top rated TV shows should have high vote averages (> 7.0)');
          expect(tvShow.voteCount, greaterThan(100), 
                 reason: 'Top rated TV shows should have sufficient vote counts (> 100)');
        }

        // Verify sorting (first TV show should have high rating)
        expect(response.results.first.voteAverage, greaterThan(8.0), 
               reason: 'First TV show in top rated should have very high rating (> 8.0)');
      }, timeout: const Timeout(Duration(seconds: 30)));
    });

    group('getCredits', () {
      test('returns valid credits for Breaking Bad', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final credits = await tvService.getCredits(KnownTestIds.breakingBad);

        // Verify credits structure
        expect(credits.id, equals(KnownTestIds.breakingBad), reason: 'Credits ID should match TV show ID');
        expect(credits.cast, isNotEmpty, reason: 'TV show should have cast members');
        expect(credits.crew, isNotEmpty, reason: 'TV show should have crew members');

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

        // Verify key people for Breaking Bad
        final creator = credits.crew.firstWhere(
          (crew) => crew.job.toLowerCase() == 'creator',
          orElse: () => throw Exception('Creator not found'),
        );
        expect(creator.name, equals('Vince Gilligan'), reason: 'Vince Gilligan should be the creator');
      }, timeout: const Timeout(Duration(seconds: 30)));
    });

    group('getSeasonDetails', () {
      test('returns valid season details for Breaking Bad Season 1', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        const seasonNumber = 1;
        final season = await tvService.getSeasonDetails(KnownTestIds.breakingBad, seasonNumber);

        // Verify season details
        expect(season.id, equals(KnownTestIds.breakingBad), reason: 'Season ID should match TV show ID');
        expect(season.seasonNumber, equals(seasonNumber), reason: 'Season number should match requested season');
        expect(season.name, isNotEmpty, reason: 'Season should have a name');
        expect(season.episodes, isNotEmpty, reason: 'Season should have episodes');

        // Verify episode structure
        if (season.episodes != null) {
          for (final episode in season.episodes!.take(5)) {
            expect(episode.id, greaterThan(0), reason: 'Episode should have valid ID');
            expect(episode.name, isNotEmpty, reason: 'Episode should have a name');
            expect(episode.episodeNumber, greaterThan(0), reason: 'Episode should have a valid episode number');
            expect(episode.seasonNumber, equals(seasonNumber), reason: 'Episode season number should match season');
          }
        }

        // Verify specific details for Breaking Bad Season 1
        expect(season.name, contains('Season 1'), reason: 'Season name should contain "Season 1"');
        expect(season.episodeCount, greaterThan(0), reason: 'Season 1 should have episodes');
        if (season.episodes != null) {
          expect(season.episodes!.length, greaterThan(0), reason: 'Season 1 should have episodes');
        }
      }, timeout: const Timeout(Duration(seconds: 30)));
    });

    group('getEpisodeDetails', () {
      test('returns valid episode details for Breaking Bad S1E1', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        const seasonNumber = 1;
        const episodeNumber = 1;
        final episode = await tvService.getEpisodeDetails(
          KnownTestIds.breakingBad, 
          seasonNumber, 
          episodeNumber
        );

        // Verify episode details
        expect(episode.id, greaterThan(0), reason: 'Episode should have valid ID');
        expect(episode.name, isNotEmpty, reason: 'Episode should have a name');
        expect(episode.overview, isNotEmpty, reason: 'Episode should have an overview');
        expect(episode.airDate, isNotNull, reason: 'Episode should have an air date');
        expect(episode.seasonNumber, equals(seasonNumber), reason: 'Episode season number should match requested season');
        expect(episode.episodeNumber, equals(episodeNumber), reason: 'Episode number should match requested episode');

        // Verify specific details for Breaking Bad S1E1
        expect(episode.name, equals('Pilot'), reason: 'First episode should be "Pilot"');
        expect(episode.seasonNumber, equals(1), reason: 'Should be season 1');
        expect(episode.episodeNumber, equals(1), reason: 'Should be episode 1');
      }, timeout: const Timeout(Duration(seconds: 30)));
    });

    group('getImages', () {
      test('returns valid images for Breaking Bad', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final images = await tvService.getImages(KnownTestIds.breakingBad);

        // Verify images are not empty
        expect(images, isNotEmpty, reason: 'TV show should have images');

        // Verify image types
        // TmdbImage doesn't have imageType property, so we'll check if we have different image types
        // by checking the aspect ratios which typically differ between posters, backdrops, and logos
        final hasWideImages = images.any((img) => img.aspectRatio != null && img.aspectRatio! > 1.5);
        final hasTallImages = images.any((img) => img.aspectRatio != null && img.aspectRatio! < 1.0);

        expect(hasWideImages, isTrue, reason: 'TV show should have wide images (backdrops)');
        expect(hasTallImages, isTrue, reason: 'TV show should have tall images (posters)');
        // Logos might not always be present, so we don't require them

        // Verify image paths
        for (final image in images.take(5)) {
          IntegrationTestHelper.validateImagePath(image.filePath);
          expect(image.aspectRatio, greaterThan(0), reason: 'Image should have positive aspect ratio');
        }
      }, timeout: const Timeout(Duration(seconds: 30)));
    });

    group('getVideos', () {
      test('returns valid videos for Breaking Bad', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final videos = await tvService.getVideos(KnownTestIds.breakingBad);

        // Verify videos list is not empty
        expect(videos, isNotEmpty, reason: 'TV show should have videos');

        // Verify video properties
        for (final video in videos.take(5)) {
          expect(video.key, isNotEmpty, reason: 'Video should have a key');
          expect(video.site, isNotEmpty, reason: 'Video should have a site (e.g., YouTube)');
          expect(video.type, isNotEmpty, reason: 'Video should have a type (e.g., Trailer)');
          expect(video.name, isNotEmpty, reason: 'Video should have a name');
        }

        // Verify at least one trailer exists
        final hasTrailer = videos.any((v) => v.type.toLowerCase() == 'trailer');
        expect(hasTrailer, isTrue, reason: 'TV show should have at least one trailer');
      }, timeout: const Timeout(Duration(seconds: 30)));
    });

    // Optional tests (MEDIUM PRIORITY)
    group('getOnTheAir', () {
      test('returns valid currently airing TV shows', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final response = await tvService.getOnTheAir();

        // Validate paginated response structure
        IntegrationTestHelper.validatePaginatedResponse(
          response,
          expectedPage: 1,
        );

        // Verify TV show data presence
        for (final tvShow in response.results) {
          IntegrationTestHelper.validateCommonEntityProperties(
            tvShow,
            tvShow.name,
          );
          expect(tvShow.firstAirDate, isNotNull, reason: 'On the air TV show should have a first air date');
        }
      }, timeout: const Timeout(Duration(seconds: 30)));
    });

    group('getReviews', () {
      test('returns valid reviews for Breaking Bad', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final response = await tvService.getReviews(KnownTestIds.breakingBad);

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
      test('returns valid keywords for Breaking Bad', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final keywords = await tvService.getKeywords(KnownTestIds.breakingBad);

        // Verify keywords are not empty
        expect(keywords, isNotEmpty, reason: 'TV show should have keywords');

        // Verify keyword structure
        for (final keyword in keywords.take(5)) {
          expect(keyword.id, greaterThan(0), reason: 'Keyword should have valid ID');
          expect(keyword.name, isNotEmpty, reason: 'Keyword should have a name');
        }

        // Verify expected keywords for Breaking Bad
        final keywordNames = keywords.map((k) => k.name.toLowerCase()).toList();
        expect(keywordNames, contains('drugs'), reason: 'Breaking Bad should have "drugs" keyword');
        expect(keywordNames, contains('crime'), reason: 'Breaking Bad should have "crime" keyword');
      }, timeout: const Timeout(Duration(seconds: 30)));
    });

    group('getSimilar', () {
      test('returns valid similar TV shows for Breaking Bad', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final response = await tvService.getSimilar(KnownTestIds.breakingBad);

        // Validate paginated response structure
        IntegrationTestHelper.validatePaginatedResponse(response);

        // Verify similar TV shows are not the same show
        for (final tvShow in response.results) {
          expect(tvShow.id, isNot(equals(KnownTestIds.breakingBad)), 
                 reason: 'Similar TV shows should not include the original TV show');
        }

        // Verify at least some similar TV shows exist
        expect(response.results.length, greaterThan(0), reason: 'Should have at least one similar TV show');
      }, timeout: const Timeout(Duration(seconds: 30)));
    });

    group('getRecommendations', () {
      test('returns valid recommended TV shows for Breaking Bad', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final response = await tvService.getRecommendations(KnownTestIds.breakingBad);

        // Validate paginated response structure
        IntegrationTestHelper.validatePaginatedResponse(response);

        // Verify recommendations are not the same show
        for (final tvShow in response.results) {
          expect(tvShow.id, isNot(equals(KnownTestIds.breakingBad)), 
                 reason: 'Recommended TV shows should not include the original TV show');
        }

        // Verify at least some recommendations exist
        expect(response.results.length, greaterThan(0), reason: 'Should have at least one recommendation');
      }, timeout: const Timeout(Duration(seconds: 30)));
    });

    group('getExternalIds', () {
      test('returns valid external IDs for Breaking Bad', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final externalIds = await tvService.getExternalIds(KnownTestIds.breakingBad);

        // Verify external IDs structure
        // ExternalIds doesn't have an id property, so we'll just verify it has content
        expect(externalIds.imdbId, isNotEmpty, reason: 'TV show should have an IMDB ID');
      }, timeout: const Timeout(Duration(seconds: 30)));
    });

    group('getWatchProviders', () {
      test('returns valid watch providers for Breaking Bad', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final watchProviders = await tvService.getWatchProviders(KnownTestIds.breakingBad);

        // Verify watch providers structure
        // WatchProvidersResult doesn't have an id property, so we'll just verify it has content
        expect(watchProviders.results, isNotEmpty, reason: 'Should have watch providers for at least one region');
      }, timeout: const Timeout(Duration(seconds: 30)));
    });

    group('getAlternativeTitles', () {
      test('returns valid alternative titles for Breaking Bad', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final titles = await tvService.getAlternativeTitles(KnownTestIds.breakingBad);

        // Verify alternative titles structure
        expect(titles, isNotEmpty, reason: 'TV show should have alternative titles');
        
        // Verify title format
        for (final entry in titles.entries.take(5)) {
          expect(entry.key, isNotEmpty, reason: 'Country code should not be empty');
          expect(entry.value, isNotEmpty, reason: 'Alternative title should not be empty');
        }
      }, timeout: const Timeout(Duration(seconds: 30)));
    });

    group('getContentRatings', () {
      test('returns valid content ratings for Breaking Bad', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final ratings = await tvService.getContentRatings(KnownTestIds.breakingBad);

        // Verify content ratings structure
        expect(ratings, isNotEmpty, reason: 'TV show should have content ratings');
        
        // Verify rating format
        for (final rating in ratings.take(5)) {
          expect(rating['iso_3166_1'], isNotEmpty, reason: 'Country code should not be empty');
          expect(rating['rating'], isNotEmpty, reason: 'Rating should not be empty');
        }
      }, timeout: const Timeout(Duration(seconds: 30)));
    });

    group('getSeasonCredits', () {
      test('returns valid season credits for Breaking Bad Season 1', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        const seasonNumber = 1;
        final credits = await tvService.getSeasonCredits(KnownTestIds.breakingBad, seasonNumber);

        // Verify credits structure
        expect(credits.id, equals(KnownTestIds.breakingBad), reason: 'Credits ID should match TV show ID');
        
        // Season credits might have cast or crew, but not necessarily both
        if (credits.cast.isNotEmpty) {
          for (final castMember in credits.cast.take(3)) {
            expect(castMember.id, greaterThan(0), reason: 'Cast member should have valid ID');
            expect(castMember.name, isNotEmpty, reason: 'Cast member should have a name');
            expect(castMember.character, isNotEmpty, reason: 'Cast member should have a character');
          }
        }
        
        if (credits.crew.isNotEmpty) {
          for (final crewMember in credits.crew.take(3)) {
            expect(crewMember.id, greaterThan(0), reason: 'Crew member should have valid ID');
            expect(crewMember.name, isNotEmpty, reason: 'Crew member should have a name');
            expect(crewMember.job, isNotEmpty, reason: 'Crew member should have a job');
            expect(crewMember.department, isNotEmpty, reason: 'Crew member should have a department');
          }
        }
      }, timeout: const Timeout(Duration(seconds: 30)));
    });

    group('getEpisodeCredits', () {
      test('returns valid episode credits for Breaking Bad S1E1', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        const seasonNumber = 1;
        const episodeNumber = 1;
        final credits = await tvService.getEpisodeCredits(
          KnownTestIds.breakingBad, 
          seasonNumber, 
          episodeNumber
        );

        // Verify credits structure
        expect(credits.id, equals(KnownTestIds.breakingBad), reason: 'Credits ID should match TV show ID');
        
        // Episode credits might have cast or crew, but not necessarily both
        if (credits.cast.isNotEmpty) {
          for (final castMember in credits.cast.take(3)) {
            expect(castMember.id, greaterThan(0), reason: 'Cast member should have valid ID');
            expect(castMember.name, isNotEmpty, reason: 'Cast member should have a name');
            expect(castMember.character, isNotEmpty, reason: 'Cast member should have a character');
          }
        }
        
        if (credits.crew.isNotEmpty) {
          for (final crewMember in credits.crew.take(3)) {
            expect(crewMember.id, greaterThan(0), reason: 'Crew member should have valid ID');
            expect(crewMember.name, isNotEmpty, reason: 'Crew member should have a name');
            expect(crewMember.job, isNotEmpty, reason: 'Crew member should have a job');
            expect(crewMember.department, isNotEmpty, reason: 'Crew member should have a department');
          }
        }
      }, timeout: const Timeout(Duration(seconds: 30)));
    });
  });
}