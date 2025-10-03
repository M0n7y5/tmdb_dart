import 'dart:async';
import '../models/common/paginated_response.dart';

/// Utility class for pagination helpers
class PaginationHelper {
  /// Automatically fetches all pages using the provided fetcher function
  ///
  /// Yields items one by one as they're fetched. Optionally limit to maxPages.
  ///
  /// [fetcher] is a function that takes a page number and returns a PaginatedResponse
  /// [maxPages] is an optional limit on the number of pages to fetch
  ///
  /// Example:
  /// ```dart
  /// final stream = PaginationHelper.autoPaginate<Movie>(
  ///   fetcher: (page) => tmdb.movies.getPopular(page: page),
  ///   maxPages: 5,
  /// );
  /// await for (final movie in stream) {
  ///   print(movie.title);
  /// }
  /// ```
  static Stream<T> autoPaginate<T>({
    required Future<PaginatedResponse<T>> Function(int page) fetcher,
    int? maxPages,
  }) async* {
    int currentPage = 1;
    bool hasMorePages = true;

    while (hasMorePages && (maxPages == null || currentPage <= maxPages)) {
      try {
        final response = await fetcher(currentPage);

        // Yield all items from the current page
        for (final item in response.results) {
          yield item;
        }

        // Check if there are more pages
        hasMorePages = response.page < response.totalPages;
        currentPage++;
      } catch (e) {
        // Let the error bubble up - it will be caught by the caller
        rethrow;
      }
    }
  }

  /// Fetches all pages and returns a complete list
  ///
  /// [fetcher] is a function that takes a page number and returns a PaginatedResponse
  /// [maxPages] is an optional limit on the number of pages to fetch
  ///
  /// Example:
  /// ```dart
  /// final movies = await PaginationHelper.fetchAllPages<Movie>(
  ///   fetcher: (page) => tmdb.movies.getPopular(page: page),
  ///   maxPages: 5,
  /// );
  /// print('Fetched ${movies.length} movies');
  /// ```
  static Future<List<T>> fetchAllPages<T>({
    required Future<PaginatedResponse<T>> Function(int page) fetcher,
    int? maxPages,
  }) async {
    final List<T> allResults = [];
    int currentPage = 1;
    bool hasMorePages = true;

    while (hasMorePages && (maxPages == null || currentPage <= maxPages)) {
      try {
        final response = await fetcher(currentPage);
        allResults.addAll(response.results);

        // Check if there are more pages
        hasMorePages = response.page < response.totalPages;
        currentPage++;
      } catch (e) {
        // Let the error bubble up - it will be caught by the caller
        rethrow;
      }
    }

    return allResults;
  }
}
