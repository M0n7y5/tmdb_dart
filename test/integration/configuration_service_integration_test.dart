import 'package:test/test.dart';
import 'package:tmdb_dart/tmdb_dart.dart';

import 'config/integration_test_config.dart';
import 'helpers/integration_test_helper.dart';

/// Integration tests for the ConfigurationService.
///
/// These tests validate the ConfigurationService methods against the real TMDB API.
/// They require a valid TMDB API key to run.
@Tags(['integration'])
void main() {
  group('ConfigurationService Integration Tests', () {
    late TmdbClient client;
    late ConfigurationService configurationService;

    // Set up the test client before running tests
    setUpAll(() {
      // Skip all tests if no API key is provided
      if (!IntegrationTestConfig.hasApiKey) {
        print(IntegrationTestConfig.skipMessage);
        return;
      }
      
      client = IntegrationTestConfig.createClient();
      configurationService = client.configuration;
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

    group('getApiConfiguration', () {
      test('returns valid API configuration with image URLs', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final config = await configurationService.getApiConfiguration();

        // Verify the images configuration is not null
        expect(config.images, isNotNull, reason: 'Images configuration should not be null');
        
        // Verify base URLs are not empty
        expect(config.images.baseUrl, isNotEmpty, reason: 'Base URL should not be empty');
        expect(config.images.secureBaseUrl, isNotEmpty, reason: 'Secure base URL should not be empty');
        
        // Verify base URLs follow TMDB conventions
        expect(config.images.baseUrl, startsWith('http'), reason: 'Base URL should start with http');
        expect(config.images.secureBaseUrl, startsWith('https'), reason: 'Secure base URL should start with https');
        
        // Verify image sizes lists are not empty
        expect(config.images.backdropSizes, isNotEmpty, reason: 'Backdrop sizes should not be empty');
        expect(config.images.logoSizes, isNotEmpty, reason: 'Logo sizes should not be empty');
        expect(config.images.posterSizes, isNotEmpty, reason: 'Poster sizes should not be empty');
        expect(config.images.profileSizes, isNotEmpty, reason: 'Profile sizes should not be empty');
        expect(config.images.stillSizes, isNotEmpty, reason: 'Still sizes should not be empty');
        
        // Verify common image sizes are present
        expect(config.images.posterSizes, contains('w500'), reason: 'Poster sizes should include w500');
        expect(config.images.backdropSizes, contains('w1280'), reason: 'Backdrop sizes should include w1280');
        
        // Verify change keys are not empty
        expect(config.changeKeys, isNotEmpty, reason: 'Change keys should not be empty');
      }, timeout: const Timeout(Duration(seconds: 30)));
    });

    group('getMovieGenres', () {
      test('returns list of movie genres with expected genres', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final genres = await configurationService.getMovieGenres();

        // Verify the list is not empty
        expect(genres, isNotEmpty, reason: 'Movie genres list should not be empty');
        
        // Verify each genre has valid properties
        for (final genre in genres) {
          expect(genre.id, greaterThan(0), reason: 'Genre ID should be greater than 0');
          expect(genre.name, isNotEmpty, reason: 'Genre name should not be empty');
        }
        
        // Verify expected genres are present
        final genreNames = genres.map((g) => g.name.toLowerCase()).toList();
        expect(genreNames, contains('action'), reason: 'Action genre should be present');
        expect(genreNames, contains('drama'), reason: 'Drama genre should be present');
        expect(genreNames, contains('comedy'), reason: 'Comedy genre should be present');
      }, timeout: const Timeout(Duration(seconds: 30)));

      test('returns genres in specified language', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        // Test with Spanish language
        final genresEs = await configurationService.getMovieGenres(language: 'es');
        
        // Verify the list is not empty
        expect(genresEs, isNotEmpty, reason: 'Spanish movie genres list should not be empty');
        
        // Verify at least one genre has a Spanish name
        final hasSpanishName = genresEs.any((g) => g.name != 'Action' && g.name != 'Drama');
        expect(hasSpanishName, isTrue, reason: 'At least one genre should have a Spanish name');
      }, timeout: const Timeout(Duration(seconds: 30)));
    });

    group('getTvGenres', () {
      test('returns list of TV genres with expected genres', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final genres = await configurationService.getTvGenres();

        // Verify the list is not empty
        expect(genres, isNotEmpty, reason: 'TV genres list should not be empty');
        
        // Verify each genre has valid properties
        for (final genre in genres) {
          expect(genre.id, greaterThan(0), reason: 'Genre ID should be greater than 0');
          expect(genre.name, isNotEmpty, reason: 'Genre name should not be empty');
        }
        
        // Verify expected genres are present
        final genreNames = genres.map((g) => g.name.toLowerCase()).toList();
        expect(genreNames, contains('action & adventure'), reason: 'Action & Adventure genre should be present');
        expect(genreNames, contains('drama'), reason: 'Drama genre should be present');
        expect(genreNames, contains('comedy'), reason: 'Comedy genre should be present');
      }, timeout: const Timeout(Duration(seconds: 30)));
    });

    group('getCountries', () {
      test('returns list of countries with expected countries', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final countries = await configurationService.getCountries();

        // Verify the list is not empty
        expect(countries, isNotEmpty, reason: 'Countries list should not be empty');
        
        // Verify each country has valid properties
        for (final country in countries) {
          expect(country.iso31661, isNotEmpty, reason: 'Country ISO code should not be empty');
          expect(country.englishName, isNotEmpty, reason: 'Country English name should not be empty');
        }
        
        // Verify expected countries are present
        final countryCodes = countries.map((c) => c.iso31661).toList();
        expect(countryCodes, contains('US'), reason: 'United States should be present');
        expect(countryCodes, contains('GB'), reason: 'United Kingdom should be present');
        expect(countryCodes, contains('FR'), reason: 'France should be present');
      }, timeout: const Timeout(Duration(seconds: 30)));
    });

    group('getLanguages', () {
      test('returns list of languages', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final languages = await configurationService.getLanguages();

        // Verify the list is not empty
        expect(languages, isNotEmpty, reason: 'Languages list should not be empty');
        
        // Verify each language has valid properties
        for (final language in languages) {
          expect(language.iso6391, isNotEmpty, reason: 'Language ISO code should not be empty');
          expect(language.englishName, isNotEmpty, reason: 'Language English name should not be empty');
          // Native name can be empty for some languages
        }
        
        // Verify expected languages are present
        final languageCodes = languages.map((l) => l.iso6391).toList();
        expect(languageCodes, contains('en'), reason: 'English should be present');
        expect(languageCodes, contains('es'), reason: 'Spanish should be present');
        expect(languageCodes, contains('fr'), reason: 'French should be present');
      }, timeout: const Timeout(Duration(seconds: 30)));
    });

    group('getJobs', () {
      test('returns list of jobs', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final jobs = await configurationService.getJobs();

        // Verify the list is not empty
        expect(jobs, isNotEmpty, reason: 'Jobs list should not be empty');
        
        // Verify each job is a non-empty string
        for (final job in jobs) {
          expect(job, isNotEmpty, reason: 'Job name should not be empty');
        }
        
        // Verify expected jobs are present
        expect(jobs, contains('Actor'), reason: 'Actor should be present');
        expect(jobs, contains('Director'), reason: 'Director should be present');
        expect(jobs, contains('Producer'), reason: 'Producer should be present');
      }, timeout: const Timeout(Duration(seconds: 30)));
    });

    group('getTimezones', () {
      test('returns list of timezones', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final timezones = await configurationService.getTimezones();

        // Verify the list is not empty
        expect(timezones, isNotEmpty, reason: 'Timezones list should not be empty');
        
        // Verify each timezone is a non-empty string
        for (final timezone in timezones) {
          expect(timezone, isNotEmpty, reason: 'Timezone should not be empty');
        }
        
        // Verify expected timezones are present
        expect(timezones, contains('America/New_York'), reason: 'New York timezone should be present');
        expect(timezones, contains('Europe/London'), reason: 'London timezone should be present');
        expect(timezones, contains('Asia/Tokyo'), reason: 'Tokyo timezone should be present');
      }, timeout: const Timeout(Duration(seconds: 30)));
    });

    group('getPrimaryTranslations', () {
      test('returns list of primary translations', () async {
        // Skip test if no API key is provided
        if (!IntegrationTestConfig.hasApiKey) {
          return;
        }

        final translations = await configurationService.getPrimaryTranslations();

        // Verify the list is not empty
        expect(translations, isNotEmpty, reason: 'Primary translations list should not be empty');
        
        // Verify each translation is a non-empty string
        for (final translation in translations) {
          expect(translation, isNotEmpty, reason: 'Translation should not be empty');
          expect(translation.length, equals(5), reason: 'Translation should be a 5-character language code (e.g., en-US)');
        }
        
        // Verify expected translations are present
        expect(translations, contains('en-US'), reason: 'English (US) translation should be present');
        expect(translations, contains('es-ES'), reason: 'Spanish (Spain) translation should be present');
        expect(translations, contains('fr-FR'), reason: 'French (France) translation should be present');
      }, timeout: const Timeout(Duration(seconds: 30)));
    });
  });
}