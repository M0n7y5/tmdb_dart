import 'package:test/test.dart';
import 'package:tmdb_dart/src/models/movie/movie.dart';
import 'package:tmdb_dart/src/models/common/genre.dart';
import 'package:tmdb_dart/src/models/common/production_company.dart';
import 'package:tmdb_dart/src/models/common/production_country.dart';
import 'package:tmdb_dart/src/models/common/spoken_language.dart';

void main() {
  group('Movie', () {
    // Sample nested objects
    const genre1 = Genre(id: 28, name: 'Action');
    const genre2 = Genre(id: 18, name: 'Drama');
    const genre3 = Genre(id: 53, name: 'Thriller');

    const productionCompany1 = ProductionCompany(
      id: 420,
      name: 'Marvel Studios',
      logoPath: '/hUzeosd33nzE5MCNsZxCGEKTXaQ.png',
      originCountry: 'US',
    );

    const productionCompany2 = ProductionCompany(
      id: 174,
      name: 'Warner Bros. Pictures',
      logoPath: '/kyEe0cTwOCXMMlEuBtq8X1FNPEk.png',
      originCountry: 'US',
    );

    const productionCountry1 = ProductionCountry(
      iso31661: 'US',
      name: 'United States of America',
    );

    const productionCountry2 = ProductionCountry(
      iso31661: 'GB',
      name: 'United Kingdom',
    );

    const spokenLanguage1 = SpokenLanguage(
      iso6391: 'en',
      name: 'English',
      englishName: 'English',
    );

    const spokenLanguage2 = SpokenLanguage(
      iso6391: 'es',
      name: 'Español',
      englishName: 'Spanish',
    );

    const movieCollection = MovieCollection(
      id: 123,
      name: 'The Avengers Collection',
      posterPath: '/4TOWiT7K1d2G2ZTw2g5rLhrFNpe.jpg',
      backdropPath: '/hBNWRJvjwE9C5A9EN2aWXGS5d5p.jpg',
    );

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
      'tagline': 'Mischief. Mayhem. Soap.',
      'release_date': '1999-10-15',
      'genres': [
        {'id': 18, 'name': 'Drama'},
        {'id': 53, 'name': 'Thriller'},
      ],
      'budget': 63000000,
      'revenue': 100853753,
      'runtime': 139,
      'vote_average': 8.4,
      'vote_count': 26280,
      'popularity': 61.416,
      'video': false,
      'homepage': 'https://www.foxmovies.com/movies/fight-club',
      'imdb_id': 'tt0137523',
      'status': 'Released',
      'production_companies': [
        {
          'id': 420,
          'name': 'Marvel Studios',
          'logo_path': '/hUzeosd33nzE5MCNsZxCGEKTXaQ.png',
          'origin_country': 'US',
        },
        {
          'id': 174,
          'name': 'Warner Bros. Pictures',
          'logo_path': '/kyEe0cTwOCXMMlEuBtq8X1FNPEk.png',
          'origin_country': 'US',
        },
      ],
      'production_countries': [
        {'iso_3166_1': 'US', 'name': 'United States of America'},
        {'iso_3166_1': 'GB', 'name': 'United Kingdom'},
      ],
      'spoken_languages': [
        {'iso_639_1': 'en', 'name': 'English', 'english_name': 'English'},
        {'iso_639_1': 'es', 'name': 'Español', 'english_name': 'Spanish'},
      ],
      'belongs_to_collection': {
        'id': 123,
        'name': 'The Avengers Collection',
        'poster_path': '/4TOWiT7K1d2G2ZTw2g5rLhrFNpe.jpg',
        'backdrop_path': '/hBNWRJvjwE9C5A9EN2aWXGS5d5p.jpg',
      },
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
      'tagline': null,
      'release_date': '',
      'genres': [],
      'budget': 0,
      'revenue': 0,
      'runtime': null,
      'vote_average': 5.0,
      'vote_count': 100,
      'popularity': 10.5,
      'video': true,
      'homepage': null,
      'imdb_id': null,
      'status': null,
      'production_companies': [],
      'production_countries': [],
      'spoken_languages': [],
      'belongs_to_collection': null,
    };

    // Sample JSON with empty arrays and strings
    final jsonWithEmptyValues = {
      'id': 456,
      'adult': false,
      'backdrop_path': null,
      'poster_path': null,
      'title': 'Empty Movie',
      'original_title': 'Empty Movie',
      'original_language': '',
      'overview': '',
      'tagline': '',
      'release_date': null,
      'genres': [],
      'budget': 0,
      'revenue': 0,
      'runtime': null,
      'vote_average': 0.0,
      'vote_count': 0,
      'popularity': 0.0,
      'video': false,
      'homepage': null,
      'imdb_id': null,
      'status': '',
      'production_companies': [],
      'production_countries': [],
      'spoken_languages': [],
      'belongs_to_collection': null,
    };

    group('fromJson', () {
      test('should correctly deserialize from JSON with all fields', () {
        // Act
        final movie = Movie.fromJson(completeJson);

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
        expect(movie.tagline, 'Mischief. Mayhem. Soap.');
        expect(movie.releaseDate, DateTime.parse('1999-10-15'));
        expect(movie.genres.length, 2);
        expect(movie.genres[0].id, 18);
        expect(movie.genres[0].name, 'Drama');
        expect(movie.genres[1].id, 53);
        expect(movie.genres[1].name, 'Thriller');
        expect(movie.budget, 63000000);
        expect(movie.revenue, 100853753);
        expect(movie.runtime, 139);
        expect(movie.voteAverage, 8.4);
        expect(movie.voteCount, 26280);
        expect(movie.popularity, 61.416);
        expect(movie.video, false);
        expect(movie.homepage, 'https://www.foxmovies.com/movies/fight-club');
        expect(movie.imdbId, 'tt0137523');
        expect(movie.status, 'Released');
        expect(movie.productionCompanies.length, 2);
        expect(movie.productionCompanies[0].id, 420);
        expect(movie.productionCompanies[0].name, 'Marvel Studios');
        expect(movie.productionCompanies[1].id, 174);
        expect(movie.productionCompanies[1].name, 'Warner Bros. Pictures');
        expect(movie.productionCountries.length, 2);
        expect(movie.productionCountries[0].iso31661, 'US');
        expect(movie.productionCountries[0].name, 'United States of America');
        expect(movie.productionCountries[1].iso31661, 'GB');
        expect(movie.productionCountries[1].name, 'United Kingdom');
        expect(movie.spokenLanguages.length, 2);
        expect(movie.spokenLanguages[0].iso6391, 'en');
        expect(movie.spokenLanguages[0].name, 'English');
        expect(movie.spokenLanguages[0].englishName, 'English');
        expect(movie.spokenLanguages[1].iso6391, 'es');
        expect(movie.spokenLanguages[1].name, 'Español');
        expect(movie.spokenLanguages[1].englishName, 'Spanish');
        expect(movie.belongsToCollection, isNotNull);
        expect(movie.belongsToCollection!.id, 123);
        expect(movie.belongsToCollection!.name, 'The Avengers Collection');
      });

      test('should correctly deserialize from JSON with null optional fields',
          () {
        // Act
        final movie = Movie.fromJson(jsonWithNulls);

        // Assert
        expect(movie.id, 123);
        expect(movie.adult, true);
        expect(movie.backdropPath, null);
        expect(movie.posterPath, null);
        expect(movie.title, 'Adult Movie');
        expect(movie.originalTitle, 'Adult Movie');
        expect(movie.originalLanguage, 'en');
        expect(movie.overview, '');
        expect(movie.tagline, null);
        expect(movie.releaseDate, null); // Empty string should result in null
        expect(movie.genres, isEmpty);
        expect(movie.budget, 0);
        expect(movie.revenue, 0);
        expect(movie.runtime, null);
        expect(movie.voteAverage, 5.0);
        expect(movie.voteCount, 100);
        expect(movie.popularity, 10.5);
        expect(movie.video, true);
        expect(movie.homepage, null);
        expect(movie.imdbId, null);
        expect(movie.status, null);
        expect(movie.productionCompanies, isEmpty);
        expect(movie.productionCountries, isEmpty);
        expect(movie.spokenLanguages, isEmpty);
        expect(movie.belongsToCollection, null);
      });

      test(
          'should correctly deserialize from JSON with empty arrays and strings',
          () {
        // Act
        final movie = Movie.fromJson(jsonWithEmptyValues);

        // Assert
        expect(movie.id, 456);
        expect(movie.adult, false);
        expect(movie.backdropPath, null); // Empty string should result in null
        expect(movie.posterPath, null); // Empty string should result in null
        expect(movie.title, 'Empty Movie');
        expect(movie.originalTitle, 'Empty Movie');
        expect(movie.originalLanguage, '');
        expect(movie.overview, '');
        expect(movie.tagline, '');
        expect(movie.releaseDate, null); // Empty string should result in null
        expect(movie.genres, isEmpty);
        expect(movie.budget, 0);
        expect(movie.revenue, 0);
        expect(movie.runtime, null);
        expect(movie.voteAverage, 0.0);
        expect(movie.voteCount, 0);
        expect(movie.popularity, 0.0);
        expect(movie.video, false);
        expect(movie.homepage, null); // Empty string should result in null
        expect(movie.imdbId, null); // Empty string should result in null
        expect(movie.status, '');
        expect(movie.productionCompanies, isEmpty);
        expect(movie.productionCountries, isEmpty);
        expect(movie.spokenLanguages, isEmpty);
        expect(movie.belongsToCollection, null);
      });

      test('should correctly deserialize nested Genre objects', () {
        // Arrange
        final jsonWithManyGenres = Map<String, dynamic>.from(completeJson);
        jsonWithManyGenres['genres'] = [
          {'id': 28, 'name': 'Action'},
          {'id': 12, 'name': 'Adventure'},
          {'id': 16, 'name': 'Animation'},
          {'id': 35, 'name': 'Comedy'},
          {'id': 80, 'name': 'Crime'},
          {'id': 99, 'name': 'Documentary'},
          {'id': 18, 'name': 'Drama'},
          {'id': 10751, 'name': 'Family'},
          {'id': 14, 'name': 'Fantasy'},
          {'id': 36, 'name': 'History'},
        ];

        // Act
        final movie = Movie.fromJson(jsonWithManyGenres);

        // Assert
        expect(movie.genres.length, 10);
        expect(movie.genres[0].id, 28);
        expect(movie.genres[0].name, 'Action');
        expect(movie.genres[1].id, 12);
        expect(movie.genres[1].name, 'Adventure');
        expect(movie.genres[2].id, 16);
        expect(movie.genres[2].name, 'Animation');
        expect(movie.genres[3].id, 35);
        expect(movie.genres[3].name, 'Comedy');
        expect(movie.genres[4].id, 80);
        expect(movie.genres[4].name, 'Crime');
        expect(movie.genres[5].id, 99);
        expect(movie.genres[5].name, 'Documentary');
        expect(movie.genres[6].id, 18);
        expect(movie.genres[6].name, 'Drama');
        expect(movie.genres[7].id, 10751);
        expect(movie.genres[7].name, 'Family');
        expect(movie.genres[8].id, 14);
        expect(movie.genres[8].name, 'Fantasy');
        expect(movie.genres[9].id, 36);
        expect(movie.genres[9].name, 'History');
      });

      test('should correctly deserialize nested ProductionCompany objects', () {
        // Arrange
        final jsonWithManyCompanies = Map<String, dynamic>.from(completeJson);
        jsonWithManyCompanies['production_companies'] = [
          {
            'id': 1,
            'name': 'Company One',
            'logo_path': '/logo1.png',
            'origin_country': 'US',
          },
          {
            'id': 2,
            'name': 'Company Two',
            'logo_path': null,
            'origin_country': 'GB',
          },
          {
            'id': 3,
            'name': 'Company Three',
            'logo_path': '/logo3.jpg',
            'origin_country': 'FR',
          },
        ];

        // Act
        final movie = Movie.fromJson(jsonWithManyCompanies);

        // Assert
        expect(movie.productionCompanies.length, 3);
        expect(movie.productionCompanies[0].id, 1);
        expect(movie.productionCompanies[0].name, 'Company One');
        expect(movie.productionCompanies[0].logoPath, '/logo1.png');
        expect(movie.productionCompanies[0].originCountry, 'US');
        expect(movie.productionCompanies[1].id, 2);
        expect(movie.productionCompanies[1].name, 'Company Two');
        expect(movie.productionCompanies[1].logoPath, null);
        expect(movie.productionCompanies[1].originCountry, 'GB');
        expect(movie.productionCompanies[2].id, 3);
        expect(movie.productionCompanies[2].name, 'Company Three');
        expect(movie.productionCompanies[2].logoPath, '/logo3.jpg');
        expect(movie.productionCompanies[2].originCountry, 'FR');
      });

      test('should correctly deserialize nested ProductionCountry objects', () {
        // Arrange
        final jsonWithManyCountries = Map<String, dynamic>.from(completeJson);
        jsonWithManyCountries['production_countries'] = [
          {'iso_3166_1': 'US', 'name': 'United States of America'},
          {'iso_3166_1': 'GB', 'name': 'United Kingdom'},
          {'iso_3166_1': 'CA', 'name': 'Canada'},
          {'iso_3166_1': 'FR', 'name': 'France'},
          {'iso_3166_1': 'DE', 'name': 'Germany'},
        ];

        // Act
        final movie = Movie.fromJson(jsonWithManyCountries);

        // Assert
        expect(movie.productionCountries.length, 5);
        expect(movie.productionCountries[0].iso31661, 'US');
        expect(movie.productionCountries[0].name, 'United States of America');
        expect(movie.productionCountries[1].iso31661, 'GB');
        expect(movie.productionCountries[1].name, 'United Kingdom');
        expect(movie.productionCountries[2].iso31661, 'CA');
        expect(movie.productionCountries[2].name, 'Canada');
        expect(movie.productionCountries[3].iso31661, 'FR');
        expect(movie.productionCountries[3].name, 'France');
        expect(movie.productionCountries[4].iso31661, 'DE');
        expect(movie.productionCountries[4].name, 'Germany');
      });

      test('should correctly deserialize nested SpokenLanguage objects', () {
        // Arrange
        final jsonWithManyLanguages = Map<String, dynamic>.from(completeJson);
        jsonWithManyLanguages['spoken_languages'] = [
          {'iso_639_1': 'en', 'name': 'English', 'english_name': 'English'},
          {'iso_639_1': 'es', 'name': 'Español', 'english_name': 'Spanish'},
          {'iso_639_1': 'fr', 'name': 'Français', 'english_name': 'French'},
          {'iso_639_1': 'de', 'name': 'Deutsch', 'english_name': 'German'},
          {'iso_639_1': 'ja', 'name': '日本語', 'english_name': 'Japanese'},
        ];

        // Act
        final movie = Movie.fromJson(jsonWithManyLanguages);

        // Assert
        expect(movie.spokenLanguages.length, 5);
        expect(movie.spokenLanguages[0].iso6391, 'en');
        expect(movie.spokenLanguages[0].name, 'English');
        expect(movie.spokenLanguages[0].englishName, 'English');
        expect(movie.spokenLanguages[1].iso6391, 'es');
        expect(movie.spokenLanguages[1].name, 'Español');
        expect(movie.spokenLanguages[1].englishName, 'Spanish');
        expect(movie.spokenLanguages[2].iso6391, 'fr');
        expect(movie.spokenLanguages[2].name, 'Français');
        expect(movie.spokenLanguages[2].englishName, 'French');
        expect(movie.spokenLanguages[3].iso6391, 'de');
        expect(movie.spokenLanguages[3].name, 'Deutsch');
        expect(movie.spokenLanguages[3].englishName, 'German');
        expect(movie.spokenLanguages[4].iso6391, 'ja');
        expect(movie.spokenLanguages[4].name, '日本語');
        expect(movie.spokenLanguages[4].englishName, 'Japanese');
      });

      test('should correctly deserialize MovieCollection object', () {
        // Arrange
        final jsonWithCollection = Map<String, dynamic>.from(completeJson);
        jsonWithCollection['belongs_to_collection'] = {
          'id': 999,
          'name': 'Test Collection',
          'poster_path': '/test_poster.jpg',
          'backdrop_path': '/test_backdrop.jpg',
        };

        // Act
        final movie = Movie.fromJson(jsonWithCollection);

        // Assert
        expect(movie.belongsToCollection, isNotNull);
        expect(movie.belongsToCollection!.id, 999);
        expect(movie.belongsToCollection!.name, 'Test Collection');
        expect(movie.belongsToCollection!.posterPath, '/test_poster.jpg');
        expect(movie.belongsToCollection!.backdropPath, '/test_backdrop.jpg');
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
          final movie = Movie.fromJson(jsonWithDifferentDate);

          // Assert
          expect(movie.releaseDate, DateTime.parse(dateFormat));
        }
      });

      test('should handle invalid date formats', () {
        // Arrange
        final jsonWithInvalidDate = Map<String, dynamic>.from(completeJson);
        jsonWithInvalidDate['release_date'] = 'invalid-date';

        // Act
        final movie = Movie.fromJson(jsonWithInvalidDate);

        // Assert
        expect(movie.releaseDate, null);
      });

      test('should handle boolean fields correctly', () {
        // Arrange
        final jsonWithTrueBools = Map<String, dynamic>.from(completeJson);
        jsonWithTrueBools['adult'] = true;
        jsonWithTrueBools['video'] = true;

        // Act
        final movie = Movie.fromJson(jsonWithTrueBools);

        // Assert
        expect(movie.adult, true);
        expect(movie.video, true);
      });

      test('should handle numeric fields with different values', () {
        // Arrange
        final jsonWithDifferentNumbers =
            Map<String, dynamic>.from(completeJson);
        jsonWithDifferentNumbers['id'] = 0;
        jsonWithDifferentNumbers['budget'] = 0;
        jsonWithDifferentNumbers['revenue'] = 0;
        jsonWithDifferentNumbers['runtime'] = null;
        jsonWithDifferentNumbers['vote_average'] = 0.0;
        jsonWithDifferentNumbers['vote_count'] = 0;
        jsonWithDifferentNumbers['popularity'] = 0.0;

        // Act
        final movie = Movie.fromJson(jsonWithDifferentNumbers);

        // Assert
        expect(movie.id, 0);
        expect(movie.budget, 0);
        expect(movie.revenue, 0);
        expect(movie.runtime, null);
        expect(movie.voteAverage, 0.0);
        expect(movie.voteCount, 0);
        expect(movie.popularity, 0.0);
      });

      test('should handle very large numeric values', () {
        // Arrange
        final jsonWithLargeNumbers = Map<String, dynamic>.from(completeJson);
        jsonWithLargeNumbers['id'] = 2147483647; // Max int32
        jsonWithLargeNumbers['budget'] = 999999999;
        jsonWithLargeNumbers['revenue'] = 999999999;
        jsonWithLargeNumbers['vote_count'] = 2147483647;
        jsonWithLargeNumbers['popularity'] = 999999.999;

        // Act
        final movie = Movie.fromJson(jsonWithLargeNumbers);

        // Assert
        expect(movie.id, 2147483647);
        expect(movie.budget, 999999999);
        expect(movie.revenue, 999999999);
        expect(movie.voteCount, 2147483647);
        expect(movie.popularity, 999999.999);
      });

      test('should handle missing required fields', () {
        // Arrange
        final jsonWithMissingRequired = Map<String, dynamic>.from(completeJson);
        jsonWithMissingRequired.remove('id');

        // Act & Assert
        expect(() => Movie.fromJson(jsonWithMissingRequired),
            throwsA(isA<TypeError>()));
      });
    });

    group('toJson', () {
      test('should correctly serialize to JSON with all fields', () {
        // Arrange
        final movie = Movie(
          id: 550,
          adult: false,
          backdropPath: '/fCayJrkfRaCRCTh8GqN30f8oyQF.jpg',
          posterPath: '/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg',
          title: 'Fight Club',
          originalTitle: 'Fight Club',
          originalLanguage: 'en',
          overview:
              'An insomniac office worker and a devil-may-care soapmaker form an underground fight club...',
          tagline: 'Mischief. Mayhem. Soap.',
          releaseDate: DateTime.parse('1999-10-15'),
          genres: [genre1, genre2],
          budget: 63000000,
          revenue: 100853753,
          runtime: 139,
          voteAverage: 8.4,
          voteCount: 26280,
          popularity: 61.416,
          video: false,
          homepage: 'https://www.foxmovies.com/movies/fight-club',
          imdbId: 'tt0137523',
          status: 'Released',
          productionCompanies: [productionCompany1, productionCompany2],
          productionCountries: [productionCountry1, productionCountry2],
          spokenLanguages: [spokenLanguage1, spokenLanguage2],
          belongsToCollection: movieCollection,
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
        expect(json['tagline'], 'Mischief. Mayhem. Soap.');
        expect(
            json['release_date'], '1999-10-15T00:00:00.000'); // No 'Z' suffix
        expect(json['budget'], 63000000);
        expect(json['revenue'], 100853753);
        expect(json['runtime'], 139);
        expect(json['vote_average'], 8.4);
        expect(json['vote_count'], 26280);
        expect(json['popularity'], 61.416);
        expect(json['video'], false);
        expect(json['homepage'], 'https://www.foxmovies.com/movies/fight-club');
        expect(json['imdb_id'], 'tt0137523');
        expect(json['status'], 'Released');

        // Verify nested objects
        expect(json['genres'], isA<List>());
        expect(json['genres'].length, 2);
        expect(json['genres'][0], isA<Genre>());
        expect(json['genres'][0].id, 28);
        expect(json['genres'][0].name, 'Action');
        expect(json['genres'][1], isA<Genre>());
        expect(json['genres'][1].id, 18);
        expect(json['genres'][1].name, 'Drama');

        expect(json['production_companies'], isA<List>());
        expect(json['production_companies'].length, 2);
        expect(json['production_companies'][0], isA<ProductionCompany>());
        expect(json['production_companies'][0].id, 420);
        expect(json['production_companies'][0].name, 'Marvel Studios');

        expect(json['production_countries'], isA<List>());
        expect(json['production_countries'].length, 2);
        expect(json['production_countries'][0], isA<ProductionCountry>());
        expect(json['production_countries'][0].iso31661, 'US');
        expect(
            json['production_countries'][0].name, 'United States of America');

        expect(json['spoken_languages'], isA<List>());
        expect(json['spoken_languages'].length, 2);
        expect(json['spoken_languages'][0], isA<SpokenLanguage>());
        expect(json['spoken_languages'][0].iso6391, 'en');
        expect(json['spoken_languages'][0].name, 'English');

        expect(json['belongs_to_collection'], isA<MovieCollection>());
        expect(json['belongs_to_collection'].id, 123);
        expect(json['belongs_to_collection'].name, 'The Avengers Collection');
      });

      test('should correctly serialize to JSON with null optional fields', () {
        // Arrange
        const movie = Movie(
          id: 123,
          adult: true,
          backdropPath: null,
          posterPath: null,
          title: 'Null Test Movie',
          originalTitle: 'Null Test Movie',
          originalLanguage: 'en',
          overview: '',
          tagline: null,
          releaseDate: null,
          genres: [],
          budget: 0,
          revenue: 0,
          runtime: null,
          voteAverage: 5.0,
          voteCount: 100,
          popularity: 10.5,
          video: true,
          homepage: null,
          imdbId: null,
          status: null,
          productionCompanies: [],
          productionCountries: [],
          spokenLanguages: [],
          belongsToCollection: null,
        );

        // Act
        final json = movie.toJson();

        // Assert
        expect(json['id'], 123);
        expect(json['adult'], true);
        expect(json['backdrop_path'], null);
        expect(json['poster_path'], null);
        expect(json['title'], 'Null Test Movie');
        expect(json['original_title'], 'Null Test Movie');
        expect(json['original_language'], 'en');
        expect(json['overview'], '');
        expect(json['tagline'], null);
        expect(json['release_date'], null);
        expect(json['budget'], 0);
        expect(json['revenue'], 0);
        expect(json['runtime'], null);
        expect(json['vote_average'], 5.0);
        expect(json['vote_count'], 100);
        expect(json['popularity'], 10.5);
        expect(json['video'], true);
        expect(json['homepage'], null);
        expect(json['imdb_id'], null);
        expect(json['status'], null);
        expect(json['genres'], []);
        expect(json['production_companies'], []);
        expect(json['production_countries'], []);
        expect(json['spoken_languages'], []);
        expect(json['belongs_to_collection'], null);
      });

      test('should correctly serialize DateTime to ISO 8601 string', () {
        // Arrange
        final movieWithDate = Movie(
          id: 456,
          adult: false,
          backdropPath: null,
          posterPath: null,
          title: 'Date Test Movie',
          originalTitle: 'Date Test Movie',
          originalLanguage: 'en',
          overview: 'Testing date serialization',
          tagline: null,
          releaseDate: DateTime.parse('2020-01-01'),
          genres: [],
          budget: 0,
          revenue: 0,
          runtime: null,
          voteAverage: 0.0,
          voteCount: 0,
          popularity: 0.0,
          video: false,
          homepage: null,
          imdbId: null,
          status: null,
          productionCompanies: [],
          productionCountries: [],
          spokenLanguages: [],
          belongsToCollection: null,
        );

        // Act
        final json = movieWithDate.toJson();

        // Assert
        expect(json['release_date'], '2020-01-01T00:00:00.000');
      });

      test('should correctly serialize nested objects to their proper types',
          () {
        // Arrange
        final movieWithNestedObjects = Movie(
          id: 789,
          adult: false,
          backdropPath: null,
          posterPath: null,
          title: 'Nested Objects Test',
          originalTitle: 'Nested Objects Test',
          originalLanguage: 'en',
          overview: 'Testing nested object serialization',
          tagline: null,
          releaseDate: null,
          genres: [genre1, genre2, genre3],
          budget: 1000000,
          revenue: 2000000,
          runtime: 120,
          voteAverage: 7.5,
          voteCount: 1000,
          popularity: 50.0,
          video: false,
          homepage: null,
          imdbId: null,
          status: null,
          productionCompanies: [productionCompany1],
          productionCountries: [productionCountry1],
          spokenLanguages: [spokenLanguage1],
          belongsToCollection: movieCollection,
        );

        // Act
        final json = movieWithNestedObjects.toJson();

        // Assert
        expect(json['genres'], isA<List>());
        expect(json['genres'].length, 3);
        expect(json['genres'][0], isA<Genre>());
        expect(json['genres'][1], isA<Genre>());
        expect(json['genres'][2], isA<Genre>());

        expect(json['production_companies'], isA<List>());
        expect(json['production_companies'].length, 1);
        expect(json['production_companies'][0], isA<ProductionCompany>());

        expect(json['production_countries'], isA<List>());
        expect(json['production_countries'].length, 1);
        expect(json['production_countries'][0], isA<ProductionCountry>());

        expect(json['spoken_languages'], isA<List>());
        expect(json['spoken_languages'].length, 1);
        expect(json['spoken_languages'][0], isA<SpokenLanguage>());

        expect(json['belongs_to_collection'], isA<MovieCollection>());
      });
    });

    group('round-trip', () {
      test(
          'should maintain data integrity through serialization cycle with all fields',
          () {
        // Arrange
        final originalMovie = Movie(
          id: 550,
          adult: false,
          backdropPath: '/fCayJrkfRaCRCTh8GqN30f8oyQF.jpg',
          posterPath: '/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg',
          title: 'Fight Club',
          originalTitle: 'Fight Club',
          originalLanguage: 'en',
          overview:
              'An insomniac office worker and a devil-may-care soapmaker form an underground fight club...',
          tagline: 'Mischief. Mayhem. Soap.',
          releaseDate: DateTime.parse('1999-10-15'),
          genres: [genre1, genre2],
          budget: 63000000,
          revenue: 100853753,
          runtime: 139,
          voteAverage: 8.4,
          voteCount: 26280,
          popularity: 61.416,
          video: false,
          homepage: 'https://www.foxmovies.com/movies/fight-club',
          imdbId: 'tt0137523',
          status: 'Released',
          productionCompanies: [productionCompany1, productionCompany2],
          productionCountries: [productionCountry1, productionCountry2],
          spokenLanguages: [spokenLanguage1, spokenLanguage2],
          belongsToCollection: movieCollection,
        );

        // Act
        final json = originalMovie.toJson();

        // Convert nested objects to maps for deserialization
        final jsonForDeserialization = {
          'id': json['id'],
          'adult': json['adult'],
          'backdrop_path': json['backdrop_path'],
          'poster_path': json['poster_path'],
          'title': json['title'],
          'original_title': json['original_title'],
          'original_language': json['original_language'],
          'overview': json['overview'],
          'tagline': json['tagline'],
          'release_date': json['release_date'],
          'genres': (json['genres'] as List<Genre>)
              .map((genre) => genre.toJson())
              .toList(),
          'budget': json['budget'],
          'revenue': json['revenue'],
          'runtime': json['runtime'],
          'vote_average': json['vote_average'],
          'vote_count': json['vote_count'],
          'popularity': json['popularity'],
          'video': json['video'],
          'homepage': json['homepage'],
          'imdb_id': json['imdb_id'],
          'status': json['status'],
          'production_companies':
              (json['production_companies'] as List<ProductionCompany>)
                  .map((company) => company.toJson())
                  .toList(),
          'production_countries':
              (json['production_countries'] as List<ProductionCountry>)
                  .map((country) => country.toJson())
                  .toList(),
          'spoken_languages': (json['spoken_languages'] as List<SpokenLanguage>)
              .map((language) => language.toJson())
              .toList(),
          'belongs_to_collection': json['belongs_to_collection'] != null
              ? (json['belongs_to_collection'] as MovieCollection).toJson()
              : null,
        };

        final deserializedMovie = Movie.fromJson(jsonForDeserialization);

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
        expect(deserializedMovie.tagline, originalMovie.tagline);
        expect(deserializedMovie.releaseDate, originalMovie.releaseDate);
        expect(deserializedMovie.budget, originalMovie.budget);
        expect(deserializedMovie.revenue, originalMovie.revenue);
        expect(deserializedMovie.runtime, originalMovie.runtime);
        expect(deserializedMovie.voteAverage, originalMovie.voteAverage);
        expect(deserializedMovie.voteCount, originalMovie.voteCount);
        expect(deserializedMovie.popularity, originalMovie.popularity);
        expect(deserializedMovie.video, originalMovie.video);
        expect(deserializedMovie.homepage, originalMovie.homepage);
        expect(deserializedMovie.imdbId, originalMovie.imdbId);
        expect(deserializedMovie.status, originalMovie.status);

        // Verify nested objects
        expect(deserializedMovie.genres.length, originalMovie.genres.length);
        for (int i = 0; i < originalMovie.genres.length; i++) {
          expect(deserializedMovie.genres[i].id, originalMovie.genres[i].id);
          expect(
              deserializedMovie.genres[i].name, originalMovie.genres[i].name);
        }

        expect(deserializedMovie.productionCompanies.length,
            originalMovie.productionCompanies.length);
        for (int i = 0; i < originalMovie.productionCompanies.length; i++) {
          expect(deserializedMovie.productionCompanies[i].id,
              originalMovie.productionCompanies[i].id);
          expect(deserializedMovie.productionCompanies[i].name,
              originalMovie.productionCompanies[i].name);
        }

        expect(deserializedMovie.productionCountries.length,
            originalMovie.productionCountries.length);
        for (int i = 0; i < originalMovie.productionCountries.length; i++) {
          expect(deserializedMovie.productionCountries[i].iso31661,
              originalMovie.productionCountries[i].iso31661);
          expect(deserializedMovie.productionCountries[i].name,
              originalMovie.productionCountries[i].name);
        }

        expect(deserializedMovie.spokenLanguages.length,
            originalMovie.spokenLanguages.length);
        for (int i = 0; i < originalMovie.spokenLanguages.length; i++) {
          expect(deserializedMovie.spokenLanguages[i].iso6391,
              originalMovie.spokenLanguages[i].iso6391);
          expect(deserializedMovie.spokenLanguages[i].name,
              originalMovie.spokenLanguages[i].name);
        }

        expect(deserializedMovie.belongsToCollection?.id,
            originalMovie.belongsToCollection?.id);
        expect(deserializedMovie.belongsToCollection?.name,
            originalMovie.belongsToCollection?.name);
      });

      test(
          'should maintain data integrity through serialization cycle with null fields',
          () {
        // Arrange
        const originalMovie = Movie(
          id: 123,
          adult: true,
          backdropPath: null,
          posterPath: null,
          title: 'Null Round-trip Test',
          originalTitle: 'Null Round-trip Test',
          originalLanguage: 'en',
          overview: '',
          tagline: null,
          releaseDate: null,
          genres: [],
          budget: 0,
          revenue: 0,
          runtime: null,
          voteAverage: 5.0,
          voteCount: 100,
          popularity: 10.5,
          video: true,
          homepage: null,
          imdbId: null,
          status: null,
          productionCompanies: [],
          productionCountries: [],
          spokenLanguages: [],
          belongsToCollection: null,
        );

        // Act
        final json = originalMovie.toJson();

        // Convert nested objects to maps for deserialization
        final jsonForDeserialization = {
          'id': json['id'],
          'adult': json['adult'],
          'backdrop_path': json['backdrop_path'],
          'poster_path': json['poster_path'],
          'title': json['title'],
          'original_title': json['original_title'],
          'original_language': json['original_language'],
          'overview': json['overview'],
          'tagline': json['tagline'],
          'release_date': json['release_date'],
          'genres': (json['genres'] as List<Genre>)
              .map((genre) => genre.toJson())
              .toList(),
          'budget': json['budget'],
          'revenue': json['revenue'],
          'runtime': json['runtime'],
          'vote_average': json['vote_average'],
          'vote_count': json['vote_count'],
          'popularity': json['popularity'],
          'video': json['video'],
          'homepage': json['homepage'],
          'imdb_id': json['imdb_id'],
          'status': json['status'],
          'production_companies':
              (json['production_companies'] as List<ProductionCompany>)
                  .map((company) => company.toJson())
                  .toList(),
          'production_countries':
              (json['production_countries'] as List<ProductionCountry>)
                  .map((country) => country.toJson())
                  .toList(),
          'spoken_languages': (json['spoken_languages'] as List<SpokenLanguage>)
              .map((language) => language.toJson())
              .toList(),
          'belongs_to_collection': json['belongs_to_collection'],
        };

        final deserializedMovie = Movie.fromJson(jsonForDeserialization);

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
        expect(deserializedMovie.tagline, originalMovie.tagline);
        expect(deserializedMovie.releaseDate, originalMovie.releaseDate);
        expect(deserializedMovie.budget, originalMovie.budget);
        expect(deserializedMovie.revenue, originalMovie.revenue);
        expect(deserializedMovie.runtime, originalMovie.runtime);
        expect(deserializedMovie.voteAverage, originalMovie.voteAverage);
        expect(deserializedMovie.voteCount, originalMovie.voteCount);
        expect(deserializedMovie.popularity, originalMovie.popularity);
        expect(deserializedMovie.video, originalMovie.video);
        expect(deserializedMovie.homepage, originalMovie.homepage);
        expect(deserializedMovie.imdbId, originalMovie.imdbId);
        expect(deserializedMovie.status, originalMovie.status);
        expect(deserializedMovie.genres, originalMovie.genres);
        expect(deserializedMovie.productionCompanies,
            originalMovie.productionCompanies);
        expect(deserializedMovie.productionCountries,
            originalMovie.productionCountries);
        expect(
            deserializedMovie.spokenLanguages, originalMovie.spokenLanguages);
        expect(deserializedMovie.belongsToCollection,
            originalMovie.belongsToCollection);
      });
    });

    group('edge cases', () {
      test('should handle empty genres array', () {
        // Arrange
        final jsonWithEmptyGenres = Map<String, dynamic>.from(completeJson);
        jsonWithEmptyGenres['genres'] = [];

        // Act
        final movie = Movie.fromJson(jsonWithEmptyGenres);

        // Assert
        expect(movie.genres, isEmpty);
      });

      test('should handle single genre', () {
        // Arrange
        final jsonWithSingleGenre = Map<String, dynamic>.from(completeJson);
        jsonWithSingleGenre['genres'] = [
          {'id': 28, 'name': 'Action'}
        ];

        // Act
        final movie = Movie.fromJson(jsonWithSingleGenre);

        // Assert
        expect(movie.genres.length, 1);
        expect(movie.genres[0].id, 28);
        expect(movie.genres[0].name, 'Action');
      });

      test('should handle many genres', () {
        // Arrange
        final jsonWithManyGenres = Map<String, dynamic>.from(completeJson);
        jsonWithManyGenres['genres'] = List.generate(
          20,
          (index) => {'id': index + 1, 'name': 'Genre ${index + 1}'},
        );

        // Act
        final movie = Movie.fromJson(jsonWithManyGenres);

        // Assert
        expect(movie.genres.length, 20);
        for (int i = 0; i < 20; i++) {
          expect(movie.genres[i].id, i + 1);
          expect(movie.genres[i].name, 'Genre ${i + 1}');
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
        jsonWithSpecialChars['tagline'] = 'Tagline with special chars: ¡¿ß';

        // Act
        final movie = Movie.fromJson(jsonWithSpecialChars);

        // Assert
        expect(movie.title,
            'Movie with special chars: !@#\$%^&*()_+-=[]{}|;:,.<>?');
        expect(movie.originalTitle, 'Original: 电影片名 🎬');
        expect(
            movie.overview, 'Overview with emojis: 🎭🎪🎨 and unicode: ñáéíóú');
        expect(movie.tagline, 'Tagline with special chars: ¡¿ß');
      });

      test('should handle very long string fields', () {
        // Arrange
        final longString = 'A' * 1000;
        final jsonWithLongStrings = Map<String, dynamic>.from(completeJson);
        jsonWithLongStrings['title'] = longString;
        jsonWithLongStrings['overview'] = longString;
        jsonWithLongStrings['tagline'] = longString;

        // Act
        final movie = Movie.fromJson(jsonWithLongStrings);

        // Assert
        expect(movie.title, longString);
        expect(movie.overview, longString);
        expect(movie.tagline, longString);
      });

      test('should handle floating point precision', () {
        // Arrange
        final jsonWithPrecision = Map<String, dynamic>.from(completeJson);
        jsonWithPrecision['vote_average'] = 8.433333333333334;
        jsonWithPrecision['popularity'] = 61.416000000000004;

        // Act
        final movie = Movie.fromJson(jsonWithPrecision);

        // Assert
        expect(movie.voteAverage, 8.433333333333334);
        expect(movie.popularity, 61.416000000000004);
      });

      test('should handle runtime with various values', () {
        // Arrange
        final runtimeValues = [0, 1, 30, 60, 90, 120, 180, 240, 300];

        for (final runtime in runtimeValues) {
          final jsonWithRuntime = Map<String, dynamic>.from(completeJson);
          jsonWithRuntime['runtime'] = runtime;

          // Act
          final movie = Movie.fromJson(jsonWithRuntime);

          // Assert
          expect(movie.runtime, runtime);
        }
      });

      test('should handle null runtime', () {
        // Arrange
        final jsonWithNullRuntime = Map<String, dynamic>.from(completeJson);
        jsonWithNullRuntime['runtime'] = null;

        // Act
        final movie = Movie.fromJson(jsonWithNullRuntime);

        // Assert
        expect(movie.runtime, null);
      });

      test('should handle different status values', () {
        // Arrange
        final statusValues = [
          'Rumored',
          'Planned',
          'In Production',
          'Post Production',
          'Released',
          'Canceled',
        ];

        for (final status in statusValues) {
          final jsonWithStatus = Map<String, dynamic>.from(completeJson);
          jsonWithStatus['status'] = status;

          // Act
          final movie = Movie.fromJson(jsonWithStatus);

          // Assert
          expect(movie.status, status);
        }
      });

      test('should handle MovieCollection with null fields', () {
        // Arrange
        final jsonWithPartialCollection =
            Map<String, dynamic>.from(completeJson);
        jsonWithPartialCollection['belongs_to_collection'] = {
          'id': 999,
          'name': 'Partial Collection',
          'poster_path': null,
          'backdrop_path': null,
        };

        // Act
        final movie = Movie.fromJson(jsonWithPartialCollection);

        // Assert
        expect(movie.belongsToCollection, isNotNull);
        expect(movie.belongsToCollection!.id, 999);
        expect(movie.belongsToCollection!.name, 'Partial Collection');
        expect(movie.belongsToCollection!.posterPath, null);
        expect(movie.belongsToCollection!.backdropPath, null);
      });
    });
  });

  group('MovieCollection', () {
    group('fromJson', () {
      test('should correctly deserialize from JSON with all fields', () {
        // Arrange
        final json = {
          'id': 123,
          'name': 'The Avengers Collection',
          'poster_path': '/4TOWiT7K1d2G2ZTw2g5rLhrFNpe.jpg',
          'backdrop_path': '/hBNWRJvjwE9C5A9EN2aWXGS5d5p.jpg',
        };

        // Act
        final collection = MovieCollection.fromJson(json);

        // Assert
        expect(collection.id, 123);
        expect(collection.name, 'The Avengers Collection');
        expect(collection.posterPath, '/4TOWiT7K1d2G2ZTw2g5rLhrFNpe.jpg');
        expect(collection.backdropPath, '/hBNWRJvjwE9C5A9EN2aWXGS5d5p.jpg');
      });

      test('should correctly deserialize from JSON with null optional fields',
          () {
        // Arrange
        final json = {
          'id': 456,
          'name': 'Test Collection',
          'poster_path': null,
          'backdrop_path': null,
        };

        // Act
        final collection = MovieCollection.fromJson(json);

        // Assert
        expect(collection.id, 456);
        expect(collection.name, 'Test Collection');
        expect(collection.posterPath, null);
        expect(collection.backdropPath, null);
      });
    });

    group('toJson', () {
      test('should correctly serialize to JSON with all fields', () {
        // Arrange
        const collection = MovieCollection(
          id: 123,
          name: 'The Avengers Collection',
          posterPath: '/4TOWiT7K1d2G2ZTw2g5rLhrFNpe.jpg',
          backdropPath: '/hBNWRJvjwE9C5A9EN2aWXGS5d5p.jpg',
        );

        // Act
        final json = collection.toJson();

        // Assert
        expect(json['id'], 123);
        expect(json['name'], 'The Avengers Collection');
        expect(json['poster_path'], '/4TOWiT7K1d2G2ZTw2g5rLhrFNpe.jpg');
        expect(json['backdrop_path'], '/hBNWRJvjwE9C5A9EN2aWXGS5d5p.jpg');
      });

      test('should correctly serialize to JSON with null optional fields', () {
        // Arrange
        const collection = MovieCollection(
          id: 456,
          name: 'Test Collection',
          posterPath: null,
          backdropPath: null,
        );

        // Act
        final json = collection.toJson();

        // Assert
        expect(json['id'], 456);
        expect(json['name'], 'Test Collection');
        expect(json['poster_path'], null);
        expect(json['backdrop_path'], null);
      });
    });

    group('round-trip', () {
      test('should maintain data integrity through serialization cycle', () {
        // Arrange
        const originalCollection = MovieCollection(
          id: 123,
          name: 'The Avengers Collection',
          posterPath: '/4TOWiT7K1d2G2ZTw2g5rLhrFNpe.jpg',
          backdropPath: '/hBNWRJvjwE9C5A9EN2aWXGS5d5p.jpg',
        );

        // Act
        final json = originalCollection.toJson();
        final deserializedCollection = MovieCollection.fromJson(json);

        // Assert
        expect(deserializedCollection.id, originalCollection.id);
        expect(deserializedCollection.name, originalCollection.name);
        expect(
            deserializedCollection.posterPath, originalCollection.posterPath);
        expect(deserializedCollection.backdropPath,
            originalCollection.backdropPath);
      });
    });
  });
}
