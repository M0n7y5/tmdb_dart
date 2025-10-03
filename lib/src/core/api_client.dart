import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';

import 'exceptions.dart';

/// Base API client for handling HTTP requests to the TMDB API
class ApiClient {
  late final Dio _dio;
  final String _baseUrl;
  final String _apiKey;
  final String? _cachePath;

  /// Creates a new API client instance
  ///
  /// [apiKey] is the Bearer token for authentication
  /// [baseUrl] is the base URL for the TMDB API
  /// [cachePath] is optional path for cache storage. If null, caching is disabled
  ApiClient({
    required String apiKey,
    required String baseUrl,
    String? cachePath,
  })  : _apiKey = apiKey,
        _baseUrl = baseUrl,
        _cachePath = cachePath {
    _initializeDio();
  }

  void _initializeDio() {
    _dio = Dio(BaseOptions(
      baseUrl: _baseUrl,
      headers: {
        'Authorization': 'Bearer $_apiKey',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
    ));

    // Add interceptors
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (object) => print(object.toString()),
      ),
    );

    // Add caching interceptor if cachePath is provided
    _initializeCache();

    // Add error handling interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) {
          final exception = _handleError(error);
          handler.reject(DioException(
            requestOptions: error.requestOptions,
            error: exception,
          ));
        },
      ),
    );
  }

  void _initializeCache() {
    try {
      // Only initialize cache if cachePath is provided
      if (_cachePath != null) {
        final cacheStore = HiveCacheStore(_cachePath!);

        _dio.interceptors.add(
          DioCacheInterceptor(
            options: CacheOptions(
              store: cacheStore,
              policy: CachePolicy.request,
              hitCacheOnErrorExcept: [401, 403],
              maxStale: const Duration(days: 7),
              priority: CachePriority.high,
              cipher: null,
              keyBuilder: CacheOptions.defaultCacheKeyBuilder,
              allowPostMethod: false,
            ),
          ),
        );
      }
    } catch (e) {
      // Cache initialization failed, continue without caching
      print('Failed to initialize cache: $e');
    }
  }

  /// Handles HTTP errors and converts them to appropriate exceptions
  TmdbException _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TmdbNetworkException('Request timeout: ${error.message}');

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message = error.response?.data?['status_message'] ??
            error.response?.statusMessage ??
            'Unknown error';

        switch (statusCode) {
          case 401:
            return TmdbAuthenticationException(message);
          case 404:
            return TmdbNotFoundException(message);
          case 429:
            return TmdbRateLimitException(message);
          default:
            return TmdbApiException(
              message,
              statusCode: statusCode ?? 0,
            );
        }

      case DioExceptionType.cancel:
        return TmdbNetworkException('Request was cancelled');

      case DioExceptionType.connectionError:
        return TmdbNetworkException('Connection error: ${error.message}');

      case DioExceptionType.unknown:
      default:
        return TmdbNetworkException('Network error: ${error.message}');
    }
  }

  /// Performs a GET request to the specified endpoint
  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      return response.data ?? {};
    } on DioException catch (e) {
      throw e.error ?? TmdbNetworkException('Unknown error occurred');
    }
  }

  /// Performs a GET request that can return either a Map or a List
  Future<dynamic> getDynamic(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.get<dynamic>(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      return response.data;
    } on DioException catch (e) {
      throw e.error ?? TmdbNetworkException('Unknown error occurred');
    }
  }

  /// Performs a POST request to the specified endpoint
  Future<Map<String, dynamic>> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response.data ?? {};
    } on DioException catch (e) {
      throw e.error ?? TmdbNetworkException('Unknown error occurred');
    }
  }

  /// Performs a DELETE request to the specified endpoint
  Future<Map<String, dynamic>> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.delete<Map<String, dynamic>>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response.data ?? {};
    } on DioException catch (e) {
      throw e.error ?? TmdbNetworkException('Unknown error occurred');
    }
  }

  /// Closes the Dio client and disposes of resources
  Future<void> close() async {
    _dio.close();
  }
}
