import 'dart:async';

import 'api_client.dart';
import '../services/configuration_service.dart';
import '../services/movie_service.dart';
import '../services/person_service.dart';
import '../services/search_service.dart';
import '../services/tv_service.dart';

/// Main client class for interacting with the TMDB API
class TmdbClient {
  final String _apiKey;
  final String _baseUrl;
  final String? _cachePath;
  final bool _enableLogging;
  final bool _logRequestBody;
  final bool _logResponseBody;
  final void Function(Object message)? _logger;
  late final ApiClient _apiClient;

  // Service instances
  MovieService? _movies;
  SearchService? _search;
  ConfigurationService? _configuration;
  TvService? _tv;
  PersonService? _people;

  /// Creates a new TMDB client instance
  ///
  /// [apiKey] is the Bearer token for authentication
  /// [baseUrl] is optional, defaults to TMDB API v3 base URL
  /// [cachePath] is optional path for cache storage. If null, caching is disabled
  TmdbClient({
    required String apiKey,
    String baseUrl = 'https://api.themoviedb.org/3/',
    String? cachePath,
    bool enableLogging = false,
    bool logRequestBody = false,
    bool logResponseBody = false,
    void Function(Object message)? logger,
  })  : _apiKey = apiKey,
        _baseUrl = baseUrl,
        _cachePath = cachePath,
        _enableLogging = enableLogging,
        _logRequestBody = logRequestBody,
        _logResponseBody = logResponseBody,
        _logger = logger {
    _initializeClient();
  }

  void _initializeClient() {
    _apiClient = ApiClient(
      apiKey: _apiKey,
      baseUrl: _baseUrl,
      cachePath: _cachePath,
      enableLogging: _enableLogging,
      logRequestBody: _logRequestBody,
      logResponseBody: _logResponseBody,
      logger: _logger,
    );
  }

  /// Gets the API client instance
  ApiClient get apiClient => _apiClient;

  /// Gets the movie service instance
  MovieService get movies => _movies ??= MovieService(_apiClient);

  /// Gets the search service instance
  SearchService get search => _search ??= SearchService(_apiClient);

  /// Gets the configuration service instance
  ConfigurationService get configuration =>
      _configuration ??= ConfigurationService(_apiClient);

  /// Gets the TV service instance
  TvService get tv => _tv ??= TvService(_apiClient);

  /// Gets the person service instance
  PersonService get people => _people ??= PersonService(_apiClient);

  /// Closes the client and disposes of resources
  Future<void> close() async {
    await _apiClient.close();
  }
}
