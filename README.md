# TMDB Dart Client Library

A Dart client library for The Movie Database (TMDB) API.

## Features

- Type-safe models with JSON serialization
- Comprehensive API coverage
- Modern Dart with null safety
- Well-documented code

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  tmdb_dart: ^0.0.1
```

Then run:

```bash
dart pub get
```

## Usage

```dart
import 'package:tmdb_dart/tmdb_dart.dart';

void main() async {
  // Initialize the client
  final tmdb = TmdbClient(
    apiKey: 'YOUR_API_KEY',
    defaultLanguage: 'en-US',
  );

  // Get popular movies
  final popularMovies = await tmdb.movies.getPopular();
  
  // Print the first movie title
  if (popularMovies.results.isNotEmpty) {
    print(popularMovies.results.first.title);
  }
}
```

## Development

This library uses `json_serializable` for automatic JSON serialization. When modifying model files, you need to run the build runner to generate the serialization code:

```bash
dart run build_runner build
```

Or to watch for changes:

```bash
dart run build_runner watch
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
