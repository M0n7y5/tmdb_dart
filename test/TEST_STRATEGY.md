# TMDB Dart Testing Strategy

## Overview

This document outlines the comprehensive testing strategy for the `tmdb_dart` package, a Dart client library for The Movie Database (TMDB) API. The strategy covers unit tests, integration tests, and widget tests (if applicable), with clear guidelines for mock strategies, test organization, and coverage goals.

---

## 1. Test Categories

### 1.1 Unit Tests
Unit tests verify individual components in isolation, focusing on business logic, data transformation, and utility functions.

**Coverage Areas:**
- **Models**: JSON serialization/deserialization, data validation
- **Utils**: Image URL building, pagination logic, query parameter construction
- **Core**: Exception handling, client initialization
- **Services**: Business logic (without network calls)

### 1.2 Integration Tests
Integration tests verify the interaction between components and external systems (TMDB API).

**Coverage Areas:**
- **API Endpoints**: Real API calls with valid credentials
- **Service Integration**: Complete workflows (e.g., fetch movie → parse → return)
- **Caching Behavior**: Verify cache interceptor works correctly
- **Error Scenarios**: Network timeouts, rate limiting, authentication failures

### 1.3 Mock Tests
Mock tests simulate external dependencies to test service layer logic without real API calls.

**Coverage Areas:**
- **Service Methods**: All service methods with mocked ApiClient
- **Error Handling**: Simulate various error responses
- **Edge Cases**: Empty responses, malformed data

---

## 2. Component-Specific Testing Approaches

### 2.1 Models Testing

**Objective**: Ensure models correctly serialize/deserialize JSON and handle edge cases.

**Test Cases:**
- ✅ Valid JSON → Model conversion (fromJson)
- ✅ Model → JSON conversion (toJson)
- ✅ Round-trip serialization (JSON → Model → JSON)
- ✅ Handle null/optional fields correctly
- ✅ DateTime parsing edge cases (null, empty strings, invalid formats)
- ✅ Nested object serialization (e.g., Movie with ProductionCompany)
- ✅ Generic types (PaginatedResponse<T>)

**Example Test Structure:**
```dart
// test/unit/models/movie_test.dart
group('Movie Model', () {
  test('fromJson creates valid Movie object', () { ... });
  test('toJson creates valid JSON map', () { ... });
  test('handles null backdropPath gracefully', () { ... });
  test('parses release date correctly', () { ... });
});
```

**Priority Models:**
1. `Movie`, `MovieShort` (most complex)
2. `TvShow`, `Season`, `Episode`
3. `Person`, `PersonShort`, `PersonCredits`
4. `PaginatedResponse<T>` (generic)
5. Common models (`Genre`, `Image`, `Video`, etc.)
6. `Credits`, `Cast`, `Crew`

### 2.2 Services Testing

**Objective**: Verify service methods correctly construct requests, handle responses, and manage errors.

**Mock Strategy:**
- Mock `ApiClient` using Mockito
- Define canned responses for each endpoint
- Test both success and failure scenarios

**Test Cases:**
- ✅ Correct endpoint construction (path, query params)
- ✅ Successful response parsing
- ✅ Error handling (404, 401, 429, network errors)
- ✅ Query parameter validation
- ✅ Optional parameter handling
- ✅ Pagination logic

**Example Test Structure:**
```dart
// test/unit/services/movie_service_test.dart
group('MovieService', () {
  late MockApiClient mockApiClient;
  late MovieService movieService;

  setUp(() {
    mockApiClient = MockApiClient();
    movieService = MovieService(mockApiClient);
  });

  test('getDetails returns Movie when API succeeds', () async { ... });
  test('getDetails throws TmdbNotFoundException when movie not found', () { ... });
  test('getNowPlaying constructs correct query params', () { ... });
});
```

**Priority Services:**
1. `MovieService` (most endpoints)
2. `SearchService` (various search types)
3. `TvService`
4. `PersonService`
5. `ConfigurationService`

### 2.3 Utils Testing

**Objective**: Verify utility functions work correctly with various inputs.

#### 2.3.1 ImageUrlBuilder
**Test Cases:**
- ✅ Builds correct poster URLs for all sizes
- ✅ Builds correct backdrop URLs for all sizes
- ✅ Builds correct profile URLs for all sizes
- ✅ Handles null/empty paths gracefully
- ✅ Returns null for invalid inputs
- ✅ Uses correct base URL from configuration

#### 2.3.2 PaginationHelper
**Test Cases:**
- ✅ `autoPaginate` yields all items across pages
- ✅ `autoPaginate` respects maxPages limit
- ✅ `autoPaginate` stops when no more pages
- ✅ `fetchAllPages` returns complete list
- ✅ Error handling during pagination
- ✅ Stream behavior (async iteration)

#### 2.3.3 QueryParameters
**Test Cases:**
- ✅ `buildCommonParams` includes only non-null values
- ✅ `buildAppendToResponse` joins array correctly
- ✅ `cleanNullParams` removes null values
- ✅ Handles empty inputs gracefully

### 2.4 Core Testing

#### 2.4.1 ApiClient
**Test Cases:**
- ✅ Initializes Dio with correct base URL
- ✅ Sets authorization header correctly
- ✅ Handles GET requests successfully
- ✅ Handles POST requests successfully
- ✅ Handles DELETE requests successfully
- ✅ Converts DioExceptions to TmdbExceptions
- ✅ Error mapping (401→Auth, 404→NotFound, 429→RateLimit)
- ✅ Timeout handling
- ✅ Cache initialization (if available)

**Note**: ApiClient tests may use a mix of mocking Dio and integration testing with a test server.

#### 2.4.2 TmdbClient
**Test Cases:**
- ✅ Initializes ApiClient with correct params
- ✅ Lazy-loads service instances
- ✅ Provides access to all services
- ✅ Closes ApiClient on dispose

#### 2.4.3 Exceptions
**Test Cases:**
- ✅ Exception hierarchy is correct
- ✅ Exception messages are formatted correctly
- ✅ Status codes are preserved
- ✅ toString() methods work correctly

---

## 3. Mock Strategy

### 3.1 Mocking Tools

**Primary Tool**: Mockito (already in dev_dependencies)

**Additional Tools (if needed)**:
- `http_mock_adapter` for Dio-specific mocking
- `fake_async` for testing time-dependent code
- Custom test doubles for simple cases

### 3.2 Mock Approach by Component

#### ApiClient Mocking
```dart
@GenerateMocks([ApiClient])
import 'movie_service_test.mocks.dart';

// In test
final mockApiClient = MockApiClient();
when(mockApiClient.get(any, queryParameters: anyNamed('queryParameters')))
    .thenAnswer((_) async => {'id': 1, 'title': 'Test Movie'});
```

#### Service Mocking (for high-level tests)
```dart
@GenerateMocks([MovieService, SearchService, TvService, PersonService])
import 'tmdb_client_test.mocks.dart';
```

#### JSON Response Fixtures
Store sample API responses in `test/fixtures/` for consistent testing:
```
test/fixtures/
├── movie_details.json
├── movie_list.json
├── tv_show_details.json
├── person_details.json
├── search_results.json
└── error_responses.json
```

**Helper Function:**
```dart
// test/helpers/json_reader.dart
Map<String, dynamic> readJson(String path) {
  final file = File('test/fixtures/$path');
  return jsonDecode(file.readAsStringSync());
}
```

### 3.3 Mock Data Strategy

**Approach**: Create reusable mock data builders
```dart
// test/helpers/mock_data.dart
class MockData {
  static Map<String, dynamic> movieJson({int id = 1}) => { ... };
  static Movie movie({int id = 1}) => Movie.fromJson(movieJson(id: id));
  static PaginatedResponse<MovieShort> movieList() => { ... };
}
```

---

## 4. Test File Structure

### 4.1 Directory Organization

```
test/
├── unit/                           # Unit tests (isolated components)
│   ├── models/
│   │   ├── common/
│   │   │   ├── genre_test.dart
│   │   │   ├── image_test.dart
│   │   │   ├── paginated_response_test.dart
│   │   │   └── ...
│   │   ├── movie/
│   │   │   ├── movie_test.dart
│   │   │   └── movie_short_test.dart
│   │   ├── tv/
│   │   │   ├── tv_show_test.dart
│   │   │   ├── season_test.dart
│   │   │   └── episode_test.dart
│   │   ├── person/
│   │   │   ├── person_test.dart
│   │   │   └── person_short_test.dart
│   │   ├── credits/
│   │   │   ├── cast_test.dart
│   │   │   ├── crew_test.dart
│   │   │   └── credits_test.dart
│   │   └── configuration/
│   │       └── api_configuration_test.dart
│   ├── services/
│   │   ├── movie_service_test.dart
│   │   ├── tv_service_test.dart
│   │   ├── person_service_test.dart
│   │   ├── search_service_test.dart
│   │   └── configuration_service_test.dart
│   ├── utils/
│   │   ├── image_url_builder_test.dart
│   │   ├── pagination_helper_test.dart
│   │   └── query_parameters_test.dart
│   ├── core/
│   │   ├── api_client_test.dart
│   │   ├── tmdb_client_test.dart
│   │   └── exceptions_test.dart
│   └── ...
│
├── integration/                    # Integration tests (real API calls)
│   ├── movie_integration_test.dart
│   ├── tv_integration_test.dart
│   ├── person_integration_test.dart
│   ├── search_integration_test.dart
│   └── configuration_integration_test.dart
│
├── helpers/                        # Test utilities
│   ├── json_reader.dart           # Load JSON fixtures
│   ├── mock_data.dart             # Mock data builders
│   └── test_constants.dart        # Shared test constants
│
├── fixtures/                       # JSON response samples
│   ├── movies/
│   │   ├── movie_details.json
│   │   ├── now_playing.json
│   │   └── ...
│   ├── tv/
│   │   └── ...
│   ├── people/
│   │   └── ...
│   └── errors/
│       ├── 401_unauthorized.json
│       ├── 404_not_found.json
│       └── 429_rate_limit.json
│
└── tmdb_dart_test.dart            # Main test suite entry (can be removed)
```

### 4.2 Naming Conventions

- **Test Files**: `<component_name>_test.dart`
- **Mock Files**: Generated by Mockito as `<test_file>.mocks.dart`
- **Fixture Files**: `<endpoint_name>.json`
- **Test Groups**: Match the class/function being tested
- **Test Descriptions**: Start with verb (e.g., "returns", "throws", "handles")

---

## 5. Test Dependencies

### 5.1 Current Dependencies (in pubspec.yaml)
```yaml
dev_dependencies:
  test: ^1.24.0              # Core testing framework
  mockito: ^5.4.4            # Mocking library
  build_runner: ^2.4.8       # Code generation
  build_test: ^3.4.1         # Build system testing
  json_serializable: ^6.7.1  # JSON serialization
  lints: ^6.0.0              # Linting rules
```

### 5.2 Additional Recommended Dependencies

Add these to `pubspec.yaml` dev_dependencies:

```yaml
dev_dependencies:
  # Existing...
  test: ^1.24.0
  mockito: ^5.4.4
  build_runner: ^2.4.8
  
  # Additional for testing
  http_mock_adapter: ^0.6.0   # Mock Dio adapter
  fake_async: ^1.3.1          # Test async/time code
  coverage: ^1.7.0            # Code coverage reports
```

### 5.3 Dependency Justification

- **http_mock_adapter**: Easier Dio response mocking for ApiClient tests
- **fake_async**: Test pagination streams and time-dependent logic
- **coverage**: Generate coverage reports for CI/CD

---

## 6. Coverage Goals

### 6.1 Overall Coverage Targets

| Component Type | Target Coverage | Rationale |
|---------------|-----------------|-----------|
| **Models** | 95%+ | Critical for data integrity; JSON serialization is core functionality |
| **Services** | 90%+ | Business logic layer; must handle all scenarios |
| **Utils** | 95%+ | Reusable utilities; should be thoroughly tested |
| **Core** | 85%+ | Foundation layer; some platform-specific code may be hard to test |
| **Overall** | 85%+ | Industry standard for production libraries |

### 6.2 Critical Coverage Areas

**Must Have 100% Coverage:**
- Exception classes and error handling logic
- JSON serialization (fromJson/toJson) for all models
- Query parameter builders
- Image URL construction

**Can Accept Lower Coverage:**
- Platform-specific cache initialization (ApiClient)
- Conditional imports/dynamic loading
- Deprecated code paths

### 6.3 Coverage Measurement

**Tool**: Use `dart test --coverage` with `coverage` package

**Commands:**
```bash
# Run tests with coverage
dart test --coverage=coverage

# Generate HTML report
dart pub global activate coverage
dart pub global run coverage:format_coverage \
  --lcov \
  --in=coverage \
  --out=coverage/lcov.info \
  --packages=.dart_tool/package_config.json \
  --report-on=lib

# View in browser (requires genhtml from lcov)
genhtml coverage/lcov.info -o coverage/html
```

**CI/CD Integration:**
- Fail builds if coverage drops below 85%
- Track coverage trends over time
- Comment coverage diff on PRs

---

## 7. Testing Workflow

### 7.1 Development Workflow

1. **Write Tests First** (TDD approach recommended):
   - Define expected behavior
   - Write failing test
   - Implement feature
   - Verify test passes

2. **Run Specific Tests During Development**:
   ```bash
   # Run single test file
   dart test test/unit/services/movie_service_test.dart
   
   # Run tests matching pattern
   dart test --name "MovieService"
   ```

3. **Pre-commit Checks**:
   ```bash
   # Run all unit tests
   dart test test/unit
   
   # Check coverage
   dart test --coverage=coverage
   ```

### 7.2 Integration Test Workflow

**Prerequisites**:
- Valid TMDB API key (set as environment variable)
- Network connectivity
- Rate limit awareness

**Setup**:
```dart
// test/integration/integration_test_config.dart
const apiKey = String.fromEnvironment('TMDB_API_KEY');

void skipIfNoApiKey() {
  if (apiKey.isEmpty) {
    throw 'Set TMDB_API_KEY environment variable to run integration tests';
  }
}
```

**Running**:
```bash
# Run integration tests (with API key)
TMDB_API_KEY=your_key dart test test/integration

# Skip integration tests
dart test --exclude-tags=integration
```

### 7.3 Mock Generation

Use Mockito's build_runner to generate mocks:

```bash
# Generate mocks for all test files
dart run build_runner build --delete-conflicting-outputs

# Watch mode (during development)
dart run build_runner watch
```

**Annotation Pattern**:
```dart
import 'package:mockito/annotations.dart';

@GenerateMocks([ApiClient, MovieService])
void main() {
  // Tests using MockApiClient and MockMovieService
}
```

---

## 8. Special Testing Considerations

### 8.1 Async Testing

All service methods are async. Use proper async test patterns:

```dart
test('async method completes successfully', () async {
  final result = await movieService.getDetails(123);
  expect(result.id, 123);
});

test('async method throws exception', () {
  expect(
    () => movieService.getDetails(999),
    throwsA(isA<TmdbNotFoundException>()),
  );
});
```

### 8.2 Stream Testing

`PaginationHelper.autoPaginate` returns a Stream:

```dart
test('autoPaginate emits all items', () async {
  final items = <Movie>[];
  await for (final movie in PaginationHelper.autoPaginate(...)) {
    items.add(movie);
  }
  expect(items.length, greaterThan(0));
});
```

### 8.3 Generic Type Testing

`PaginatedResponse<T>` uses generics:

```dart
test('PaginatedResponse works with different types', () {
  final movieResponse = PaginatedResponse<Movie>.fromJson(json, Movie.fromJson);
  final tvResponse = PaginatedResponse<TvShow>.fromJson(json, TvShow.fromJson);
  
  expect(movieResponse.results, isA<List<Movie>>());
  expect(tvResponse.results, isA<List<TvShow>>());
});
```

### 8.4 Error Scenario Testing

Test all custom exceptions:

```dart
group('Exception Handling', () {
  test('401 throws TmdbAuthenticationException', () { ... });
  test('404 throws TmdbNotFoundException', () { ... });
  test('429 throws TmdbRateLimitException', () { ... });
  test('timeout throws TmdbNetworkException', () { ... });
  test('unknown error throws TmdbNetworkException', () { ... });
});
```

---

## 9. Test Maintenance Guidelines

### 9.1 Test Code Quality

- **DRY Principle**: Extract common setup to `setUp()` and `setUpAll()`
- **Readable Tests**: Use descriptive test names and clear assertions
- **One Assertion Per Test** (when possible): Focus each test on one behavior
- **Avoid Logic in Tests**: Tests should be straightforward and declarative

### 9.2 Fixture Management

- **Keep Fixtures Updated**: When API changes, update JSON fixtures
- **Minimal Fixtures**: Only include fields needed for the test
- **Version Control**: Commit fixtures to git
- **Documentation**: Comment fixtures to explain their purpose

### 9.3 Mock Hygiene

- **Reset Mocks**: Use `reset()` between tests if reusing mock instances
- **Verify Interactions**: Use `verify()` to ensure methods were called
- **Avoid Over-Mocking**: Mock only what's necessary
- **Document Mock Behavior**: Comment complex mock setups

---

## 10. Continuous Integration

### 10.1 CI Pipeline

**Recommended GitHub Actions Workflow**:

```yaml
name: Tests
on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: dart-lang/setup-dart@v1
      
      - name: Install dependencies
        run: dart pub get
      
      - name: Verify formatting
        run: dart format --output=none --set-exit-if-changed .
      
      - name: Analyze project
        run: dart analyze --fatal-infos
      
      - name: Run unit tests
        run: dart test test/unit
      
      - name: Run integration tests
        run: dart test test/integration
        env:
          TMDB_API_KEY: ${{ secrets.TMDB_API_KEY }}
      
      - name: Generate coverage
        run: dart test --coverage=coverage
      
      - name: Upload coverage
        uses: codecov/codecov-action@v3
        with:
          files: coverage/lcov.info
```

### 10.2 Quality Gates

- ✅ All tests must pass
- ✅ Code coverage ≥ 85%
- ✅ No analyzer warnings
- ✅ Code formatted correctly
- ✅ Integration tests pass (with API key)

---

## 11. Future Enhancements

### 11.1 Performance Testing
- Load testing for pagination
- Memory leak detection
- Response time benchmarks

### 11.2 Mutation Testing
- Use `mutation-testing` to verify test quality
- Ensure tests catch real bugs

### 11.3 Contract Testing
- Verify API contract compliance
- Use OpenAPI specs if available

### 11.4 Visual Regression Testing
- If package grows to include UI components
- Screenshot comparison for rendered content

---

## 12. Summary Checklist

Before considering testing complete, verify:

- [ ] All model classes have serialization tests
- [ ] All service methods have unit tests (mocked)
- [ ] All utility functions have unit tests
- [ ] Core components (ApiClient, TmdbClient) have tests
- [ ] Exception handling is thoroughly tested
- [ ] Integration tests cover main workflows
- [ ] Test fixtures are up-to-date
- [ ] Coverage meets 85%+ target
- [ ] CI pipeline is configured
- [ ] Documentation is updated

---

## Appendix: Quick Reference

### Running Tests
```bash
# All tests
dart test

# Unit tests only
dart test test/unit

# Integration tests only
dart test test/integration

# Specific file
dart test test/unit/services/movie_service_test.dart

# With coverage
dart test --coverage=coverage
```

### Generating Mocks
```bash
dart run build_runner build --delete-conflicting-outputs
```

### Coverage Report
```bash
dart test --coverage=coverage
dart pub global run coverage:format_coverage \
  --lcov --in=coverage --out=coverage/lcov.info \
  --packages=.dart_tool/package_config.json --report-on=lib
```

---

**Document Version**: 1.0  
**Last Updated**: 2025-10-03  
**Next Review**: After initial test implementation