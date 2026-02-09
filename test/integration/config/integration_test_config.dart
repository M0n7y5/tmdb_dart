/// Configuration management for integration tests.
///
/// This class handles reading the TMDB API key from environment variables
/// and provides utilities for setting up integration tests.
library;

import 'dart:io';
import 'package:tmdb_dart/tmdb_dart.dart';

/// Configuration class for integration tests.
///
/// Provides methods to manage API key configuration and create
/// TmdbClient instances for testing.
class IntegrationTestConfig {
  /// The environment variable name for the TMDB API key
  static const String _apiKeyEnvVar = 'TMDB_API_KEY';

  /// Gets the API key from environment variables.
  ///
  /// Returns the API key if set, otherwise returns null.
  static String? get _apiKey {
    // First try to get from dart-define
    final dartDefineKey = String.fromEnvironment(_apiKeyEnvVar);
    if (dartDefineKey.isNotEmpty) {
      return dartDefineKey;
    }
    
    // Then try to get from system environment variable
    return Platform.environment[_apiKeyEnvVar];
  }

  /// Checks if an API key is available.
  ///
  /// Returns true if the API key is set, false otherwise.
  static bool get hasApiKey => _apiKey != null && _apiKey!.isNotEmpty;

  /// Returns a message explaining why tests are skipped when no API key is provided.
  ///
  /// Call this method to get a formatted message that can be used with
  /// the test package's skip function.
  static String get skipMessage => '''
╔══════════════════════════════════════════════════════════════╗
║  INTEGRATION TESTS SKIPPED: No TMDB API key provided         ║
╠══════════════════════════════════════════════════════════════╣
║  To run integration tests, you need to provide a TMDB API     ║
║  key via the TMDB_API_KEY environment variable:               ║
║                                                              ║
║  dart test --dart-define=TMDB_API_KEY=your_api_key_here     ║
║  or                                                          ║
║  TMDB_API_KEY=your_api_key_here dart test ...                ║
║                                                              ║
║  You can obtain an API key from:                             ║
║  https://www.themoviedb.org/settings/api                     ║
╚══════════════════════════════════════════════════════════════╝''';

  /// Creates a TmdbClient instance with the API key from environment variables.
  ///
  /// Throws an AssertionError if no API key is available.
  /// Use [skipIfNoApiKey] before calling this method to handle missing keys gracefully.
  static TmdbClient createClient() {
    assert(hasApiKey, 'No API key available. Use skipIfNoApiKey() first.');
    return TmdbClient(apiKey: _apiKey!);
  }

  /// Private constructor to prevent instantiation.
  IntegrationTestConfig._();
}