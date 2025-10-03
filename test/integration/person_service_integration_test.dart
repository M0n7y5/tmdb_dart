import 'package:test/test.dart';
import 'package:tmdb_dart/tmdb_dart.dart';

import 'config/integration_test_config.dart';
import 'helpers/integration_test_helper.dart';
import 'helpers/known_test_ids.dart';

/// Integration tests for the PersonService.
///
/// These tests validate the PersonService methods against the real TMDB API.
/// They require a valid TMDB API key to run.
@Tags(['integration'])
void main() {
  group('PersonService Integration Tests', () {
    late TmdbClient client;
    late PersonService personService;

    // Set up the test client before running tests
    setUpAll(() {
      // Skip all tests if no API key is provided
      if (!IntegrationTestConfig.hasApiKey) {
        print(IntegrationTestConfig.skipMessage);
        return;
      }
      
      client = IntegrationTestConfig.createClient();
      personService = client.people;
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
      test('returns valid person details for Tom Hanks', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final person = await personService.getDetails(KnownTestIds.tomHanks);

        // Verify required fields
        expect(person.id, equals(KnownTestIds.tomHanks), reason: 'Person ID should match requested ID');
        expect(person.name, equals('Tom Hanks'), reason: 'Person name should be Tom Hanks');
        expect(person.biography, isNotEmpty, reason: 'Person biography should not be empty');
        expect(person.birthday, isNotNull, reason: 'Person should have a birthday');
        expect(person.placeOfBirth, isNotNull, reason: 'Person should have a place of birth');
        
        // Verify other important fields
        expect(person.popularity, greaterThan(0), reason: 'Person popularity should be greater than 0');
        expect(person.adult, isA<bool>(), reason: 'Adult field should be a boolean');
        
        // Verify known fact: Tom Hanks' birthday
        expect(person.birthday!.year, equals(1956), reason: 'Tom Hanks should be born in 1956');
        expect(person.birthday!.month, equals(7), reason: 'Tom Hanks should be born in July');
        expect(person.birthday!.day, equals(9), reason: 'Tom Hanks should be born on July 9th');
      }, timeout: const Timeout(Duration(seconds: 30)));

      test('throws TmdbNotFoundException for invalid person ID', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        // Use an ID that's very unlikely to exist
        const invalidPersonId = 999999999;

        expect(
          () => personService.getDetails(invalidPersonId),
          throwsA(isA<TmdbNotFoundException>()),
          reason: 'Should throw TmdbNotFoundException for invalid person ID',
        );
      }, timeout: const Timeout(Duration(seconds: 30)));
    });

    group('getPopular', () {
      test('returns paginated response with valid popular people', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final response = await personService.getPopular();

        // Validate paginated response structure
        IntegrationTestHelper.validatePaginatedResponse(
          response,
          expectedPage: 1,
          minResults: 1,
        );

        // Verify results are not empty
        expect(response.results, isNotEmpty, reason: 'Popular people list should not be empty');

        // Verify first person has proper structure
        final firstPerson = response.results.first;
        IntegrationTestHelper.validateCommonEntityProperties(
          firstPerson,
          firstPerson.name,
        );
        expect(firstPerson.popularity, greaterThan(0), reason: 'Person popularity should be greater than 0');
        expect(firstPerson.adult, isA<bool>(), reason: 'Adult field should be a boolean');
        
        // Verify profile path if present
        if (firstPerson.profilePath != null) {
          IntegrationTestHelper.validateImagePath(firstPerson.profilePath);
        }
      }, timeout: const Timeout(Duration(seconds: 30)));

      test('returns different results for page 2', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final page1Response = await personService.getPopular(page: 1);
        await IntegrationTestHelper.addRateLimitDelay();
        final page2Response = await personService.getPopular(page: 2);

        // Verify pagination metadata
        expect(page1Response.page, equals(1), reason: 'First response should be page 1');
        expect(page2Response.page, equals(2), reason: 'Second response should be page 2');
        expect(page2Response.totalPages, greaterThan(1), reason: 'Should have more than 1 page of results');
        expect(page2Response.totalResults, greaterThan(page1Response.results.length), 
               reason: 'Total results should be greater than page 1 results');

        // Verify different results
        final page1Ids = page1Response.results.map((p) => p.id).toSet();
        final page2Ids = page2Response.results.map((p) => p.id).toSet();
        
        expect(page2Ids.intersection(page1Ids), isEmpty, 
               reason: 'Page 2 should have different people from page 1');
      }, timeout: const Timeout(Duration(seconds: 30)));
    });

    group('getCombinedCredits', () {
      test('returns valid combined credits for Tom Hanks', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final credits = await personService.getCombinedCredits(KnownTestIds.tomHanks);

        // Verify credits structure
        expect(credits.id, equals(KnownTestIds.tomHanks), reason: 'Credits ID should match person ID');
        expect(credits.cast, isNotEmpty, reason: 'Person should have cast credits');
        expect(credits.crew, isNotEmpty, reason: 'Person should have crew credits');

        // Verify cast structure
        for (final castCredit in credits.cast.take(5)) {
          expect(castCredit.id, greaterThan(0), reason: 'Cast credit should have valid ID');
          expect(castCredit.character, isNotEmpty, reason: 'Cast credit should have a character');
          expect(castCredit.creditId, isNotEmpty, reason: 'Cast credit should have a credit ID');
          expect(castCredit.mediaType, isIn(['movie', 'tv']), reason: 'Media type should be movie or tv');
          
          // Verify movie or TV specific fields
          if (castCredit.mediaType == 'movie') {
            expect(castCredit.title, isNotNull, reason: 'Movie credit should have a title');
          } else {
            expect(castCredit.name, isNotNull, reason: 'TV credit should have a name');
          }
        }

        // Verify crew structure
        for (final crewCredit in credits.crew.take(5)) {
          expect(crewCredit.id, greaterThan(0), reason: 'Crew credit should have valid ID');
          expect(crewCredit.job, isNotEmpty, reason: 'Crew credit should have a job');
          expect(crewCredit.department, isNotEmpty, reason: 'Crew credit should have a department');
          expect(crewCredit.creditId, isNotEmpty, reason: 'Crew credit should have a credit ID');
          expect(crewCredit.mediaType, isIn(['movie', 'tv']), reason: 'Media type should be movie or tv');
        }

        // Verify Tom Hanks has many cast credits (he's a prolific actor)
        expect(credits.cast.length, greaterThan(50), reason: 'Tom Hanks should have many cast credits');

        // Check for both movie and TV credits
        final hasMovieCredits = credits.cast.any((credit) => credit.mediaType == 'movie');
        final hasTvCredits = credits.cast.any((credit) => credit.mediaType == 'tv');
        expect(hasMovieCredits, isTrue, reason: 'Tom Hanks should have movie credits');
        expect(hasTvCredits, isTrue, reason: 'Tom Hanks should have TV credits');
      }, timeout: const Timeout(Duration(seconds: 30)));
    });

    group('getMovieCredits', () {
      test('returns valid movie credits for Tom Hanks', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final credits = await personService.getMovieCredits(KnownTestIds.tomHanks);

        // Verify credits structure
        expect(credits.id, equals(KnownTestIds.tomHanks), reason: 'Credits ID should match person ID');
        expect(credits.cast, isNotEmpty, reason: 'Person should have movie cast credits');

        // Verify cast structure
        for (final castCredit in credits.cast.take(5)) {
          expect(castCredit.id, greaterThan(0), reason: 'Cast credit should have valid ID');
          expect(castCredit.title, isNotNull, reason: 'Movie credit should have a title');
          expect(castCredit.character, isNotEmpty, reason: 'Cast credit should have a character');
          expect(castCredit.creditId, isNotEmpty, reason: 'Cast credit should have a credit ID');
          expect(castCredit.releaseDate, isNotNull, reason: 'Movie credit should have a release date');
        }

        // Verify Tom Hanks has many movie credits
        expect(credits.cast.length, greaterThan(40), reason: 'Tom Hanks should have many movie credits');

        // Check for known movies
        final forrestGump = credits.cast.firstWhere(
          (credit) => credit.title?.toLowerCase().contains('forrest gump') == true,
          orElse: () => throw Exception('Forrest Gump not found in credits'),
        );
        expect(forrestGump.character, isNotEmpty, reason: 'Forrest Gump credit should have a character');
      }, timeout: const Timeout(Duration(seconds: 30)));
    });

    group('getTvCredits', () {
      test('returns valid TV credits for Tom Hanks', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final credits = await personService.getTvCredits(KnownTestIds.tomHanks);

        // Verify credits structure
        expect(credits.id, equals(KnownTestIds.tomHanks), reason: 'Credits ID should match person ID');
        expect(credits.cast, isNotEmpty, reason: 'Person should have TV cast credits');

        // Verify cast structure
        for (final castCredit in credits.cast.take(5)) {
          expect(castCredit.id, greaterThan(0), reason: 'Cast credit should have valid ID');
          expect(castCredit.name, isNotNull, reason: 'TV credit should have a name');
          expect(castCredit.character, isNotEmpty, reason: 'Cast credit should have a character');
          expect(castCredit.creditId, isNotEmpty, reason: 'Cast credit should have a credit ID');
          expect(castCredit.firstAirDate, isNotNull, reason: 'TV credit should have a first air date');
        }

        // Tom Hanks may have fewer TV credits than movie credits
        expect(credits.cast.length, greaterThan(0), reason: 'Tom Hanks should have some TV credits');
      }, timeout: const Timeout(Duration(seconds: 30)));
    });

    group('getImages', () {
      test('returns valid images for Tom Hanks', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final images = await personService.getImages(KnownTestIds.tomHanks);

        // Verify images are not empty
        expect(images, isNotEmpty, reason: 'Person should have profile images');

        // Verify image properties
        for (final image in images.take(5)) {
          IntegrationTestHelper.validateImagePath(image.filePath);
          expect(image.aspectRatio, greaterThan(0), reason: 'Image should have positive aspect ratio');
        }

        // Verify we have different aspect ratios (portrait and landscape)
        final hasPortraitImages = images.any((img) => img.aspectRatio != null && img.aspectRatio! < 1.0);
        final hasLandscapeImages = images.any((img) => img.aspectRatio != null && img.aspectRatio! > 1.0);
        
        expect(hasPortraitImages, isTrue, reason: 'Person should have portrait profile images');
      }, timeout: const Timeout(Duration(seconds: 30)));
    });

    group('getExternalIds', () {
      test('returns valid external IDs for Tom Hanks', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final externalIds = await personService.getExternalIds(KnownTestIds.tomHanks);

        // Verify external IDs structure
        expect(externalIds.imdbId, isNotNull, reason: 'Person should have an IMDB ID');
        expect(externalIds.imdbId, startsWith('nm'), reason: 'IMDB ID should start with "nm"');
        
        // Tom Hanks' known IMDB ID
        expect(externalIds.imdbId, equals('nm0000158'), reason: 'Tom Hanks should have the correct IMDB ID');

        // Social media IDs may or may not be present, but if they are, they should not be empty
        if (externalIds.facebookId != null) {
          expect(externalIds.facebookId, isNotEmpty, reason: 'Facebook ID should not be empty if present');
        }
        
        if (externalIds.instagramId != null) {
          expect(externalIds.instagramId, isNotEmpty, reason: 'Instagram ID should not be empty if present');
        }
        
        if (externalIds.twitterId != null) {
          expect(externalIds.twitterId, isNotEmpty, reason: 'Twitter ID should not be empty if present');
        }
        
        if (externalIds.wikidataId != null) {
          expect(externalIds.wikidataId, isNotEmpty, reason: 'Wikidata ID should not be empty if present');
        }
      }, timeout: const Timeout(Duration(seconds: 30)));
    });
  });
}