# Integration Tests Documentation

## 📋 Overview

Integration tests in the TMDB Dart library validate the functionality of all service classes against the real TMDB API. Unlike unit tests that use mock data, integration tests make actual HTTP requests to TMDB's servers to ensure our library works correctly with the live API.

These tests verify:
- Correct API request formatting
- Proper response parsing
- Error handling
- Data model validation
- Rate limiting behavior

## 🔑 Prerequisites

### Getting a TMDB API Key

To run the integration tests, you need a valid TMDB API key. Follow these steps:

1. **Create a TMDB Account** (if you don't have one):
   - Visit [https://www.themoviedb.org/signup](https://www.themoviedb.org/signup)
   - Fill out the registration form
   - Verify your email address

2. **Request an API Key**:
   - Go to [https://www.themoviedb.org/settings/api](https://www.themoviedb.org/settings/api)
   - Click on "Request an API Key"
   - Select "Developer" as the type
   - Fill in the required information:
     - Application Name: `TMDB Dart Library Testing`
     - Application URL: `https://github.com/yourusername/tmdb_dart`
     - Description: `Testing the TMDB Dart library integration`
   - Accept the terms of use
   - Submit the request

3. **Copy Your API Key**:
   - Once approved, your API key will be displayed on the API settings page
   - Keep this key secure and don't commit it to version control

> **Note**: The free tier is sufficient for running integration tests. It provides 40 requests per 10 seconds, which is adequate for our test suite.

## 🚀 Running Tests

### Running All Integration Tests

#### Using dart-define (Recommended):
```bash
dart test test/integration/ --dart-define=TMDB_API_KEY=your_api_key_here
```

#### Using Environment Variable:
```bash
TMDB_API_KEY=your_api_key_here dart test test/integration/
```

### Running Specific Test Files

#### Configuration Service Tests:
```bash
dart test test/integration/configuration_service_integration_test.dart --dart-define=TMDB_API_KEY=your_api_key_here
```

#### Movie Service Tests:
```bash
dart test test/integration/movie_service_integration_test.dart --dart-define=TMDB_API_KEY=your_api_key_here
```

#### TV Service Tests:
```bash
dart test test/integration/tv_service_integration_test.dart --dart-define=TMDB_API_KEY=your_api_key_here
```

#### Person Service Tests:
```bash
dart test test/integration/person_service_integration_test.dart --dart-define=TMDB_API_KEY=your_api_key_here
```

#### Search Service Tests:
```bash
dart test test/integration/search_service_integration_test.dart --dart-define=TMDB_API_KEY=your_api_key_here
```

### Running Tests with Tags

All integration tests are tagged with `integration`. You can run them using:

```bash
dart test --tags=integration --dart-define=TMDB_API_KEY=your_api_key_here
```

### Running Tests with Verbose Output

```bash
dart test test/integration/ --dart-define=TMDB_API_KEY=your_api_key_here -v
```

## 📊 Test Coverage

| Service | Test File | Number of Tests | Key Methods Tested |
|---------|-----------|-----------------|-------------------|
| Configuration | `configuration_service_integration_test.dart` | 8 | API configuration, genres, countries, languages, jobs, timezones, translations |
| Movie | `movie_service_integration_test.dart` | 17 | Details, popular, now playing, top rated, credits, images, videos, upcoming, reviews, keywords, similar, recommendations, external IDs, watch providers, alternative titles |
| TV | `tv_service_integration_test.dart` | 20 | Details, popular, on the air, airing today, top rated, credits, images, videos, keywords, similar, recommendations, external IDs, watch providers, alternative titles, seasons, episodes |
| Person | `person_service_integration_test.dart` | 10 | Details, movie credits, TV credits, combined credits, external IDs, images, tagged images, translations, popular |
| Search | `search_service_integration_test.dart` | 9 | Multi search, movies, TV shows, people, keywords, companies, collections |
| **Total** | **5 files** | **64 tests** | **All major API endpoints** |

## 📁 Test Structure

```
test/integration/
├── README.md                           # This documentation
├── config/
│   └── integration_test_config.dart    # API key configuration management
├── helpers/
│   ├── integration_test_helper.dart    # Reusable test utilities
│   └── known_test_ids.dart             # Stable test data IDs
├── configuration_service_integration_test.dart
├── movie_service_integration_test.dart
├── tv_service_integration_test.dart
├── person_service_integration_test.dart
└── search_service_integration_test.dart
```

### Directory Components

- **config/**: Contains configuration management for API keys
- **helpers/**: Reusable utilities and known test data
  - `integration_test_helper.dart`: Common validation methods and rate limiting
  - `known_test_ids.dart`: Stable IDs for reliable testing (e.g., Inception, Breaking Bad)
- **Test files**: Individual test suites for each service

### Known Test IDs

We use well-known, stable entities for testing to ensure reliability:

- **Movies**: The Shawshank Redemption (278), Inception (27205), The Dark Knight (155)
- **TV Shows**: Breaking Bad (1396), Game of Thrones (1399), Friends (1668)
- **People**: Tom Hanks (31), Morgan Freeman (192), Leonardo DiCaprio (6193)

## ⚠️ Important Notes

### Rate Limiting
- TMDB API allows **40 requests per 10 seconds**
- Tests include automatic delays between requests to respect this limit
- Full test suite takes approximately 2-3 minutes to complete

### Test Execution Time
- Individual tests: 5-30 seconds each
- Full test suite: 2-3 minutes
- Time varies based on network conditions and API response times

### Network Dependency
- Tests require an active internet connection
- Tests may fail due to network issues or TMDB API downtime
- Each test has a 30-second timeout

### Test Data Stability
- We use well-known entities that are unlikely to be removed
- However, TMDB may update or modify data, which could cause test failures
- Tests focus on structure validation rather than exact data values

### Potential Failures
- API changes by TMDB may break tests
- Rate limiting may cause temporary failures
- Network connectivity issues
- Invalid or expired API keys

## 🔄 CI/CD Integration

### GitHub Actions Example

```yaml
name: Integration Tests

on:
  schedule:
    # Run daily at 2 AM UTC
    - cron: '0 2 * * *'
  workflow_dispatch:  # Allow manual triggering

jobs:
  integration-tests:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Setup Dart
      uses: dart-lang/setup-dart@v1
      with:
        sdk: stable
    
    - name: Install dependencies
      run: dart pub get
    
    - name: Run integration tests
      run: dart test test/integration/ --dart-define=TMDB_API_KEY=${{ secrets.TMDB_API_KEY }}
      env:
        TMDB_API_KEY: ${{ secrets.TMDB_API_KEY }}
```

### Setting Up Secrets

1. In your GitHub repository, go to **Settings** > **Secrets and variables** > **Actions**
2. Click **New repository secret**
3. Name: `TMDB_API_KEY`
4. Value: Your actual TMDB API key
5. Click **Add secret**

### CI/CD Best Practices

- **Schedule tests** rather than running on every commit to avoid rate limits
- Use **workflow_dispatch** to allow manual triggering when needed
- Consider running integration tests only on **main branch** updates
- Monitor test execution time to avoid exceeding CI/CD time limits

## 🔧 Troubleshooting

### Common Issues and Solutions

#### API Key Validation Errors
```
Error: 401 Unauthorized
```
**Solution**: 
- Verify your API key is correct
- Ensure your API key is approved and active
- Check if you've exceeded your rate limit

#### Rate Limit Errors
```
Error: 429 Too Many Requests
```
**Solution**:
- Wait a few minutes before retrying
- Ensure tests are using rate limit delays
- Check if other applications are using the same API key

#### Network Connectivity Issues
```
SocketException: Connection refused
```
**Solution**:
- Check your internet connection
- Verify firewall settings
- Try running tests again after a short delay

#### Test Timeouts
```
Test timed out after 30 seconds
```
**Solution**:
- Check network speed
- Verify TMDB API status
- Consider increasing timeout values for slow connections

#### SSL/TLS Errors
```
HandshakeException
```
**Solution**:
- Update your Dart SDK to the latest version
- Check system date and time settings
- Verify your network's SSL/TLS configuration

### Debugging Tips

1. **Run with verbose output**:
   ```bash
   dart test test/integration/ --dart-define=TMDB_API_KEY=your_key -v
   ```

2. **Run a single test file** to isolate issues:
   ```bash
   dart test test/integration/configuration_service_integration_test.dart --dart-define=TMDB_API_KEY=your_key
   ```

3. **Check TMDB API status**:
   - Visit [https://www.themoviedb.org/documentation/api/status](https://www.themoviedb.org/documentation/api/status)
   - Check for any ongoing issues or maintenance

4. **Verify API key permissions**:
   - Ensure your key has the required permissions
   - Check if your key has been suspended or revoked

### Getting Help

If you encounter persistent issues:

1. Check the [TMDB API Documentation](https://developers.themoviedb.org/3)
2. Review the [TMDB API Support](https://www.themoviedb.org/talk/category/50479515cd3a972ee8000031)
3. Open an issue on the GitHub repository with:
   - Error messages
   - Test output
   - Your Dart SDK version
   - Operating system information