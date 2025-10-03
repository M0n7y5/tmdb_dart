# TMDB Dart Client Library

A comprehensive Dart client library for The Movie Database (TMDB) API, providing type-safe models and full coverage of TMDB's API endpoints.

## Features

- ✅ **Type-safe models** with JSON serialization
- ✅ **Comprehensive API coverage** for movies, TV shows, people, search, and configuration
- ✅ **Modern Dart** with null safety
- ✅ **Pagination helpers** for easy navigation through large result sets
- ✅ **Image URL building** utilities for constructing image URLs
- ✅ **Query parameter builders** for consistent API requests
- ✅ **Well-documented code** with comprehensive examples
- ✅ **Error handling** with custom exception types
- ✅ **Integration tests** against the live TMDB API

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  tmdb_dart: ^0.1.0
```

Then run:

```bash
dart pub get
```

## API Key Setup

Before using the library, you need to obtain a TMDB API key:

1. Create a TMDB account at [https://www.themoviedb.org/signup](https://www.themoviedb.org/signup)
2. Request an API key at [https://www.themoviedb.org/settings/api](https://www.themoviedb.org/settings/api)
3. Select "Developer" as the type and fill in the required information
4. Copy your API key (Bearer token) for use in the library

## Quick Start

```dart
import 'package:tmdb_dart/tmdb_dart.dart';

void main() async {
  // Initialize the client
  final tmdb = TmdbClient(
    apiKey: 'YOUR_API_KEY', // Use your actual API key here
  );

  try {
    // Get popular movies
    final popularMovies = await tmdb.movies.getPopular();
    
    // Print the first movie title
    if (popularMovies.results.isNotEmpty) {
      print(popularMovies.results.first.title);
    }

    // Get details for a specific movie
    final movieDetails = await tmdb.movies.getDetails(550); // Fight Club
    print('Movie: ${movieDetails.title}');
    print('Overview: ${movieDetails.overview}');
    print('Rating: ${movieDetails.voteAverage}/10');
  } catch (e) {
    print('Error: $e');
  } finally {
    // Close the client when done
    await tmdb.close();
  }
}
```

## Available Services

The TMDB Dart library provides access to the following services:

- **Movie Service** (`tmdb.movies`) - Access movie-related endpoints
- **TV Service** (`tmdb.tv`) - Access TV show-related endpoints
- **Person Service** (`tmdb.people`) - Access person-related endpoints
- **Search Service** (`tmdb.search`) - Search across movies, TV shows, and people
- **Configuration Service** (`tmdb.configuration`) - API configuration and reference data

## Movie Service Examples

### Getting Movie Lists

```dart
// Get popular movies
final popularMovies = await tmdb.movies.getPopular(page: 1);

// Get now playing movies
final nowPlaying = await tmdb.movies.getNowPlaying();

// Get top rated movies
final topRated = await tmdb.movies.getTopRated();

// Get upcoming movies
final upcoming = await tmdb.movies.getUpcoming();
```

### Getting Movie Details

```dart
// Get detailed information about a movie
final movie = await tmdb.movies.getDetails(
  550, // Movie ID
  language: 'en-US',
  appendToResponse: ['credits', 'videos', 'images'],
);

print('Title: ${movie.title}');
print('Release Date: ${movie.releaseDate}');
print('Runtime: ${movie.runtime} minutes');
print('Genres: ${movie.genres.map((g) => g.name).join(', ')}');
```

### Getting Movie Credits

```dart
// Get cast and crew for a movie
final credits = await tmdb.movies.getCredits(550);

print('Cast:');
for (final cast in credits.cast.take(5)) {
  print('${cast.name} as ${cast.character}');
}

print('\nCrew:');
for (final crew in credits.crew.take(5)) {
  print('${crew.name} - ${crew.job}');
}
```

### Getting Movie Images and Videos

```dart
// Get movie images
final images = await tmdb.movies.getImages(550);
print('Found ${images.length} images');

// Get movie videos
final videos = await tmdb.movies.getVideos(550);
for (final video in videos) {
  print('${video.name} (${video.type}): https://www.youtube.com/watch?v=${video.key}');
}
```

### Getting Similar and Recommended Movies

```dart
// Get similar movies
final similar = await tmdb.movies.getSimilar(550);

// Get recommended movies
final recommendations = await tmdb.movies.getRecommendations(550);

print('Similar movies:');
for (final movie in similar.results.take(5)) {
  print(movie.title);
}
```

## TV Service Examples

### Getting TV Show Lists

```dart
// Get popular TV shows
final popularShows = await tmdb.tv.getPopular();

// Get TV shows airing today
final airingToday = await tmdb.tv.getAiringToday();

// Get TV shows on the air
final onTheAir = await tmdb.tv.getOnTheAir();

// Get top rated TV shows
final topRatedShows = await tmdb.tv.getTopRated();
```

### Getting TV Show Details

```dart
// Get detailed information about a TV show
final tvShow = await tmdb.tv.getDetails(
  1396, // Breaking Bad
  language: 'en-US',
  appendToResponse: ['credits', 'videos'],
);

print('Title: ${tvShow.name}');
print('First Air Date: ${tvShow.firstAirDate}');
print('Number of Seasons: ${tvShow.numberOfSeasons}');
print('Number of Episodes: ${tvShow.numberOfEpisodes}');
```

### Getting Season and Episode Details

```dart
// Get season details
final season = await tmdb.tv.getSeasonDetails(1396, 1); // Breaking Bad, Season 1
print('Season ${season.seasonNumber}: ${season.name}');
print('Episodes: ${season.episodes.length}');

// Get episode details
final episode = await tmdb.tv.getEpisodeDetails(1396, 1, 1); // Breaking Bad, S01E01
print('Episode ${episode.episodeNumber}: ${episode.name}');
print('Overview: ${episode.overview}');
```

## Person Service Examples

### Getting Popular People

```dart
// Get popular people
final popularPeople = await tmdb.people.getPopular();

for (final person in popularPeople.results.take(5)) {
  print('${person.name} - Known for: ${person.knownForDepartment}');
}
```

### Getting Person Details

```dart
// Get detailed information about a person
final person = await tmdb.people.getDetails(
  31, // Tom Hanks
  language: 'en-US',
);

print('Name: ${person.name}');
print('Birthday: ${person.birthday}');
print('Place of Birth: ${person.placeOfBirth}');
print('Biography: ${person.biography}');
```

### Getting Person Credits

```dart
// Get combined movie and TV credits
final combinedCredits = await tmdb.people.getCombinedCredits(31);

print('Movie Credits:');
for (final credit in combinedCredits.cast.take(5)) {
  if (credit.mediaType == 'movie') {
    print('${credit.title} as ${credit.character}');
  }
}

// Get only movie credits
final movieCredits = await tmdb.people.getMovieCredits(31);

// Get only TV credits
final tvCredits = await tmdb.people.getTvCredits(31);
```

## Search Service Examples

### Searching Movies

```dart
// Search for movies
final movieResults = await tmdb.search.searchMovies(
  'inception',
  language: 'en-US',
  page: 1,
  includeAdult: false,
  year: 2010,
);

print('Found ${movieResults.totalResults} movies');
for (final movie in movieResults.results) {
  print('${movie.title} (${movie.releaseDate})');
}
```

### Searching TV Shows

```dart
// Search for TV shows
final tvResults = await tmdb.search.searchTvShows(
  'breaking bad',
  language: 'en-US',
  firstAirDateYear: 2008,
);

print('Found ${tvResults.totalResults} TV shows');
for (final show in tvResults.results) {
  print('${show.name} (${show.firstAirDate})');
}
```

### Searching People

```dart
// Search for people
final peopleResults = await tmdb.search.searchPeople(
  'tom hanks',
  language: 'en-US',
);

for (final person in peopleResults.results) {
  print('${person.name} - Known for: ${person.knownForDepartment}');
}
```

### Multi-Search

```dart
// Search across multiple content types
final multiResults = await tmdb.search.searchMulti(
  'avatar',
  language: 'en-US',
);

for (final result in multiResults.results) {
  switch (result['media_type']) {
    case 'movie':
      print('Movie: ${result['title']}');
      break;
    case 'tv':
      print('TV Show: ${result['name']}');
      break;
    case 'person':
      print('Person: ${result['name']}');
      break;
  }
}
```

## Configuration Service Examples

### Getting API Configuration

```dart
// Get API configuration
final config = await tmdb.configuration.getApiConfiguration();

print('Image Base URL: ${config.images.secureBaseUrl}');
print('Poster Sizes: ${config.images.posterSizes.join(', ')}');
print('Backdrop Sizes: ${config.images.backdropSizes.join(', ')}');
```

### Building Image URLs

```dart
// Get configuration first
final config = await tmdb.configuration.getApiConfiguration();
final imageBuilder = ImageUrlBuilder(config);

// Build image URLs
final posterUrl = imageBuilder.buildPosterUrl(
  '/path/to/poster.jpg',
  size: PosterSize.w500,
);

final backdropUrl = imageBuilder.buildBackdropUrl(
  '/path/to/backdrop.jpg',
  size: BackdropSize.w1280,
);

print('Poster URL: $posterUrl');
print('Backdrop URL: $backdropUrl');
```

### Getting Reference Data

```dart
// Get movie genres
final movieGenres = await tmdb.configuration.getMovieGenres();
print('Movie Genres:');
for (final genre in movieGenres) {
  print('${genre.id}: ${genre.name}');
}

// Get TV genres
final tvGenres = await tmdb.configuration.getTvGenres();

// Get countries
final countries = await tmdb.configuration.getCountries();

// Get languages
final languages = await tmdb.configuration.getLanguages();
```

## Pagination Helpers

The library provides utilities to handle pagination easily:

### Using Auto-Paginate Stream

```dart
// Stream all popular movies (automatically handles pagination)
final movieStream = PaginationHelper.autoPaginate<Movie>(
  fetcher: (page) => tmdb.movies.getPopular(page: page),
  maxPages: 5, // Optional limit
);

await for (final movie in movieStream) {
  print(movie.title);
}
```

### Using Fetch All Pages

```dart
// Get all pages at once
final allMovies = await PaginationHelper.fetchAllPages<Movie>(
  fetcher: (page) => tmdb.movies.getPopular(page: page),
  maxPages: 3, // Optional limit
);

print('Fetched ${allMovies.length} movies');
```

## Advanced Usage

### Custom Query Parameters

```dart
// All methods accept optional parameters
final movies = await tmdb.movies.getPopular(
  language: 'en-US',
  page: 1,
  region: 'US',
);

// Search with multiple filters
final searchResults = await tmdb.search.searchMovies(
  'batman',
  language: 'en-US',
  page: 1,
  includeAdult: false,
  region: 'US',
  year: 2022,
  primaryReleaseYear: 2022,
);
```

### Append to Response

```dart
// Reduce API calls by appending additional data
final movie = await tmdb.movies.getDetails(
  550,
  appendToResponse: ['credits', 'videos', 'images', 'similar'],
);

// All requested data is now available in the response
print('Director: ${movie.credits?.crew.firstWhere((c) => c.job == 'Director').name}');
print('Videos: ${movie.videos?.results.length ?? 0}');
```

## Error Handling

The library provides proper error handling with custom exceptions:

```dart
try {
  final movie = await tmdb.movies.getDetails(999999); // Non-existent ID
} on ApiException catch (e) {
  print('API Error: ${e.message}');
  print('Status Code: ${e.statusCode}');
} catch (e) {
  print('Unexpected error: $e');
}
```

## Development Setup

### Building the Library

This library uses `json_serializable` for automatic JSON serialization. When modifying model files, you need to run the build runner to generate the serialization code:

```bash
# Run once
dart run build_runner build

# Or watch for changes
dart run build_runner watch

# To delete existing generated files
dart run build_runner clean
```

### Running Tests

The library includes both unit tests and integration tests:

```bash
# Run all tests
dart test

# Run only unit tests
dart test test/unit/

# Run integration tests (requires API key)
dart test test/integration/ --dart-define=TMDB_API_KEY=your_api_key_here
```

For more information on integration tests, see [test/integration/README.md](test/integration/README.md).

## API Coverage

The library provides comprehensive coverage of the TMDB API:

### Movie Endpoints
- ✅ Get Details
- ✅ Get Popular
- ✅ Get Now Playing
- ✅ Get Top Rated
- ✅ Get Upcoming
- ✅ Get Credits
- ✅ Get Images
- ✅ Get Videos
- ✅ Get Reviews
- ✅ Get Keywords
- ✅ Get Similar
- ✅ Get Recommendations
- ✅ Get External IDs
- ✅ Get Watch Providers
- ✅ Get Alternative Titles

### TV Endpoints
- ✅ Get Details
- ✅ Get Popular
- ✅ Get Airing Today
- ✅ Get On The Air
- ✅ Get Top Rated
- ✅ Get Credits
- ✅ Get Images
- ✅ Get Videos
- ✅ Get Reviews
- ✅ Get Keywords
- ✅ Get Similar
- ✅ Get Recommendations
- ✅ Get External IDs
- ✅ Get Watch Providers
- ✅ Get Alternative Titles
- ✅ Get Season Details
- ✅ Get Season Credits
- ✅ Get Episode Details
- ✅ Get Episode Credits
- ✅ Get Content Ratings

### Person Endpoints
- ✅ Get Details
- ✅ Get Popular
- ✅ Get Combined Credits
- ✅ Get Movie Credits
- ✅ Get TV Credits
- ✅ Get Images
- ✅ Get External IDs

### Search Endpoints
- ✅ Search Movies
- ✅ Search TV Shows
- ✅ Search People
- ✅ Search Multi
- ✅ Search Companies
- ✅ Search Collections
- ✅ Search Keywords

### Configuration Endpoints
- ✅ Get API Configuration
- ✅ Get Movie Genres
- ✅ Get TV Genres
- ✅ Get Countries
- ✅ Get Languages
- ✅ Get Jobs
- ✅ Get Timezones
- ✅ Get Primary Translations

## Model Types

The library includes type-safe models for all API responses:

### Common Models
- `PaginatedResponse<T>` - Paginated API responses
- `TmdbImage` - Image information
- `Video` - Video/trailer information
- `Genre` - Genre information
- `Keyword` - Keyword information
- `ExternalIds` - External service IDs
- `ProductionCompany` - Production company details
- `ProductionCountry` - Production country details
- `SpokenLanguage` - Spoken language details

### Movie Models
- `Movie` - Full movie details
- `MovieShort` - Basic movie information

### TV Models
- `TvShow` - Full TV show details
- `TvShowShort` - Basic TV show information
- `Season` - Season details
- `Episode` - Episode details

### Person Models
- `Person` - Full person details
- `PersonShort` - Basic person information
- `PersonCredits` - Person's credits

### Credits Models
- `Credits` - Cast and crew information
- `Cast` - Cast member details
- `Crew` - Crew member details

### Configuration Models
- `ApiConfiguration` - API configuration
- `Country` - Country information
- `Language` - Language information

### Additional Models
- `Review` - Review information
- `WatchProvider` - Watch provider details
- `WatchProvidersResult` - Watch provider results

## Links

- [TMDB API Documentation](https://developers.themoviedb.org/3)
- [TMDB API Terms of Use](https://www.themoviedb.org/documentation/api/terms-of-use)
- [TMDB API Rate Limits](https://developers.themoviedb.org/3/getting-started/request-rate-limiting)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
