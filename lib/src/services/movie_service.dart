import 'dart:async';

import '../core/api_client.dart';
import '../models/common/external_ids.dart';
import '../models/common/image.dart';
import '../models/common/keyword.dart';
import '../models/common/paginated_response.dart';
import '../models/common/video.dart';
import '../models/credits/credits.dart';
import '../models/movie/movie.dart';
import '../models/movie/movie_short.dart';
import '../models/review.dart';
import '../models/watch_providers_result.dart';
import '../utils/query_parameters.dart';

/// Service for interacting with the TMDB Movie API endpoints
class MovieService {
  final ApiClient _apiClient;

  /// Creates a new [MovieService] instance
  ///
  /// [_apiClient] is the API client for making HTTP requests
  MovieService(this._apiClient);

  /// Gets the detailed information for a specific movie
  ///
  /// [movieId] is the ID of the movie
  /// [language] is the ISO 639-1 language code (e.g., 'en-US')
  /// [appendToResponse] is a list of additional data to include with the response
  ///
  /// Returns a [Movie] object with detailed information
  Future<Movie> getDetails(
    int movieId, {
    String? language,
    List<String>? appendToResponse,
  }) async {
    final params = QueryParameters.buildCommonParams(language: language);

    if (appendToResponse != null && appendToResponse.isNotEmpty) {
      params.addAll(QueryParameters.buildAppendToResponse(appendToResponse));
    }

    final response = await _apiClient.get(
      '/movie/$movieId',
      queryParameters: QueryParameters.cleanNullParams(params),
    );

    return Movie.fromJson(response);
  }

  /// Gets the list of movies currently in theatres
  ///
  /// [language] is the ISO 639-1 language code (e.g., 'en-US')
  /// [page] is the page number to retrieve (default: 1)
  /// [region] is the ISO 3166-1 region code (e.g., 'US')
  ///
  /// Returns a [PaginatedResponse] of [MovieShort] objects
  Future<PaginatedResponse<MovieShort>> getNowPlaying({
    String? language,
    int page = 1,
    String? region,
  }) async {
    final params = QueryParameters.buildCommonParams(
      language: language,
      page: page,
      region: region,
    );

    final response = await _apiClient.get(
      '/movie/now_playing',
      queryParameters: QueryParameters.cleanNullParams(params),
    );

    return PaginatedResponse.fromJson(
      response,
      (json) => MovieShort.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Gets the list of popular movies
  ///
  /// [language] is the ISO 639-1 language code (e.g., 'en-US')
  /// [page] is the page number to retrieve (default: 1)
  /// [region] is the ISO 3166-1 region code (e.g., 'US')
  ///
  /// Returns a [PaginatedResponse] of [MovieShort] objects
  Future<PaginatedResponse<MovieShort>> getPopular({
    String? language,
    int page = 1,
    String? region,
  }) async {
    final params = QueryParameters.buildCommonParams(
      language: language,
      page: page,
      region: region,
    );

    final response = await _apiClient.get(
      '/movie/popular',
      queryParameters: QueryParameters.cleanNullParams(params),
    );

    return PaginatedResponse.fromJson(
      response,
      (json) => MovieShort.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Gets the list of top rated movies
  ///
  /// [language] is the ISO 639-1 language code (e.g., 'en-US')
  /// [page] is the page number to retrieve (default: 1)
  /// [region] is the ISO 3166-1 region code (e.g., 'US')
  ///
  /// Returns a [PaginatedResponse] of [MovieShort] objects
  Future<PaginatedResponse<MovieShort>> getTopRated({
    String? language,
    int page = 1,
    String? region,
  }) async {
    final params = QueryParameters.buildCommonParams(
      language: language,
      page: page,
      region: region,
    );

    final response = await _apiClient.get(
      '/movie/top_rated',
      queryParameters: QueryParameters.cleanNullParams(params),
    );

    return PaginatedResponse.fromJson(
      response,
      (json) => MovieShort.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Gets the list of upcoming movies
  ///
  /// [language] is the ISO 639-1 language code (e.g., 'en-US')
  /// [page] is the page number to retrieve (default: 1)
  /// [region] is the ISO 3166-1 region code (e.g., 'US')
  ///
  /// Returns a [PaginatedResponse] of [MovieShort] objects
  Future<PaginatedResponse<MovieShort>> getUpcoming({
    String? language,
    int page = 1,
    String? region,
  }) async {
    final params = QueryParameters.buildCommonParams(
      language: language,
      page: page,
      region: region,
    );

    final response = await _apiClient.get(
      '/movie/upcoming',
      queryParameters: QueryParameters.cleanNullParams(params),
    );

    return PaginatedResponse.fromJson(
      response,
      (json) => MovieShort.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Gets the cast and crew information for a specific movie
  ///
  /// [movieId] is the ID of the movie
  /// [language] is the ISO 639-1 language code (e.g., 'en-US')
  ///
  /// Returns a [Credits] object containing cast and crew information
  Future<Credits> getCredits(
    int movieId, {
    String? language,
  }) async {
    final params = QueryParameters.buildCommonParams(language: language);

    final response = await _apiClient.get(
      '/movie/$movieId/credits',
      queryParameters: QueryParameters.cleanNullParams(params),
    );

    return Credits.fromJson(response);
  }

  /// Gets the images (posters, backdrops, logos) for a specific movie
  ///
  /// [movieId] is the ID of the movie
  /// [language] is the ISO 639-1 language code (e.g., 'en-US')
  /// [includeImageLanguage] is a list of ISO 639-1 language codes to include
  ///
  /// Returns a list of [TmdbImage] objects combining backdrops, posters, and logos
  Future<List<TmdbImage>> getImages(
    int movieId, {
    String? language,
    List<String>? includeImageLanguage,
  }) async {
    final params = QueryParameters.buildCommonParams(language: language);

    if (includeImageLanguage != null && includeImageLanguage.isNotEmpty) {
      params['include_image_language'] = includeImageLanguage.join(',');
    }

    final response = await _apiClient.get(
      '/movie/$movieId/images',
      queryParameters: QueryParameters.cleanNullParams(params),
    );

    final List<TmdbImage> images = [];

    // Add backdrops
    if (response['backdrops'] != null) {
      final List<dynamic> backdrops = response['backdrops'];
      images.addAll(backdrops.map((json) => TmdbImage.fromJson(json)));
    }

    // Add posters
    if (response['posters'] != null) {
      final List<dynamic> posters = response['posters'];
      images.addAll(posters.map((json) => TmdbImage.fromJson(json)));
    }

    // Add logos
    if (response['logos'] != null) {
      final List<dynamic> logos = response['logos'];
      images.addAll(logos.map((json) => TmdbImage.fromJson(json)));
    }

    return images;
  }

  /// Gets the videos (trailers, teasers, clips) for a specific movie
  ///
  /// [movieId] is the ID of the movie
  /// [language] is the ISO 639-1 language code (e.g., 'en-US')
  ///
  /// Returns a list of [Video] objects
  Future<List<Video>> getVideos(
    int movieId, {
    String? language,
  }) async {
    final params = QueryParameters.buildCommonParams(language: language);

    final response = await _apiClient.get(
      '/movie/$movieId/videos',
      queryParameters: QueryParameters.cleanNullParams(params),
    );

    if (response['results'] == null) {
      return [];
    }

    final List<dynamic> results = response['results'];
    return results.map((json) => Video.fromJson(json)).toList();
  }

  /// Gets the reviews for a specific movie
  ///
  /// [movieId] is the ID of the movie
  /// [language] is the ISO 639-1 language code (e.g., 'en-US')
  /// [page] is the page number to retrieve (default: 1)
  ///
  /// Returns a [PaginatedResponse] of [Review] objects
  Future<PaginatedResponse<Review>> getReviews(
    int movieId, {
    String? language,
    int page = 1,
  }) async {
    final params = QueryParameters.buildCommonParams(
      language: language,
      page: page,
    );

    final response = await _apiClient.get(
      '/movie/$movieId/reviews',
      queryParameters: QueryParameters.cleanNullParams(params),
    );

    return PaginatedResponse.fromJson(
      response,
      (json) => Review.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Gets the keywords for a specific movie
  ///
  /// [movieId] is the ID of the movie
  ///
  /// Returns a list of [Keyword] objects
  Future<List<Keyword>> getKeywords(int movieId) async {
    final response = await _apiClient.get('/movie/$movieId/keywords');

    if (response['keywords'] == null) {
      return [];
    }

    final List<dynamic> keywords = response['keywords'];
    return keywords.map((json) => Keyword.fromJson(json)).toList();
  }

  /// Gets the list of similar movies to a specific movie
  ///
  /// [movieId] is the ID of the movie
  /// [language] is the ISO 639-1 language code (e.g., 'en-US')
  /// [page] is the page number to retrieve (default: 1)
  ///
  /// Returns a [PaginatedResponse] of [MovieShort] objects
  Future<PaginatedResponse<MovieShort>> getSimilar(
    int movieId, {
    String? language,
    int page = 1,
  }) async {
    final params = QueryParameters.buildCommonParams(
      language: language,
      page: page,
    );

    final response = await _apiClient.get(
      '/movie/$movieId/similar',
      queryParameters: QueryParameters.cleanNullParams(params),
    );

    return PaginatedResponse.fromJson(
      response,
      (json) => MovieShort.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Gets the list of recommended movies based on a specific movie
  ///
  /// [movieId] is the ID of the movie
  /// [language] is the ISO 639-1 language code (e.g., 'en-US')
  /// [page] is the page number to retrieve (default: 1)
  ///
  /// Returns a [PaginatedResponse] of [MovieShort] objects
  Future<PaginatedResponse<MovieShort>> getRecommendations(
    int movieId, {
    String? language,
    int page = 1,
  }) async {
    final params = QueryParameters.buildCommonParams(
      language: language,
      page: page,
    );

    final response = await _apiClient.get(
      '/movie/$movieId/recommendations',
      queryParameters: QueryParameters.cleanNullParams(params),
    );

    return PaginatedResponse.fromJson(
      response,
      (json) => MovieShort.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Gets the external IDs for a specific movie
  ///
  /// [movieId] is the ID of the movie
  ///
  /// Returns an [ExternalIds] object containing external IDs
  Future<ExternalIds> getExternalIds(int movieId) async {
    final response = await _apiClient.get('/movie/$movieId/external_ids');
    return ExternalIds.fromJson(response);
  }

  /// Gets the watch providers for a specific movie
  ///
  /// [movieId] is the ID of the movie
  ///
  /// Returns a [WatchProvidersResult] object containing watch provider information
  Future<WatchProvidersResult> getWatchProviders(int movieId) async {
    final response = await _apiClient.get('/movie/$movieId/watch/providers');
    return WatchProvidersResult.fromJson(response);
  }

  /// Gets the alternative titles for a specific movie
  ///
  /// [movieId] is the ID of the movie
  /// [country] is the ISO 3166-1 country code to filter results
  ///
  /// Returns a map of country codes to alternative titles
  Future<Map<String, String>> getAlternativeTitles(
    int movieId, {
    String? country,
  }) async {
    final params = <String, dynamic>{};
    if (country != null) params['country'] = country;

    final response = await _apiClient.get(
      '/movie/$movieId/alternative_titles',
      queryParameters: QueryParameters.cleanNullParams(params),
    );

    if (response['titles'] == null) {
      return {};
    }

    final Map<String, String> titles = {};
    final List<dynamic> titlesList = response['titles'];

    for (final title in titlesList) {
      if (title['iso_3166_1'] != null && title['title'] != null) {
        titles[title['iso_3166_1']] = title['title'];
      }
    }

    return titles;
  }
}
