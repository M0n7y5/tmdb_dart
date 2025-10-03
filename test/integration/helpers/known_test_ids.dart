/// Known test data for integration tests.
///
/// This class contains static const values for known-good TMDB entity IDs
/// that can be used for reliable integration testing.
library;

/// Collection of known TMDB entity IDs for testing.
///
/// These IDs represent stable, well-known entities in the TMDB database
/// that are unlikely to be removed or significantly changed. Using these
/// IDs makes integration tests more reliable and predictable.
class KnownTestIds {
  // Movie IDs
  /// The Shawshank Redemption (1994) - A highly-rated, stable movie entry
  static const int shawshankRedemption = 278;
  
  /// Inception (2010) - Popular Christopher Nolan film
  static const int inception = 27205;
  
  /// The Dark Knight (2008) - Another popular Batman film
  static const int darkKnight = 155;
  
  /// Pulp Fiction (1994) - Classic Tarantino film
  static const int pulpFiction = 680;
  
  /// Forrest Gump (1994) - Popular drama film
  static const int forrestGump = 13;

  // TV Show IDs
  /// Breaking Bad - Popular TV series
  static const int breakingBad = 1396;
  
  /// Game of Thrones - HBO fantasy series
  static const int gameOfThrones = 1399;
  
  /// Friends - Classic sitcom
  static const int friends = 1668;
  
  /// Stranger Things - Netflix original series
  static const int strangerThings = 66732;
  
  /// The Office (US) - Popular mockumentary sitcom
  static const int theOffice = 2316;

  // Person IDs
  /// Tom Hanks - Well-known actor
  static const int tomHanks = 31;
  
  /// Morgan Freeman - Well-known actor
  static const int morganFreeman = 192;
  
  /// Leonardo DiCaprio - Popular actor
  static const int leonardoDiCaprio = 6193;
  
  /// Brad Pitt - Popular actor
  static const int bradPitt = 287;
  
  /// Quentin Tarantino - Well-known director
  static const int quentinTarantino = 138;

  // Search query strings
  /// Matrix - Popular sci-fi movie franchise
  static const String matrixSearch = 'Matrix';
  
  /// Tom Cruise - Well-known actor
  static const String tomCruiseSearch = 'Tom Cruise';
  
  /// Friends - Popular TV show
  static const String friendsSearch = 'Friends';
  
  /// Batman - Popular superhero franchise
  static const String batmanSearch = 'Batman';
  
  /// Disney - Major entertainment company
  static const String disneySearch = 'Disney';

  // Additional search queries for SearchService tests
  /// Matrix - Search query for movies (alias for matrixSearch)
  static const String searchMovieQuery = 'Matrix';
  
  /// Friends - Search query for TV shows
  static const String searchTvQuery = 'Friends';
  
  /// Tom Cruise - Search query for people
  static const String searchPersonQuery = 'Tom Cruise';
  
  /// Dream - Search query for keywords
  static const String searchKeywordQuery = 'dream';
  
  /// Marvel - Search query for companies
  static const String searchCompanyQuery = 'Marvel';
  
  /// Avengers - Search query for collections
  static const String searchCollectionQuery = 'Avengers';

  /// Private constructor to prevent instantiation.
  KnownTestIds._();
}