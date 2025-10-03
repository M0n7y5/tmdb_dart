import 'package:tmdb_dart/src/models/movie/movie.dart';
import 'package:tmdb_dart/src/models/movie/movie_short.dart';
import 'package:tmdb_dart/src/models/tv/tv_show.dart';
import 'package:tmdb_dart/src/models/tv/tv_show_short.dart';
import 'package:tmdb_dart/src/models/person/person.dart';
import 'package:tmdb_dart/src/models/common/paginated_response.dart';
import 'package:tmdb_dart/src/models/common/genre.dart';
import 'package:tmdb_dart/src/models/common/production_company.dart';
import 'package:tmdb_dart/src/models/common/production_country.dart';
import 'package:tmdb_dart/src/models/common/spoken_language.dart';
import 'package:tmdb_dart/src/models/tv/tv_show.dart' show Network, Creator;

/// Helper class providing mock data builders for testing
class MockData {
  // Sample genres
  static const Genre actionGenre = Genre(id: 28, name: 'Action');
  static const Genre comedyGenre = Genre(id: 35, name: 'Comedy');
  static const Genre dramaGenre = Genre(id: 18, name: 'Drama');
  static const Genre scifiGenre = Genre(id: 878, name: 'Science Fiction');

  static List<Genre> get sampleGenres =>
      [actionGenre, comedyGenre, dramaGenre, scifiGenre];

  // Sample production companies
  static const ProductionCompany marvelStudios = ProductionCompany(
    id: 420,
    name: 'Marvel Studios',
    logoPath: '/hUzeosd33nzE5MCNsZxCGEKTXaQ.png',
    originCountry: 'US',
  );

  static const ProductionCompany warnerBros = ProductionCompany(
    id: 174,
    name: 'Warner Bros. Pictures',
    logoPath: '/kyEe0cTwOCXMMlEuBtq8X1FNPEk.png',
    originCountry: 'US',
  );

  static List<ProductionCompany> get sampleProductionCompanies =>
      [marvelStudios, warnerBros];

  // Sample production countries
  static const ProductionCountry usa = ProductionCountry(
    iso31661: 'US',
    name: 'United States of America',
  );

  static const ProductionCountry uk = ProductionCountry(
    iso31661: 'GB',
    name: 'United Kingdom',
  );

  static List<ProductionCountry> get sampleProductionCountries => [usa, uk];

  // Sample spoken languages
  static const SpokenLanguage english = SpokenLanguage(
    iso6391: 'en',
    name: 'English',
    englishName: 'English',
  );

  static const SpokenLanguage spanish = SpokenLanguage(
    iso6391: 'es',
    name: 'Español',
    englishName: 'Spanish',
  );

  static List<SpokenLanguage> get sampleSpokenLanguages => [english, spanish];

  // Sample Movie
  static Movie get sampleMovie => Movie(
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
        genres: sampleGenres,
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
        productionCompanies: sampleProductionCompanies,
        productionCountries: sampleProductionCountries,
        spokenLanguages: sampleSpokenLanguages,
        belongsToCollection: null,
      );

  // Sample MovieShort
  static MovieShort get sampleMovieShort => MovieShort(
        id: 550,
        adult: false,
        backdropPath: '/fCayJrkfRaCRCTh8GqN30f8oyQF.jpg',
        posterPath: '/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg',
        title: 'Fight Club',
        originalTitle: 'Fight Club',
        originalLanguage: 'en',
        overview:
            'An insomniac office worker and a devil-may-care soapmaker form an underground fight club...',
        releaseDate: DateTime.parse('1999-10-15'),
        genreIds: [18, 53],
        voteAverage: 8.4,
        voteCount: 26280,
        popularity: 61.416,
        video: false,
      );

  // Sample TV Show
  static TvShow get sampleTvShow => TvShow(
        id: 1396,
        adult: false,
        backdropPath: '/mYThXp2nG8s8Yothl8XbC0aY9UC.jpg',
        posterPath: '/wHa6KOZo5Vgv6Of8RZ0Wd2zkVwF.jpg',
        name: 'Breaking Bad',
        originalName: 'Breaking Bad',
        originalLanguage: 'en',
        overview:
            'When Walter White is diagnosed with cancer, he decides to start making meth...',
        tagline: 'Change the equation.',
        firstAirDate: DateTime.parse('2008-01-20'),
        lastAirDate: DateTime.parse('2013-09-29'),
        genres: [crimeGenre, dramaGenre],
        episodeRunTime: [45, 47],
        numberOfEpisodes: 62,
        numberOfSeasons: 5,
        voteAverage: 8.9,
        voteCount: 12985,
        popularity: 317.376,
        homepage: 'http://www.amctv.com/shows/breaking-bad',
        status: 'Ended',
        type: 'Scripted',
        inProduction: false,
        languages: ['en'],
        originCountry: ['US'],
        productionCompanies: [sonyPictures],
        productionCountries: sampleProductionCountries,
        spokenLanguages: sampleSpokenLanguages,
        networks: [amc],
        seasons: [],
        createdBy: [vinceGilligan],
      );

  // Sample TV Show Short
  static TvShowShort get sampleTvShowShort => TvShowShort(
        id: 1396,
        adult: false,
        backdropPath: '/mYThXp2nG8s8Yothl8XbC0aY9UC.jpg',
        posterPath: '/wHa6KOZo5Vgv6Of8RZ0Wd2zkVwF.jpg',
        name: 'Breaking Bad',
        originalName: 'Breaking Bad',
        originalLanguage: 'en',
        overview:
            'When Walter White is diagnosed with cancer, he decides to start making meth...',
        firstAirDate: DateTime.parse('2008-01-20'),
        genreIds: [18, 80],
        voteAverage: 8.9,
        voteCount: 12985,
        popularity: 317.376,
        originCountry: ['US'],
      );

  // Sample Person
  static Person get samplePerson => Person(
        id: 819,
        adult: false,
        name: 'Edward Norton',
        alsoKnownAs: ['Edward James Norton Jr.'],
        biography: 'Edward Harrison Norton is an American actor and filmmaker.',
        birthday: DateTime.parse('1969-08-18'),
        deathday: null,
        gender: 2,
        homepage: null,
        knownForDepartment: 'Acting',
        placeOfBirth: 'Boston, Massachusetts, USA',
        popularity: 7.842,
        profilePath: '/5XBzD5WuTyVQZeS4VI25z2moMeY.jpg',
        imdbId: 'nm0000709',
      );

  // Additional genres needed for TV shows
  static const Genre crimeGenre = Genre(id: 80, name: 'Crime');

  // Additional production companies needed for TV shows
  static const ProductionCompany sonyPictures = ProductionCompany(
    id: 34,
    name: 'Sony Pictures Television Studios',
    logoPath: '/5zcSIGpJkX96RiQ6vTtDp6zFcqw.png',
    originCountry: 'US',
  );

  // Additional network and creator needed for TV shows
  static const Network amc = Network(
    id: 174,
    name: 'AMC',
    logoPath: '/lmZFxXgZE3MPfVQYFvBnVilnjVw.png',
    originCountry: 'US',
  );

  static const Creator vinceGilligan = Creator(
    id: 66633,
    name: 'Vince Gilligan',
    profilePath: '/rLSdjrCVNHa6lbnKWyWbpyojGg8.jpg',
    creditId: '52542286760ee31328001a79',
    gender: 2,
  );

  // Sample PaginatedResponse for Movies
  static PaginatedResponse<MovieShort> get sampleMoviePaginatedResponse =>
      PaginatedResponse<MovieShort>(
        page: 1,
        results: [sampleMovieShort],
        totalPages: 500,
        totalResults: 10000,
      );

  // Sample PaginatedResponse for TV Shows
  static PaginatedResponse<TvShowShort> get sampleTvShowPaginatedResponse =>
      PaginatedResponse<TvShowShort>(
        page: 1,
        results: [sampleTvShowShort],
        totalPages: 100,
        totalResults: 2000,
      );

  // Sample PaginatedResponse for People
  static PaginatedResponse<Person> get samplePersonPaginatedResponse =>
      PaginatedResponse<Person>(
        page: 1,
        results: [samplePerson],
        totalPages: 1000,
        totalResults: 20000,
      );

  // Empty PaginatedResponse
  static PaginatedResponse<T> emptyPaginatedResponse<T>() =>
      PaginatedResponse<T>(
        page: 1,
        results: [],
        totalPages: 0,
        totalResults: 0,
      );

  // Customizable builders

  /// Creates a custom Movie with optional overrides
  static Movie createMovie({
    int? id,
    String? title,
    List<Genre>? genres,
    DateTime? releaseDate,
    double? voteAverage,
    int? voteCount,
  }) {
    return Movie(
      id: id ?? sampleMovie.id,
      adult: sampleMovie.adult,
      backdropPath: sampleMovie.backdropPath,
      posterPath: sampleMovie.posterPath,
      title: title ?? sampleMovie.title,
      originalTitle: sampleMovie.originalTitle,
      originalLanguage: sampleMovie.originalLanguage,
      overview: sampleMovie.overview,
      tagline: sampleMovie.tagline,
      releaseDate: releaseDate ?? sampleMovie.releaseDate,
      genres: genres ?? sampleMovie.genres,
      budget: sampleMovie.budget,
      revenue: sampleMovie.revenue,
      runtime: sampleMovie.runtime,
      voteAverage: voteAverage ?? sampleMovie.voteAverage,
      voteCount: voteCount ?? sampleMovie.voteCount,
      popularity: sampleMovie.popularity,
      video: sampleMovie.video,
      homepage: sampleMovie.homepage,
      imdbId: sampleMovie.imdbId,
      status: sampleMovie.status,
      productionCompanies: sampleMovie.productionCompanies,
      productionCountries: sampleMovie.productionCountries,
      spokenLanguages: sampleMovie.spokenLanguages,
      belongsToCollection: sampleMovie.belongsToCollection,
    );
  }

  /// Creates a custom TvShow with optional overrides
  static TvShow createTvShow({
    int? id,
    String? name,
    List<Genre>? genres,
    DateTime? firstAirDate,
    double? voteAverage,
    int? voteCount,
  }) {
    return TvShow(
      id: id ?? sampleTvShow.id,
      adult: sampleTvShow.adult,
      backdropPath: sampleTvShow.backdropPath,
      posterPath: sampleTvShow.posterPath,
      name: name ?? sampleTvShow.name,
      originalName: sampleTvShow.originalName,
      originalLanguage: sampleTvShow.originalLanguage,
      overview: sampleTvShow.overview,
      tagline: sampleTvShow.tagline,
      firstAirDate: firstAirDate ?? sampleTvShow.firstAirDate,
      lastAirDate: sampleTvShow.lastAirDate,
      genres: genres ?? sampleTvShow.genres,
      episodeRunTime: sampleTvShow.episodeRunTime,
      numberOfEpisodes: sampleTvShow.numberOfEpisodes,
      numberOfSeasons: sampleTvShow.numberOfSeasons,
      voteAverage: voteAverage ?? sampleTvShow.voteAverage,
      voteCount: voteCount ?? sampleTvShow.voteCount,
      popularity: sampleTvShow.popularity,
      homepage: sampleTvShow.homepage,
      status: sampleTvShow.status,
      type: sampleTvShow.type,
      inProduction: sampleTvShow.inProduction,
      languages: sampleTvShow.languages,
      originCountry: sampleTvShow.originCountry,
      productionCompanies: sampleTvShow.productionCompanies,
      productionCountries: sampleTvShow.productionCountries,
      spokenLanguages: sampleTvShow.spokenLanguages,
      networks: sampleTvShow.networks,
      seasons: sampleTvShow.seasons,
      createdBy: sampleTvShow.createdBy,
    );
  }

  /// Creates a custom Person with optional overrides
  static Person createPerson({
    int? id,
    String? name,
    DateTime? birthday,
    double? popularity,
  }) {
    return Person(
      id: id ?? samplePerson.id,
      adult: samplePerson.adult,
      name: name ?? samplePerson.name,
      alsoKnownAs: samplePerson.alsoKnownAs,
      biography: samplePerson.biography,
      birthday: birthday ?? samplePerson.birthday,
      deathday: samplePerson.deathday,
      gender: samplePerson.gender,
      homepage: samplePerson.homepage,
      knownForDepartment: samplePerson.knownForDepartment,
      placeOfBirth: samplePerson.placeOfBirth,
      popularity: popularity ?? samplePerson.popularity,
      profilePath: samplePerson.profilePath,
      imdbId: samplePerson.imdbId,
    );
  }

  /// Creates a custom PaginatedResponse with optional overrides
  static PaginatedResponse<T> createPaginatedResponse<T>({
    int? page,
    List<T>? results,
    int? totalPages,
    int? totalResults,
  }) {
    return PaginatedResponse<T>(
      page: page ?? 1,
      results: results ?? <T>[],
      totalPages: totalPages ?? 1,
      totalResults: totalResults ?? (results?.length ?? 0),
    );
  }
}
