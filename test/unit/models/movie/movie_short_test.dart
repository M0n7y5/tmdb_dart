import 'package:test/test.dart';
import 'package:tmdb_dart/src/models/movie/movie_short.dart';

void main() {
  group('MovieShort', () {
    // Sample complete JSON data
    final completeJson = {
      'id': 550,
      'adult': false,
      'backdrop_path': '/fCayJrkfRaCRCTh8GqN30f8oyQF.jpg',
      'poster_path': '/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg',
      'title': 'Fight Club',
      'original_title': 'Fight Club',
      'original_language': 'en',
      'overview':
          'An insomniac office worker and a devil-may-care soapmaker form an underground fight club...',
      'release_date': '1999-10-15',
      'genre_ids': [18, 53],
      'vote_average': 8.4,
      'vote_count': 26280,
      'popularity': 61.416,
      'video': false,
    };

    // Sample JSON with null optional fields
    final jsonWithNulls = {
      'id': 123,
      'adult': true,
      'backdrop_path': null,
      'poster_path': null,
      'title': 'Adult Movie',
      'original_title': 'Adult Movie',
      'original_language': 'en',
      'overview': '',
      'release_date': '',
      'genre_ids': [],
      'vote_average': 5.0,
      'vote_count': 100,
      'popularity': 10.5,
      'video': true,
    };

    // Sample JSON with empty strings and arrays
    final jsonWithEmptyValues = {
      'id': 456,
      'adult': false,
      'backdrop_path': '',
      'poster_path': '',
      'title': 'Empty Movie',
      'original_title': 'Empty Movie',
      'original_language': '',
      'overview': '',
      'release_date': '',
      'genre_ids': [],
      'vote_average': 0.0,
      'vote_count': 0,
      'popularity': 0.0,
      'video': false,
    };

    // Sample JSON with different data types
    final jsonWithDifferentTypes = {
      'id': 789,
      'adult': true,
      'backdrop_path': '/path.jpg',
      'poster_path': '/poster.jpg',
      'title': 'Type Test Movie',
      'original_title': 'Type Test Movie',
      'original_language': 'fr',
      'overview': 'A movie to test different data types',
      'release_date': '2020-01-01',
      'genre_ids': [1, 2, 3, 4, 5],
      'vote_average': 9.9,
      'vote_count': 999999,
      'popularity': 999.999,
      'video': true,
    };

    group('fromJson', () {
      test('should correctly deserialize from JSON with all fields', () {
        // Act
        final movie = MovieShort.fromJson(completeJson);

        // Assert
        expect(movie.id, 550);
        expect(movie.adult, false);
        expect(movie.backdropPath, '/fCayJrkfRaCRCTh8GqN30f8oyQF.jpg');
        expect(movie.posterPath, '/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg');
        expect(movie.title, 'Fight Club');
        expect(movie.originalTitle, 'Fight Club');
        expect(movie.originalLanguage, 'en');
        expect(movie.overview,
            'An insomniac office worker and a devil-may-care soapmaker form an underground fight club...');
        expect(movie.releaseDate, DateTime.parse('1999-10-15'));
        expect(movie.genreIds, [18, 53]);
        expect(movie.voteAverage, 8.4);
        expect(movie.voteCount, 26280);
        expect(movie.popularity, 61.416);
        expect(movie.video, false);
      });

      test('should correctly deserialize from JSON with null optional fields',
          () {
        // Act
        final movie = MovieShort.fromJson(jsonWithNulls);

        // Assert
        expect(movie.id, 123);
        expect(movie.adult, true);
        expect(movie.backdropPath, null);
        expect(movie.posterPath, null);
        expect(movie.title, 'Adult Movie');
        expect(movie.originalTitle, 'Adult Movie');
        expect(movie.originalLanguage, 'en');
        expect(movie.overview, '');
        expect(movie.releaseDate, null); // Empty string should result in null
        expect(movie.genreIds, []);
        expect(movie.voteAverage, 5.0);
        expect(movie.voteCount, 100);
        expect(movie.popularity, 10.5);
        expect(movie.video, true);
      });

      test(
          'should correctly deserialize from JSON with empty strings and arrays',
          () {
        // Act
        final movie = MovieShort.fromJson(jsonWithEmptyValues);

        // Assert
        expect(movie.id, 456);
        expect(movie.adult, false);
        expect(movie.backdropPath,
            ''); // Empty string is preserved, not converted to null
        expect(movie.posterPath,
            ''); // Empty string is preserved, not converted to null
        expect(movie.title, 'Empty Movie');
        expect(movie.originalTitle, 'Empty Movie');
        expect(movie.originalLanguage, '');
        expect(movie.overview, '');
        expect(movie.releaseDate, null); // Empty string should result in null
        expect(movie.genreIds, []);
        expect(movie.voteAverage, 0.0);
        expect(movie.voteCount, 0);
        expect(movie.popularity, 0.0);
        expect(movie.video, false);
      });

      test('should correctly deserialize from JSON with different data types',
          () {
        // Act
        final movie = MovieShort.fromJson(jsonWithDifferentTypes);

        // Assert
        expect(movie.id, 789);
        expect(movie.adult, true);
        expect(movie.backdropPath, '/path.jpg');
        expect(movie.posterPath, '/poster.jpg');
        expect(movie.title, 'Type Test Movie');
        expect(movie.originalTitle, 'Type Test Movie');
        expect(movie.originalLanguage, 'fr');
        expect(movie.overview, 'A movie to test different data types');
        expect(movie.releaseDate, DateTime.parse('2020-01-01'));
        expect(movie.genreIds, [1, 2, 3, 4, 5]);
        expect(movie.voteAverage, 9.9);
        expect(movie.voteCount, 999999);
        expect(movie.popularity, 999.999);
        expect(movie.video, true);
      });

      test('should handle various date formats', () {
        // Arrange
        final jsonWithDifferentDate = Map<String, dynamic>.from(completeJson);

        // Test with different date formats
        final dateFormats = [
          '2020-01-01',
          '1999-12-31',
          '2000-02-29', // Leap year
        ];

        for (final dateFormat in dateFormats) {
          jsonWithDifferentDate['release_date'] = dateFormat;

          // Act
          final movie = MovieShort.fromJson(jsonWithDifferentDate);

          // Assert
          expect(movie.releaseDate, DateTime.parse(dateFormat));
        }
      });

      test('should handle invalid date formats', () {
        // Arrange
        final jsonWithInvalidDate = Map<String, dynamic>.from(completeJson);
        jsonWithInvalidDate['release_date'] = 'invalid-date';

        // Act
        final movie = MovieShort.fromJson(jsonWithInvalidDate);

        // Assert
        expect(movie.releaseDate, null);
      });

      test('should handle boolean fields correctly', () {
        // Arrange
        final jsonWithTrueBools = Map<String, dynamic>.from(completeJson);
        jsonWithTrueBools['adult'] = true;
        jsonWithTrueBools['video'] = true;

        // Act
        final movie = MovieShort.fromJson(jsonWithTrueBools);

        // Assert
        expect(movie.adult, true);
        expect(movie.video, true);
      });

      test('should handle numeric fields with different values', () {
        // Arrange
        final jsonWithDifferentNumbers =
            Map<String, dynamic>.from(completeJson);
        jsonWithDifferentNumbers['id'] = 0;
        jsonWithDifferentNumbers['vote_average'] = 0.0;
        jsonWithDifferentNumbers['vote_count'] = 0;
        jsonWithDifferentNumbers['popularity'] = 0.0;

        // Act
        final movie = MovieShort.fromJson(jsonWithDifferentNumbers);

        // Assert
        expect(movie.id, 0);
        expect(movie.voteAverage, 0.0);
        expect(movie.voteCount, 0);
        expect(movie.popularity, 0.0);
      });

      test('should handle negative numeric values where applicable', () {
        // Arrange
        final jsonWithNegativeNumbers = Map<String, dynamic>.from(completeJson);
        jsonWithNegativeNumbers['vote_average'] = -1.0;
        jsonWithNegativeNumbers['popularity'] = -10.5;

        // Act
        final movie = MovieShort.fromJson(jsonWithNegativeNumbers);

        // Assert
        expect(movie.voteAverage, -1.0);
        expect(movie.popularity, -10.5);
      });

      test('should handle very large numeric values', () {
        // Arrange
        final jsonWithLargeNumbers = Map<String, dynamic>.from(completeJson);
        jsonWithLargeNumbers['id'] = 2147483647; // Max int32
        jsonWithLargeNumbers['vote_count'] = 2147483647;
        jsonWithLargeNumbers['popularity'] = 999999.999;

        // Act
        final movie = MovieShort.fromJson(jsonWithLargeNumbers);

        // Assert
        expect(movie.id, 2147483647);
        expect(movie.voteCount, 2147483647);
        expect(movie.popularity, 999999.999);
      });

      test('should handle genre_ids with various values', () {
        // Arrange
        final jsonWithVariousGenres = Map<String, dynamic>.from(completeJson);
        jsonWithVariousGenres['genre_ids'] = [
          28,
          12,
          16,
          35,
          80,
          99,
          18,
          10751,
          14,
          36,
          27,
          10402,
          9648,
          10749,
          878,
          53,
          10770,
          37
        ];

        // Act
        final movie = MovieShort.fromJson(jsonWithVariousGenres);

        // Assert
        expect(movie.genreIds.length, 18);
        expect(movie.genreIds, contains(28)); // Action
        expect(movie.genreIds, contains(35)); // Comedy
        expect(movie.genreIds, contains(18)); // Drama
      });

      test('should handle missing required fields', () {
        // Arrange
        final jsonWithMissingRequired = Map<String, dynamic>.from(completeJson);
        jsonWithMissingRequired.remove('id');

        // Act & Assert
        expect(() => MovieShort.fromJson(jsonWithMissingRequired),
            throwsA(isA<TypeError>()));
      });
    });

    group('toJson', () {
      test('should correctly serialize to JSON with all fields', () {
        // Arrange
        const movie = MovieShort(
          id: 550,
          adult: false,
          backdropPath: '/fCayJrkfRaCRCTh8GqN30f8oyQF.jpg',
          posterPath: '/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg',
          title: 'Fight Club',
          originalTitle: 'Fight Club',
          originalLanguage: 'en',
          overview:
              'An insomniac office worker and a devil-may-care soapmaker form an underground fight club...',
          releaseDate: null, // Using null to test serialization
          genreIds: [18, 53],
          voteAverage: 8.4,
          voteCount: 26280,
          popularity: 61.416,
          video: false,
        );

        // Act
        final json = movie.toJson();

        // Assert
        expect(json['id'], 550);
        expect(json['adult'], false);
        expect(json['backdrop_path'], '/fCayJrkfRaCRCTh8GqN30f8oyQF.jpg');
        expect(json['poster_path'], '/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg');
        expect(json['title'], 'Fight Club');
        expect(json['original_title'], 'Fight Club');
        expect(json['original_language'], 'en');
        expect(json['overview'],
            'An insomniac office worker and a devil-may-care soapmaker form an underground fight club...');
        expect(json['release_date'], null);
        expect(json['genre_ids'], [18, 53]);
        expect(json['vote_average'], 8.4);
        expect(json['vote_count'], 26280);
        expect(json['popularity'], 61.416);
        expect(json['video'], false);
      });

      test('should correctly serialize to JSON with null optional fields', () {
        // Arrange
        const movie = MovieShort(
          id: 123,
          adult: true,
          backdropPath: null,
          posterPath: null,
          title: 'Adult Movie',
          originalTitle: 'Adult Movie',
          originalLanguage: 'en',
          overview: '',
          releaseDate: null,
          genreIds: [],
          voteAverage: 5.0,
          voteCount: 100,
          popularity: 10.5,
          video: true,
        );

        // Act
        final json = movie.toJson();

        // Assert
        expect(json['id'], 123);
        expect(json['adult'], true);
        expect(json['backdrop_path'], null);
        expect(json['poster_path'], null);
        expect(json['title'], 'Adult Movie');
        expect(json['original_title'], 'Adult Movie');
        expect(json['original_language'], 'en');
        expect(json['overview'], '');
        expect(json['release_date'], null);
        expect(json['genre_ids'], []);
        expect(json['vote_average'], 5.0);
        expect(json['vote_count'], 100);
        expect(json['popularity'], 10.5);
        expect(json['video'], true);
      });

      test('should correctly serialize DateTime to ISO 8601 string', () {
        // Arrange
        const movie = MovieShort(
          id: 456,
          adult: false,
          backdropPath: null,
          posterPath: null,
          title: 'Date Test Movie',
          originalTitle: 'Date Test Movie',
          originalLanguage: 'en',
          overview: 'Testing date serialization',
          releaseDate: null, // Using null to test serialization
          genreIds: [],
          voteAverage: 0.0,
          voteCount: 0,
          popularity: 0.0,
          video: false,
        );

        // Create a non-const version with a date
        final movieWithDate = MovieShort(
          id: 456,
          adult: false,
          backdropPath: null,
          posterPath: null,
          title: 'Date Test Movie',
          originalTitle: 'Date Test Movie',
          originalLanguage: 'en',
          overview: 'Testing date serialization',
          releaseDate: DateTime.parse('2020-01-01'),
          genreIds: [],
          voteAverage: 0.0,
          voteCount: 0,
          popularity: 0.0,
          video: false,
        );

        // Act
        final json = movieWithDate.toJson();

        // Assert
        expect(json['release_date'], '2020-01-01T00:00:00.000');
      });

      test('should correctly serialize boolean fields', () {
        // Arrange
        const movieWithTrueBools = MovieShort(
          id: 789,
          adult: true,
          backdropPath: null,
          posterPath: null,
          title: 'Boolean Test Movie',
          originalTitle: 'Boolean Test Movie',
          originalLanguage: 'en',
          overview: 'Testing boolean serialization',
          releaseDate: null,
          genreIds: [],
          voteAverage: 0.0,
          voteCount: 0,
          popularity: 0.0,
          video: true,
        );

        // Act
        final json = movieWithTrueBools.toJson();

        // Assert
        expect(json['adult'], true);
        expect(json['video'], true);
      });

      test('should correctly serialize numeric fields with various values', () {
        // Arrange
        const movieWithVariousNumbers = MovieShort(
          id: 999,
          adult: false,
          backdropPath: null,
          posterPath: null,
          title: 'Number Test Movie',
          originalTitle: 'Number Test Movie',
          originalLanguage: 'en',
          overview: 'Testing number serialization',
          releaseDate: null,
          genreIds: [],
          voteAverage: 9.9,
          voteCount: 999999,
          popularity: 999.999,
          video: false,
        );

        // Act
        final json = movieWithVariousNumbers.toJson();

        // Assert
        expect(json['id'], 999);
        expect(json['vote_average'], 9.9);
        expect(json['vote_count'], 999999);
        expect(json['popularity'], 999.999);
      });
    });

    group('round-trip', () {
      test(
          'should maintain data integrity through serialization cycle with all fields',
          () {
        // Arrange
        const originalMovie = MovieShort(
          id: 550,
          adult: false,
          backdropPath: '/fCayJrkfRaCRCTh8GqN30f8oyQF.jpg',
          posterPath: '/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg',
          title: 'Fight Club',
          originalTitle: 'Fight Club',
          originalLanguage: 'en',
          overview:
              'An insomniac office worker and a devil-may-care soapmaker form an underground fight club...',
          releaseDate: null,
          genreIds: [18, 53],
          voteAverage: 8.4,
          voteCount: 26280,
          popularity: 61.416,
          video: false,
        );

        // Act
        final json = originalMovie.toJson();
        final deserializedMovie = MovieShort.fromJson(json);

        // Assert
        expect(deserializedMovie.id, originalMovie.id);
        expect(deserializedMovie.adult, originalMovie.adult);
        expect(deserializedMovie.backdropPath, originalMovie.backdropPath);
        expect(deserializedMovie.posterPath, originalMovie.posterPath);
        expect(deserializedMovie.title, originalMovie.title);
        expect(deserializedMovie.originalTitle, originalMovie.originalTitle);
        expect(
            deserializedMovie.originalLanguage, originalMovie.originalLanguage);
        expect(deserializedMovie.overview, originalMovie.overview);
        expect(deserializedMovie.releaseDate, originalMovie.releaseDate);
        expect(deserializedMovie.genreIds, originalMovie.genreIds);
        expect(deserializedMovie.voteAverage, originalMovie.voteAverage);
        expect(deserializedMovie.voteCount, originalMovie.voteCount);
        expect(deserializedMovie.popularity, originalMovie.popularity);
        expect(deserializedMovie.video, originalMovie.video);
      });

      test(
          'should maintain data integrity through serialization cycle with null fields',
          () {
        // Arrange
        const originalMovie = MovieShort(
          id: 123,
          adult: true,
          backdropPath: null,
          posterPath: null,
          title: 'Null Test Movie',
          originalTitle: 'Null Test Movie',
          originalLanguage: 'en',
          overview: '',
          releaseDate: null,
          genreIds: [],
          voteAverage: 5.0,
          voteCount: 100,
          popularity: 10.5,
          video: true,
        );

        // Act
        final json = originalMovie.toJson();
        final deserializedMovie = MovieShort.fromJson(json);

        // Assert
        expect(deserializedMovie.id, originalMovie.id);
        expect(deserializedMovie.adult, originalMovie.adult);
        expect(deserializedMovie.backdropPath, originalMovie.backdropPath);
        expect(deserializedMovie.posterPath, originalMovie.posterPath);
        expect(deserializedMovie.title, originalMovie.title);
        expect(deserializedMovie.originalTitle, originalMovie.originalTitle);
        expect(
            deserializedMovie.originalLanguage, originalMovie.originalLanguage);
        expect(deserializedMovie.overview, originalMovie.overview);
        expect(deserializedMovie.releaseDate, originalMovie.releaseDate);
        expect(deserializedMovie.genreIds, originalMovie.genreIds);
        expect(deserializedMovie.voteAverage, originalMovie.voteAverage);
        expect(deserializedMovie.voteCount, originalMovie.voteCount);
        expect(deserializedMovie.popularity, originalMovie.popularity);
        expect(deserializedMovie.video, originalMovie.video);
      });

      test(
          'should maintain data integrity through serialization cycle with DateTime',
          () {
        // Arrange
        final originalMovie = MovieShort(
          id: 456,
          adult: false,
          backdropPath: null,
          posterPath: null,
          title: 'Date Round-trip Test',
          originalTitle: 'Date Round-trip Test',
          originalLanguage: 'en',
          overview: 'Testing date round-trip',
          releaseDate: DateTime.parse('2020-01-01'),
          genreIds: [28, 12],
          voteAverage: 7.5,
          voteCount: 1500,
          popularity: 25.5,
          video: false,
        );

        // Act
        final json = originalMovie.toJson();
        final deserializedMovie = MovieShort.fromJson(json);

        // Assert
        expect(deserializedMovie.id, originalMovie.id);
        expect(deserializedMovie.releaseDate, originalMovie.releaseDate);
        expect(deserializedMovie.genreIds, originalMovie.genreIds);
      });

      test(
          'should maintain data integrity through serialization cycle with complex data',
          () {
        // Arrange
        final originalMovie = MovieShort(
          id: 789,
          adult: false,
          backdropPath: '/complex_backdrop.jpg',
          posterPath: '/complex_poster.jpg',
          title: 'Complex Round-trip Test',
          originalTitle: 'Complex Round-trip Test Original',
          originalLanguage: 'zh',
          overview: '这是一个复杂的测试，包含各种数据类型和边界值',
          releaseDate: DateTime.parse('2000-02-29'), // Leap year
          genreIds: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
          voteAverage: 9.99,
          voteCount: 999999,
          popularity: 999.999,
          video: true,
        );

        // Act
        final json = originalMovie.toJson();
        final deserializedMovie = MovieShort.fromJson(json);

        // Assert
        expect(deserializedMovie.id, originalMovie.id);
        expect(deserializedMovie.adult, originalMovie.adult);
        expect(deserializedMovie.backdropPath, originalMovie.backdropPath);
        expect(deserializedMovie.posterPath, originalMovie.posterPath);
        expect(deserializedMovie.title, originalMovie.title);
        expect(deserializedMovie.originalTitle, originalMovie.originalTitle);
        expect(
            deserializedMovie.originalLanguage, originalMovie.originalLanguage);
        expect(deserializedMovie.overview, originalMovie.overview);
        expect(deserializedMovie.releaseDate, originalMovie.releaseDate);
        expect(deserializedMovie.genreIds, originalMovie.genreIds);
        expect(deserializedMovie.voteAverage, originalMovie.voteAverage);
        expect(deserializedMovie.voteCount, originalMovie.voteCount);
        expect(deserializedMovie.popularity, originalMovie.popularity);
        expect(deserializedMovie.video, originalMovie.video);
      });
    });

    group('edge cases', () {
      test('should handle empty genre_ids array', () {
        // Arrange
        final jsonWithEmptyGenres = Map<String, dynamic>.from(completeJson);
        jsonWithEmptyGenres['genre_ids'] = [];

        // Act
        final movie = MovieShort.fromJson(jsonWithEmptyGenres);

        // Assert
        expect(movie.genreIds, isEmpty);
      });

      test('should handle single genre_id', () {
        // Arrange
        final jsonWithSingleGenre = Map<String, dynamic>.from(completeJson);
        jsonWithSingleGenre['genre_ids'] = [28];

        // Act
        final movie = MovieShort.fromJson(jsonWithSingleGenre);

        // Assert
        expect(movie.genreIds, [28]);
      });

      test('should handle many genre_ids', () {
        // Arrange
        final jsonWithManyGenres = Map<String, dynamic>.from(completeJson);
        jsonWithManyGenres['genre_ids'] =
            List.generate(50, (index) => index + 1);

        // Act
        final movie = MovieShort.fromJson(jsonWithManyGenres);

        // Assert
        expect(movie.genreIds.length, 50);
        for (int i = 0; i < 50; i++) {
          expect(movie.genreIds[i], i + 1);
        }
      });

      test('should handle special characters in string fields', () {
        // Arrange
        final jsonWithSpecialChars = Map<String, dynamic>.from(completeJson);
        jsonWithSpecialChars['title'] =
            'Movie with special chars: !@#\$%^&*()_+-=[]{}|;:,.<>?';
        jsonWithSpecialChars['original_title'] = 'Original: 电影片名 🎬';
        jsonWithSpecialChars['overview'] =
            'Overview with emojis: 🎭🎪🎨 and unicode: ñáéíóú';

        // Act
        final movie = MovieShort.fromJson(jsonWithSpecialChars);

        // Assert
        expect(movie.title,
            'Movie with special chars: !@#\$%^&*()_+-=[]{}|;:,.<>?');
        expect(movie.originalTitle, 'Original: 电影片名 🎬');
        expect(
            movie.overview, 'Overview with emojis: 🎭🎪🎨 and unicode: ñáéíóú');
      });

      test('should handle very long string fields', () {
        // Arrange
        final longString = 'A' * 1000;
        final jsonWithLongStrings = Map<String, dynamic>.from(completeJson);
        jsonWithLongStrings['title'] = longString;
        jsonWithLongStrings['overview'] = longString;

        // Act
        final movie = MovieShort.fromJson(jsonWithLongStrings);

        // Assert
        expect(movie.title, longString);
        expect(movie.overview, longString);
      });

      test('should handle floating point precision', () {
        // Arrange
        final jsonWithPrecision = Map<String, dynamic>.from(completeJson);
        jsonWithPrecision['vote_average'] = 8.433333333333334;
        jsonWithPrecision['popularity'] = 61.416000000000004;

        // Act
        final movie = MovieShort.fromJson(jsonWithPrecision);

        // Assert
        expect(movie.voteAverage, 8.433333333333334);
        expect(movie.popularity, 61.416000000000004);
      });
    });
  });
}
