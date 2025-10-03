import '../core/api_client.dart';
import '../models/configuration/api_configuration.dart';
import '../models/configuration/country.dart';
import '../models/configuration/language.dart';
import '../models/common/genre.dart';
import '../utils/query_parameters.dart';

/// Service for fetching configuration data from the TMDB API
class ConfigurationService {
  final ApiClient _apiClient;

  /// Creates a new [ConfigurationService] with the provided [ApiClient]
  ConfigurationService(this._apiClient);

  /// Gets the API configuration
  ///
  /// Returns information about the API configuration, including image URLs
  ///
  /// Throws an [ApiException] if the request fails
  Future<ApiConfiguration> getApiConfiguration() async {
    final response = await _apiClient.get('/configuration');
    return ApiConfiguration.fromJson(response);
  }

  /// Gets the list of movie genres
  ///
  /// [language] is the ISO 639-1 language code to get the genres in
  ///
  /// Returns a list of movie genres
  ///
  /// Throws an [ApiException] if the request fails
  Future<List<Genre>> getMovieGenres({String? language}) async {
    final params = QueryParameters.buildCommonParams(language: language);
    final response =
        await _apiClient.get('/genre/movie/list', queryParameters: params);

    final List<dynamic> genresList = response['genres'];
    return genresList.map((genre) => Genre.fromJson(genre)).toList();
  }

  /// Gets the list of TV genres
  ///
  /// [language] is the ISO 639-1 language code to get the genres in
  ///
  /// Returns a list of TV genres
  ///
  /// Throws an [ApiException] if the request fails
  Future<List<Genre>> getTvGenres({String? language}) async {
    final params = QueryParameters.buildCommonParams(language: language);
    final response =
        await _apiClient.get('/genre/tv/list', queryParameters: params);

    final List<dynamic> genresList = response['genres'];
    return genresList.map((genre) => Genre.fromJson(genre)).toList();
  }

  /// Gets the list of countries
  ///
  /// Returns a list of countries with their ISO 3166-1 codes
  ///
  /// Throws an [ApiException] if the request fails
  Future<List<Country>> getCountries() async {
    final response = await _apiClient.get('/configuration/countries');

    // The response is a Map, but we need to extract the list of countries
    // Since the API returns a list directly, we need to handle this case
    // If it's a map, try to find a list in it
    for (final value in response.values) {
      if (value is List) {
        return value.map((country) => Country.fromJson(country)).toList();
      }
    }

    // If we can't find a list, return an empty list
    return [];
  }

  /// Gets the list of languages
  ///
  /// Returns a list of languages supported by TMDB
  ///
  /// Throws an [ApiException] if the request fails
  Future<List<Language>> getLanguages() async {
    final response = await _apiClient.get('/configuration/languages');

    // The response is a Map, but we need to extract the list of languages
    // Since the API returns a list directly, we need to handle this case
    // If it's a map, try to find a list in it
    for (final value in response.values) {
      if (value is List) {
        return value.map((language) => Language.fromJson(language)).toList();
      }
    }

    // If we can't find a list, return an empty list
    return [];
  }

  /// Gets the list of jobs
  ///
  /// Returns a list of jobs available in the TMDB database
  ///
  /// Throws an [ApiException] if the request fails
  Future<List<String>> getJobs() async {
    final response = await _apiClient.get('/configuration/jobs');

    // The response is a Map, but we need to extract the list of jobs
    // Since the API returns a list directly, we need to handle this case
    // If it's a map, try to find a list in it
    for (final value in response.values) {
      if (value is List) {
        return value.map((job) => job.toString()).toList();
      }
    }

    // If we can't find a list, return an empty list
    return [];
  }

  /// Gets the list of timezones
  ///
  /// Returns a list of timezones available in the TMDB database
  ///
  /// Throws an [ApiException] if the request fails
  Future<List<String>> getTimezones() async {
    final response = await _apiClient.get('/configuration/timezones');

    // The response is a nested structure, we need to extract all timezones
    final List<String> timezones = [];

    for (final value in response.values) {
      if (value is List) {
        for (final country in value) {
          if (country is Map<String, dynamic>) {
            for (final entry in country.values) {
              if (entry is List) {
                for (final timezone in entry) {
                  timezones.add(timezone.toString());
                }
              }
            }
          }
        }
      }
    }

    return timezones;
  }

  /// Gets the list of primary translations
  ///
  /// Returns a list of primary translations available in the TMDB database
  ///
  /// Throws an [ApiException] if the request fails
  Future<List<String>> getPrimaryTranslations() async {
    final response =
        await _apiClient.get('/configuration/primary_translations');

    // The response is a Map, but we need to extract the list of translations
    // Since the API returns a list directly, we need to handle this case
    // If it's a map, try to find a list in it
    for (final value in response.values) {
      if (value is List) {
        return value.map((translation) => translation.toString()).toList();
      }
    }

    // If we can't find a list, return an empty list
    return [];
  }
}
