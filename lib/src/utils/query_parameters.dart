/// Helper functions for building query parameters
class QueryParameters {
  /// Builds common query parameters used across most API endpoints
  ///
  /// [language] is the ISO 639-1 language code (e.g., 'en-US')
  /// [region] is the ISO 3166-1 region code (e.g., 'US')
  /// [page] is the page number to retrieve
  ///
  /// Returns a map with non-null values only
  static Map<String, dynamic> buildCommonParams({
    String? language,
    String? region,
    int? page,
  }) {
    final params = <String, dynamic>{};

    if (language != null) params['language'] = language;
    if (region != null) params['region'] = region;
    if (page != null) params['page'] = page.toString();

    return params;
  }

  /// Builds the append_to_response parameter
  ///
  /// [append] is a list of additional data to include with the response
  ///
  /// Example:
  /// ```dart
  /// final params = QueryParameters.buildAppendToResponse(['credits', 'videos', 'images']);
  /// // Returns: {'append_to_response': 'credits,videos,images'}
  /// ```
  static Map<String, dynamic> buildAppendToResponse(List<String> append) {
    if (append.isEmpty) return {};

    return {'append_to_response': append.join(',')};
  }

  /// Removes null values from a parameters map
  ///
  /// [params] is the map to clean
  ///
  /// Returns a new map with only non-null values
  static Map<String, dynamic> cleanNullParams(Map<String, dynamic> params) {
    final cleanedParams = <String, dynamic>{};

    params.forEach((key, value) {
      if (value != null) {
        cleanedParams[key] = value;
      }
    });

    return cleanedParams;
  }
}
