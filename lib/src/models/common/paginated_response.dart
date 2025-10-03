import 'package:json_annotation/json_annotation.dart';

part 'paginated_response.g.dart';

/// A generic paginated response model for TMDB API endpoints that return paginated results.
@JsonSerializable(genericArgumentFactories: true)
class PaginatedResponse<T> {
  /// The current page number
  final int page;

  /// The results for the current page
  final List<T> results;

  /// The total number of pages available
  @JsonKey(name: 'total_pages')
  final int totalPages;

  /// The total number of results available
  @JsonKey(name: 'total_results')
  final int totalResults;

  const PaginatedResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  /// Creates a [PaginatedResponse] from JSON
  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$PaginatedResponseFromJson(json, fromJsonT);

  /// Converts this [PaginatedResponse] to JSON
  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$PaginatedResponseToJson(this, toJsonT);
}
