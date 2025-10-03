import 'dart:async';

import '../core/api_client.dart';
import '../models/common/external_ids.dart';
import '../models/common/image.dart';
import '../models/common/paginated_response.dart';
import '../models/person/person.dart';
import '../models/person/person_credits.dart';
import '../models/person/person_short.dart';
import '../utils/query_parameters.dart';

/// Service for interacting with the TMDB Person API endpoints
class PersonService {
  final ApiClient _apiClient;

  /// Creates a new [PersonService] instance
  ///
  /// [_apiClient] is the API client for making HTTP requests
  PersonService(this._apiClient);

  /// Gets the detailed information for a specific person
  ///
  /// [personId] is the ID of the person
  /// [language] is the ISO 639-1 language code (e.g., 'en-US')
  /// [appendToResponse] is a list of additional data to include with the response
  ///
  /// Returns a [Person] object with detailed information
  Future<Person> getDetails(
    int personId, {
    String? language,
    List<String>? appendToResponse,
  }) async {
    final params = QueryParameters.buildCommonParams(language: language);

    if (appendToResponse != null && appendToResponse.isNotEmpty) {
      params.addAll(QueryParameters.buildAppendToResponse(appendToResponse));
    }

    final response = await _apiClient.get(
      '/person/$personId',
      queryParameters: QueryParameters.cleanNullParams(params),
    );

    return Person.fromJson(response);
  }

  /// Gets the list of popular people
  ///
  /// [language] is the ISO 639-1 language code (e.g., 'en-US')
  /// [page] is the page number to retrieve (default: 1)
  ///
  /// Returns a [PaginatedResponse] of [PersonShort] objects
  Future<PaginatedResponse<PersonShort>> getPopular({
    String? language,
    int page = 1,
  }) async {
    final params = QueryParameters.buildCommonParams(
      language: language,
      page: page,
    );

    final response = await _apiClient.get(
      '/person/popular',
      queryParameters: QueryParameters.cleanNullParams(params),
    );

    return PaginatedResponse.fromJson(
      response,
      (json) => PersonShort.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Gets the combined movie and TV credits for a specific person
  ///
  /// [personId] is the ID of the person
  /// [language] is the ISO 639-1 language code (e.g., 'en-US')
  ///
  /// Returns a [PersonCredits] object containing both movie and TV credits
  Future<PersonCredits> getCombinedCredits(
    int personId, {
    String? language,
  }) async {
    final params = QueryParameters.buildCommonParams(language: language);

    final response = await _apiClient.get(
      '/person/$personId/combined_credits',
      queryParameters: QueryParameters.cleanNullParams(params),
    );

    return PersonCredits.fromJson(response);
  }

  /// Gets the movie credits for a specific person
  ///
  /// [personId] is the ID of the person
  /// [language] is the ISO 639-1 language code (e.g., 'en-US')
  ///
  /// Returns a [PersonCredits] object containing only movie credits
  Future<PersonCredits> getMovieCredits(
    int personId, {
    String? language,
  }) async {
    final params = QueryParameters.buildCommonParams(language: language);

    final response = await _apiClient.get(
      '/person/$personId/movie_credits',
      queryParameters: QueryParameters.cleanNullParams(params),
    );

    return PersonCredits.fromJson(response);
  }

  /// Gets the TV credits for a specific person
  ///
  /// [personId] is the ID of the person
  /// [language] is the ISO 639-1 language code (e.g., 'en-US')
  ///
  /// Returns a [PersonCredits] object containing only TV credits
  Future<PersonCredits> getTvCredits(
    int personId, {
    String? language,
  }) async {
    final params = QueryParameters.buildCommonParams(language: language);

    final response = await _apiClient.get(
      '/person/$personId/tv_credits',
      queryParameters: QueryParameters.cleanNullParams(params),
    );

    return PersonCredits.fromJson(response);
  }

  /// Gets the images (profiles) for a specific person
  ///
  /// [personId] is the ID of the person
  ///
  /// Returns a list of [TmdbImage] objects containing profile images
  Future<List<TmdbImage>> getImages(int personId) async {
    final response = await _apiClient.get('/person/$personId/images');

    if (response['profiles'] == null) {
      return [];
    }

    final List<dynamic> profiles = response['profiles'];
    return profiles.map((json) => TmdbImage.fromJson(json)).toList();
  }

  /// Gets the external IDs for a specific person
  ///
  /// [personId] is the ID of the person
  ///
  /// Returns an [ExternalIds] object containing external IDs
  Future<ExternalIds> getExternalIds(int personId) async {
    final response = await _apiClient.get('/person/$personId/external_ids');
    return ExternalIds.fromJson(response);
  }
}
