import 'dart:async';

import '../core/api_client.dart';
import '../models/common/keyword.dart';
import '../models/common/paginated_response.dart';
import '../models/movie/movie_short.dart';
import '../models/person/person_short.dart';
import '../models/tv/tv_show_short.dart';
import '../utils/query_parameters.dart';

/// Service for interacting with the TMDB Search API endpoints
class SearchService {
  final ApiClient _apiClient;

  /// Creates a new [SearchService] instance
  ///
  /// [_apiClient] is the API client for making HTTP requests
  SearchService(this._apiClient);

  /// Searches for movies based on a query
  ///
  /// [query] is the search query (required)
  /// [language] is the ISO 639-1 language code (e.g., 'en-US')
  /// [page] is the page number to retrieve (default: 1)
  /// [includeAdult] whether to include adult content in the results (default: false)
  /// [region] is the ISO 3166-1 region code (e.g., 'US')
  /// [year] is the release year to filter by
  /// [primaryReleaseYear] is the primary release year to filter by
  ///
  /// Returns a [PaginatedResponse] of [MovieShort] objects
  Future<PaginatedResponse<MovieShort>> searchMovies(
    String query, {
    String? language,
    int page = 1,
    bool includeAdult = false,
    String? region,
    int? year,
    int? primaryReleaseYear,
  }) async {
    final params = _buildSearchParams(
      query,
      language: language,
      page: page,
      includeAdult: includeAdult,
      region: region,
    );

    if (year != null) params['year'] = year.toString();
    if (primaryReleaseYear != null)
      params['primary_release_year'] = primaryReleaseYear.toString();

    final response = await _apiClient.get(
      '/search/movie',
      queryParameters: QueryParameters.cleanNullParams(params),
    );

    return PaginatedResponse.fromJson(
      response,
      (json) => MovieShort.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Searches for TV shows based on a query
  ///
  /// [query] is the search query (required)
  /// [language] is the ISO 639-1 language code (e.g., 'en-US')
  /// [page] is the page number to retrieve (default: 1)
  /// [includeAdult] whether to include adult content in the results (default: false)
  /// [firstAirDateYear] is the first air date year to filter by
  ///
  /// Returns a [PaginatedResponse] of [TvShowShort] objects
  Future<PaginatedResponse<TvShowShort>> searchTvShows(
    String query, {
    String? language,
    int page = 1,
    bool includeAdult = false,
    int? firstAirDateYear,
  }) async {
    final params = _buildSearchParams(
      query,
      language: language,
      page: page,
      includeAdult: includeAdult,
    );

    if (firstAirDateYear != null)
      params['first_air_date_year'] = firstAirDateYear.toString();

    final response = await _apiClient.get(
      '/search/tv',
      queryParameters: QueryParameters.cleanNullParams(params),
    );

    return PaginatedResponse.fromJson(
      response,
      (json) => TvShowShort.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Searches for people based on a query
  ///
  /// [query] is the search query (required)
  /// [language] is the ISO 639-1 language code (e.g., 'en-US')
  /// [page] is the page number to retrieve (default: 1)
  /// [includeAdult] whether to include adult content in the results (default: false)
  ///
  /// Returns a [PaginatedResponse] of [PersonShort] objects
  Future<PaginatedResponse<PersonShort>> searchPeople(
    String query, {
    String? language,
    int page = 1,
    bool includeAdult = false,
  }) async {
    final params = _buildSearchParams(
      query,
      language: language,
      page: page,
      includeAdult: includeAdult,
    );

    final response = await _apiClient.get(
      '/search/person',
      queryParameters: QueryParameters.cleanNullParams(params),
    );

    return PaginatedResponse.fromJson(
      response,
      (json) => PersonShort.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Searches for multiple types of content (movies, TV shows, people) based on a query
  ///
  /// [query] is the search query (required)
  /// [language] is the ISO 639-1 language code (e.g., 'en-US')
  /// [page] is the page number to retrieve (default: 1)
  /// [includeAdult] whether to include adult content in the results (default: false)
  ///
  /// Returns a [PaginatedResponse] of dynamic objects (can be Movie, TvShow, or Person)
  Future<PaginatedResponse<dynamic>> searchMulti(
    String query, {
    String? language,
    int page = 1,
    bool includeAdult = false,
  }) async {
    final params = _buildSearchParams(
      query,
      language: language,
      page: page,
      includeAdult: includeAdult,
    );

    final response = await _apiClient.get(
      '/search/multi',
      queryParameters: QueryParameters.cleanNullParams(params),
    );

    return PaginatedResponse.fromJson(
      response,
      (json) => json, // Return as dynamic for now
    );
  }

  /// Searches for production companies based on a query
  ///
  /// [query] is the search query (required)
  /// [page] is the page number to retrieve (default: 1)
  ///
  /// Returns a [PaginatedResponse] of Map objects containing company information
  Future<PaginatedResponse<Map<String, dynamic>>> searchCompanies(
    String query, {
    int page = 1,
  }) async {
    final params = <String, dynamic>{
      'query': query,
      'page': page.toString(),
    };

    final response = await _apiClient.get(
      '/search/company',
      queryParameters: QueryParameters.cleanNullParams(params),
    );

    return PaginatedResponse.fromJson(
      response,
      (json) => json as Map<String, dynamic>,
    );
  }

  /// Searches for collections based on a query
  ///
  /// [query] is the search query (required)
  /// [language] is the ISO 639-1 language code (e.g., 'en-US')
  /// [page] is the page number to retrieve (default: 1)
  ///
  /// Returns a [PaginatedResponse] of Map objects containing collection information
  Future<PaginatedResponse<Map<String, dynamic>>> searchCollections(
    String query, {
    String? language,
    int page = 1,
  }) async {
    final params = <String, dynamic>{
      'query': query,
      'page': page.toString(),
    };

    if (language != null) params['language'] = language;

    final response = await _apiClient.get(
      '/search/collection',
      queryParameters: QueryParameters.cleanNullParams(params),
    );

    return PaginatedResponse.fromJson(
      response,
      (json) => json as Map<String, dynamic>,
    );
  }

  /// Searches for keywords based on a query
  ///
  /// [query] is the search query (required)
  /// [page] is the page number to retrieve (default: 1)
  ///
  /// Returns a [PaginatedResponse] of [Keyword] objects
  Future<PaginatedResponse<Keyword>> searchKeywords(
    String query, {
    int page = 1,
  }) async {
    final params = <String, dynamic>{
      'query': query,
      'page': page.toString(),
    };

    final response = await _apiClient.get(
      '/search/keyword',
      queryParameters: QueryParameters.cleanNullParams(params),
    );

    return PaginatedResponse.fromJson(
      response,
      (json) => Keyword.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Builds common search parameters
  ///
  /// [query] is the search query (required)
  /// [language] is the ISO 639-1 language code
  /// [page] is the page number
  /// [includeAdult] whether to include adult content
  /// [region] is the ISO 3166-1 region code
  ///
  /// Returns a map of query parameters
  Map<String, dynamic> _buildSearchParams(
    String query, {
    String? language,
    int? page,
    bool? includeAdult,
    String? region,
  }) {
    final params = <String, dynamic>{
      'query': query,
    };

    if (language != null) params['language'] = language;
    if (page != null) params['page'] = page.toString();
    if (includeAdult != null) params['include_adult'] = includeAdult.toString();
    if (region != null) params['region'] = region;

    return params;
  }
}
