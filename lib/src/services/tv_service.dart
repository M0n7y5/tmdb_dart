import 'dart:async';

import '../core/api_client.dart';
import '../models/common/external_ids.dart';
import '../models/common/image.dart';
import '../models/common/keyword.dart';
import '../models/common/paginated_response.dart';
import '../models/common/video.dart';
import '../models/credits/credits.dart';
import '../models/review.dart';
import '../models/tv/episode.dart';
import '../models/tv/season.dart';
import '../models/tv/tv_show.dart';
import '../models/tv/tv_show_short.dart';
import '../models/watch_providers_result.dart';
import '../utils/query_parameters.dart';

/// Service for interacting with the TMDB TV API endpoints
class TvService {
  final ApiClient _apiClient;

  /// Creates a new [TvService] instance
  ///
  /// [_apiClient] is the API client for making HTTP requests
  TvService(this._apiClient);

  /// Gets the detailed information for a specific TV show
  ///
  /// [tvId] is the ID of the TV show
  /// [language] is the ISO 639-1 language code (e.g., 'en-US')
  /// [appendToResponse] is a list of additional data to include with the response
  ///
  /// Returns a [TvShow] object with detailed information
  Future<TvShow> getDetails(
    int tvId, {
    String? language,
    List<String>? appendToResponse,
  }) async {
    final params = QueryParameters.buildCommonParams(language: language);

    if (appendToResponse != null && appendToResponse.isNotEmpty) {
      params.addAll(QueryParameters.buildAppendToResponse(appendToResponse));
    }

    final response = await _apiClient.get(
      '/tv/$tvId',
      queryParameters: QueryParameters.cleanNullParams(params),
    );

    return TvShow.fromJson(response);
  }

  /// Gets the list of TV shows airing today
  ///
  /// [language] is the ISO 639-1 language code (e.g., 'en-US')
  /// [page] is the page number to retrieve (default: 1)
  /// [timezone] is the timezone to filter results (e.g., 'America/New_York')
  ///
  /// Returns a [PaginatedResponse] of [TvShowShort] objects
  Future<PaginatedResponse<TvShowShort>> getAiringToday({
    String? language,
    int page = 1,
    String? timezone,
  }) async {
    final params = QueryParameters.buildCommonParams(
      language: language,
      page: page,
    );

    if (timezone != null) params['timezone'] = timezone;

    final response = await _apiClient.get(
      '/tv/airing_today',
      queryParameters: QueryParameters.cleanNullParams(params),
    );

    return PaginatedResponse.fromJson(
      response,
      (json) => TvShowShort.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Gets the list of TV shows that are currently on the air
  ///
  /// [language] is the ISO 639-1 language code (e.g., 'en-US')
  /// [page] is the page number to retrieve (default: 1)
  /// [timezone] is the timezone to filter results (e.g., 'America/New_York')
  ///
  /// Returns a [PaginatedResponse] of [TvShowShort] objects
  Future<PaginatedResponse<TvShowShort>> getOnTheAir({
    String? language,
    int page = 1,
    String? timezone,
  }) async {
    final params = QueryParameters.buildCommonParams(
      language: language,
      page: page,
    );

    if (timezone != null) params['timezone'] = timezone;

    final response = await _apiClient.get(
      '/tv/on_the_air',
      queryParameters: QueryParameters.cleanNullParams(params),
    );

    return PaginatedResponse.fromJson(
      response,
      (json) => TvShowShort.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Gets the list of popular TV shows
  ///
  /// [language] is the ISO 639-1 language code (e.g., 'en-US')
  /// [page] is the page number to retrieve (default: 1)
  ///
  /// Returns a [PaginatedResponse] of [TvShowShort] objects
  Future<PaginatedResponse<TvShowShort>> getPopular({
    String? language,
    int page = 1,
  }) async {
    final params = QueryParameters.buildCommonParams(
      language: language,
      page: page,
    );

    final response = await _apiClient.get(
      '/tv/popular',
      queryParameters: QueryParameters.cleanNullParams(params),
    );

    return PaginatedResponse.fromJson(
      response,
      (json) => TvShowShort.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Gets the list of top rated TV shows
  ///
  /// [language] is the ISO 639-1 language code (e.g., 'en-US')
  /// [page] is the page number to retrieve (default: 1)
  ///
  /// Returns a [PaginatedResponse] of [TvShowShort] objects
  Future<PaginatedResponse<TvShowShort>> getTopRated({
    String? language,
    int page = 1,
  }) async {
    final params = QueryParameters.buildCommonParams(
      language: language,
      page: page,
    );

    final response = await _apiClient.get(
      '/tv/top_rated',
      queryParameters: QueryParameters.cleanNullParams(params),
    );

    return PaginatedResponse.fromJson(
      response,
      (json) => TvShowShort.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Gets the cast and crew information for a specific TV show
  ///
  /// [tvId] is the ID of the TV show
  /// [language] is the ISO 639-1 language code (e.g., 'en-US')
  ///
  /// Returns a [Credits] object containing cast and crew information
  Future<Credits> getCredits(
    int tvId, {
    String? language,
  }) async {
    final params = QueryParameters.buildCommonParams(language: language);

    final response = await _apiClient.get(
      '/tv/$tvId/credits',
      queryParameters: QueryParameters.cleanNullParams(params),
    );

    return Credits.fromJson(response);
  }

  /// Gets the images (posters, backdrops, logos) for a specific TV show
  ///
  /// [tvId] is the ID of the TV show
  /// [language] is the ISO 639-1 language code (e.g., 'en-US')
  /// [includeImageLanguage] is a list of ISO 639-1 language codes to include
  ///
  /// Returns a list of [TmdbImage] objects combining backdrops, posters, and logos
  Future<List<TmdbImage>> getImages(
    int tvId, {
    String? language,
    List<String>? includeImageLanguage,
  }) async {
    final params = QueryParameters.buildCommonParams(language: language);

    if (includeImageLanguage != null && includeImageLanguage.isNotEmpty) {
      params['include_image_language'] = includeImageLanguage.join(',');
    }

    final response = await _apiClient.get(
      '/tv/$tvId/images',
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

  /// Gets the videos (trailers, teasers, clips) for a specific TV show
  ///
  /// [tvId] is the ID of the TV show
  /// [language] is the ISO 639-1 language code (e.g., 'en-US')
  ///
  /// Returns a list of [Video] objects
  Future<List<Video>> getVideos(
    int tvId, {
    String? language,
  }) async {
    final params = QueryParameters.buildCommonParams(language: language);

    final response = await _apiClient.get(
      '/tv/$tvId/videos',
      queryParameters: QueryParameters.cleanNullParams(params),
    );

    if (response['results'] == null) {
      return [];
    }

    final List<dynamic> results = response['results'];
    return results.map((json) => Video.fromJson(json)).toList();
  }

  /// Gets the reviews for a specific TV show
  ///
  /// [tvId] is the ID of the TV show
  /// [language] is the ISO 639-1 language code (e.g., 'en-US')
  /// [page] is the page number to retrieve (default: 1)
  ///
  /// Returns a [PaginatedResponse] of [Review] objects
  Future<PaginatedResponse<Review>> getReviews(
    int tvId, {
    String? language,
    int page = 1,
  }) async {
    final params = QueryParameters.buildCommonParams(
      language: language,
      page: page,
    );

    final response = await _apiClient.get(
      '/tv/$tvId/reviews',
      queryParameters: QueryParameters.cleanNullParams(params),
    );

    return PaginatedResponse.fromJson(
      response,
      (json) => Review.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Gets the keywords for a specific TV show
  ///
  /// [tvId] is the ID of the TV show
  ///
  /// Returns a list of [Keyword] objects
  Future<List<Keyword>> getKeywords(int tvId) async {
    final response = await _apiClient.get('/tv/$tvId/keywords');

    if (response['results'] == null) {
      return [];
    }

    final List<dynamic> keywords = response['results'];
    return keywords.map((json) => Keyword.fromJson(json)).toList();
  }

  /// Gets the detailed information for a specific season of a TV show
  ///
  /// [tvId] is the ID of the TV show
  /// [seasonNumber] is the season number
  /// [language] is the ISO 639-1 language code (e.g., 'en-US')
  /// [appendToResponse] is a list of additional data to include with the response
  ///
  /// Returns a [Season] object with detailed information
  Future<Season> getSeasonDetails(
    int tvId,
    int seasonNumber, {
    String? language,
    List<String>? appendToResponse,
  }) async {
    final params = QueryParameters.buildCommonParams(language: language);

    if (appendToResponse != null && appendToResponse.isNotEmpty) {
      params.addAll(QueryParameters.buildAppendToResponse(appendToResponse));
    }

    final response = await _apiClient.get(
      '/tv/$tvId/season/$seasonNumber',
      queryParameters: QueryParameters.cleanNullParams(params),
    );

    return Season.fromJson(response);
  }

  /// Gets the cast and crew information for a specific season of a TV show
  ///
  /// [tvId] is the ID of the TV show
  /// [seasonNumber] is the season number
  /// [language] is the ISO 639-1 language code (e.g., 'en-US')
  ///
  /// Returns a [Credits] object containing cast and crew information
  Future<Credits> getSeasonCredits(
    int tvId,
    int seasonNumber, {
    String? language,
  }) async {
    final params = QueryParameters.buildCommonParams(language: language);

    final response = await _apiClient.get(
      '/tv/$tvId/season/$seasonNumber/credits',
      queryParameters: QueryParameters.cleanNullParams(params),
    );

    return Credits.fromJson(response);
  }

  /// Gets the detailed information for a specific episode of a TV show
  ///
  /// [tvId] is the ID of the TV show
  /// [seasonNumber] is the season number
  /// [episodeNumber] is the episode number
  /// [language] is the ISO 639-1 language code (e.g., 'en-US')
  /// [appendToResponse] is a list of additional data to include with the response
  ///
  /// Returns an [Episode] object with detailed information
  Future<Episode> getEpisodeDetails(
    int tvId,
    int seasonNumber,
    int episodeNumber, {
    String? language,
    List<String>? appendToResponse,
  }) async {
    final params = QueryParameters.buildCommonParams(language: language);

    if (appendToResponse != null && appendToResponse.isNotEmpty) {
      params.addAll(QueryParameters.buildAppendToResponse(appendToResponse));
    }

    final response = await _apiClient.get(
      '/tv/$tvId/season/$seasonNumber/episode/$episodeNumber',
      queryParameters: QueryParameters.cleanNullParams(params),
    );

    return Episode.fromJson(response);
  }

  /// Gets the cast and crew information for a specific episode of a TV show
  ///
  /// [tvId] is the ID of the TV show
  /// [seasonNumber] is the season number
  /// [episodeNumber] is the episode number
  /// [language] is the ISO 639-1 language code (e.g., 'en-US')
  ///
  /// Returns a [Credits] object containing cast and crew information
  Future<Credits> getEpisodeCredits(
    int tvId,
    int seasonNumber,
    int episodeNumber, {
    String? language,
  }) async {
    final params = QueryParameters.buildCommonParams(language: language);

    final response = await _apiClient.get(
      '/tv/$tvId/season/$seasonNumber/episode/$episodeNumber/credits',
      queryParameters: QueryParameters.cleanNullParams(params),
    );

    return Credits.fromJson(response);
  }

  /// Gets the list of similar TV shows to a specific TV show
  ///
  /// [tvId] is the ID of the TV show
  /// [language] is the ISO 639-1 language code (e.g., 'en-US')
  /// [page] is the page number to retrieve (default: 1)
  ///
  /// Returns a [PaginatedResponse] of [TvShowShort] objects
  Future<PaginatedResponse<TvShowShort>> getSimilar(
    int tvId, {
    String? language,
    int page = 1,
  }) async {
    final params = QueryParameters.buildCommonParams(
      language: language,
      page: page,
    );

    final response = await _apiClient.get(
      '/tv/$tvId/similar',
      queryParameters: QueryParameters.cleanNullParams(params),
    );

    return PaginatedResponse.fromJson(
      response,
      (json) => TvShowShort.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Gets the list of recommended TV shows based on a specific TV show
  ///
  /// [tvId] is the ID of the TV show
  /// [language] is the ISO 639-1 language code (e.g., 'en-US')
  /// [page] is the page number to retrieve (default: 1)
  ///
  /// Returns a [PaginatedResponse] of [TvShowShort] objects
  Future<PaginatedResponse<TvShowShort>> getRecommendations(
    int tvId, {
    String? language,
    int page = 1,
  }) async {
    final params = QueryParameters.buildCommonParams(
      language: language,
      page: page,
    );

    final response = await _apiClient.get(
      '/tv/$tvId/recommendations',
      queryParameters: QueryParameters.cleanNullParams(params),
    );

    return PaginatedResponse.fromJson(
      response,
      (json) => TvShowShort.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Gets the external IDs for a specific TV show
  ///
  /// [tvId] is the ID of the TV show
  ///
  /// Returns an [ExternalIds] object containing external IDs
  Future<ExternalIds> getExternalIds(int tvId) async {
    final response = await _apiClient.get('/tv/$tvId/external_ids');
    return ExternalIds.fromJson(response);
  }

  /// Gets the watch providers for a specific TV show
  ///
  /// [tvId] is the ID of the TV show
  ///
  /// Returns a [WatchProvidersResult] object containing watch provider information
  Future<WatchProvidersResult> getWatchProviders(int tvId) async {
    final response = await _apiClient.get('/tv/$tvId/watch/providers');
    return WatchProvidersResult.fromJson(response);
  }

  /// Gets the alternative titles for a specific TV show
  ///
  /// [tvId] is the ID of the TV show
  ///
  /// Returns a map of country codes to alternative titles
  Future<Map<String, String>> getAlternativeTitles(int tvId) async {
    final response = await _apiClient.get('/tv/$tvId/alternative_titles');

    if (response['results'] == null) {
      return {};
    }

    final Map<String, String> titles = {};
    final List<dynamic> titlesList = response['results'];

    for (final title in titlesList) {
      if (title['iso_3166_1'] != null && title['title'] != null) {
        titles[title['iso_3166_1']] = title['title'];
      }
    }

    return titles;
  }

  /// Gets the content ratings for a specific TV show
  ///
  /// [tvId] is the ID of the TV show
  ///
  /// Returns a list of content rating objects
  Future<List<Map<String, dynamic>>> getContentRatings(int tvId) async {
    final response = await _apiClient.get('/tv/$tvId/content_ratings');

    if (response['results'] == null) {
      return [];
    }

    final List<dynamic> results = response['results'];
    return results.map((item) => item as Map<String, dynamic>).toList();
  }
}
