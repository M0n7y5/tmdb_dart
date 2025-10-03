/// TMDB Dart Client Library
///
/// A Dart client library for The Movie Database (TMDB) API.
library;

// Core exports
export 'src/core/api_client.dart';
export 'src/core/exceptions.dart';
export 'src/core/tmdb_client.dart';

// Model exports
// Common models
export 'src/models/common/paginated_response.dart';
export 'src/models/common/image.dart';
export 'src/models/common/video.dart';
export 'src/models/common/genre.dart';
export 'src/models/common/keyword.dart';
export 'src/models/common/external_ids.dart';
export 'src/models/common/production_company.dart';
export 'src/models/common/production_country.dart';
export 'src/models/common/spoken_language.dart';

// Credits models
export 'src/models/credits/cast.dart';
export 'src/models/credits/crew.dart';
export 'src/models/credits/credits.dart';

// Movie models
export 'src/models/movie/movie.dart';
export 'src/models/movie/movie_short.dart';

// TV show models
export 'src/models/tv/tv_show.dart';
export 'src/models/tv/tv_show_short.dart';
export 'src/models/tv/season.dart';
export 'src/models/tv/episode.dart';

// Person models
export 'src/models/person/person.dart';
export 'src/models/person/person_short.dart';
export 'src/models/person/person_credits.dart';

// Review model
export 'src/models/review.dart';

// Watch provider models
export 'src/models/watch_provider.dart';
export 'src/models/watch_providers_result.dart';

// Configuration models
export 'src/models/configuration/api_configuration.dart';
export 'src/models/configuration/country.dart';
export 'src/models/configuration/language.dart';

// Utility exports
export 'src/utils/image_url_builder.dart';
export 'src/utils/pagination_helper.dart';
export 'src/utils/query_parameters.dart';

// Service exports
export 'src/services/configuration_service.dart';
export 'src/services/movie_service.dart';
export 'src/services/person_service.dart';
export 'src/services/search_service.dart';
export 'src/services/tv_service.dart';
