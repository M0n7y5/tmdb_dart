/// Base exception class for all TMDB API related errors
class TmdbException implements Exception {
  /// Error message describing what went wrong
  final String message;

  /// Creates a new TmdbException with the given message
  const TmdbException(this.message);

  @override
  String toString() => 'TmdbException: $message';
}

/// Exception thrown when the TMDB API returns an error response
class TmdbApiException extends TmdbException {
  /// HTTP status code returned by the API
  final int statusCode;

  /// Creates a new TmdbApiException with the given message and status code
  const TmdbApiException(
    super.message, {
    required this.statusCode,
  });

  @override
  String toString() => 'TmdbApiException: $message (Status: $statusCode)';
}

/// Exception thrown when network-related errors occur
class TmdbNetworkException extends TmdbException {
  /// Creates a new TmdbNetworkException with the given message
  const TmdbNetworkException(super.message);

  @override
  String toString() => 'TmdbNetworkException: $message';
}

/// Exception thrown when the API rate limit is exceeded
class TmdbRateLimitException extends TmdbApiException {
  /// Creates a new TmdbRateLimitException with the given message
  const TmdbRateLimitException(super.message) : super(statusCode: 429);

  @override
  String toString() => 'TmdbRateLimitException: $message (Rate limit exceeded)';
}

/// Exception thrown when authentication fails
class TmdbAuthenticationException extends TmdbApiException {
  /// Creates a new TmdbAuthenticationException with the given message
  const TmdbAuthenticationException(super.message) : super(statusCode: 401);

  @override
  String toString() =>
      'TmdbAuthenticationException: $message (Authentication failed)';
}

/// Exception thrown when a requested resource is not found
class TmdbNotFoundException extends TmdbApiException {
  /// Creates a new TmdbNotFoundException with the given message
  const TmdbNotFoundException(super.message) : super(statusCode: 404);

  @override
  String toString() => 'TmdbNotFoundException: $message (Resource not found)';
}
