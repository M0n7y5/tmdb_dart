/// Helper utilities for integration tests.
///
/// This file contains reusable utility methods for common integration
/// testing tasks such as validating responses and managing API rate limits.
library;

import 'dart:async';
import 'package:test/test.dart';
import 'package:tmdb_dart/tmdb_dart.dart';

/// Collection of helper methods for integration testing.
///
/// These utilities provide common functionality needed across integration
/// tests, such as response validation and rate limit management.
class IntegrationTestHelper {
  /// Validates the structure of a PaginatedResponse.
  ///
  /// Checks that the response has valid pagination data and that the
  /// results list is not null.
  ///
  /// [response] The PaginatedResponse to validate
  /// [expectedPage] Optional expected page number
  /// [minResults] Optional minimum number of results expected
  static void validatePaginatedResponse<T>(
    PaginatedResponse<T> response, {
    int? expectedPage,
    int? minResults,
  }) {
    expect(response.page, isA<int>(), reason: 'Page should be an integer');
    expect(response.totalPages, greaterThan(0), reason: 'Total pages should be greater than 0');
    expect(response.totalResults, greaterThanOrEqualTo(0), reason: 'Total results should be non-negative');
    expect(response.results, isA<List<T>>(), reason: 'Results should be a list');
    
    if (expectedPage != null) {
      expect(response.page, equals(expectedPage), reason: 'Page should match expected value');
    }
    
    if (minResults != null) {
      expect(response.results.length, greaterThanOrEqualTo(minResults), 
             reason: 'Results should contain at least $minResults items');
    }
  }

  /// Validates that an image path follows TMDB conventions.
  ///
  /// TMDB image paths should start with a forward slash (/).
  /// This method checks for that convention.
  ///
  /// [imagePath] The image path to validate
  /// [allowNull] Whether null values are acceptable (default: false)
  static void validateImagePath(String? imagePath, {bool allowNull = false}) {
    if (imagePath == null) {
      expect(allowNull, isTrue, reason: 'Image path was null but allowNull is false');
      return;
    }
    
    expect(imagePath, startsWith('/'), reason: 'Image path should start with "/"');
    expect(imagePath, isNotEmpty, reason: 'Image path should not be empty');
  }

  /// Adds a delay to respect API rate limits.
  ///
  /// The TMDB API has rate limits that should be respected during
  /// testing to avoid being blocked. This method adds a configurable
  /// delay between API calls.
  ///
  /// [milliseconds] The delay duration in milliseconds (default: 250)
  static Future<void> addRateLimitDelay({int milliseconds = 250}) {
    return Future.delayed(Duration(milliseconds: milliseconds));
  }

  /// Validates that a list of image paths all follow TMDB conventions.
  ///
  /// Convenience method to validate multiple image paths at once.
  ///
  /// [imagePaths] The list of image paths to validate
  /// [allowNull] Whether null values are acceptable (default: false)
  static void validateImagePaths(List<String?> imagePaths, {bool allowNull = false}) {
    for (final path in imagePaths) {
      validateImagePath(path, allowNull: allowNull);
    }
  }

  /// Validates common properties of TMDB entities.
  ///
  /// Many TMDB entities share common properties like ID and name/title.
  /// This method validates these common properties.
  ///
  /// [entity] The entity to validate (must have an id property)
  /// [name] The name/title of the entity
  /// [requireName] Whether the name is required (default: true)
  static void validateCommonEntityProperties(
    dynamic entity,
    String? name, {
    bool requireName = true,
  }) {
    // Check that the entity has an ID property
    expect(entity.id, isA<int>(), reason: 'Entity should have an integer ID');
    expect(entity.id, greaterThan(0), reason: 'Entity ID should be greater than 0');
    
    if (requireName) {
      expect(name, isNotNull, reason: 'Entity name should not be null');
      expect(name, isNotEmpty, reason: 'Entity name should not be empty');
    }
  }

  /// Private constructor to prevent instantiation.
  IntegrationTestHelper._();
}