import '../models/configuration/api_configuration.dart';

/// Enum for poster image sizes
enum PosterSize {
  w92,
  w154,
  w185,
  w342,
  w500,
  w780,
  original,
}

/// Enum for backdrop image sizes
enum BackdropSize {
  w300,
  w780,
  w1280,
  original,
}

/// Enum for profile image sizes
enum ProfileSize {
  w45,
  w185,
  h632,
  original,
}

/// Enum for still image sizes
enum StillSize {
  w92,
  w185,
  w300,
  original,
}

/// Enum for logo image sizes
enum LogoSize {
  w45,
  w92,
  w154,
  w185,
  w300,
  w500,
  original,
}

/// Utility class for constructing TMDB image URLs
class ImageUrlBuilder {
  final ApiConfiguration _config;

  /// Creates a new [ImageUrlBuilder] with the provided API configuration
  ImageUrlBuilder(this._config);

  /// Builds a poster URL with the specified size
  String? buildPosterUrl(String? path, {PosterSize size = PosterSize.w500}) {
    if (path == null || path.isEmpty) return null;
    return '${_config.images.secureBaseUrl}${_sizeToString(size)}$path';
  }

  /// Builds a backdrop URL with the specified size
  String? buildBackdropUrl(String? path,
      {BackdropSize size = BackdropSize.w1280}) {
    if (path == null || path.isEmpty) return null;
    return '${_config.images.secureBaseUrl}${_sizeToString(size)}$path';
  }

  /// Builds a profile URL with the specified size
  String? buildProfileUrl(String? path, {ProfileSize size = ProfileSize.w185}) {
    if (path == null || path.isEmpty) return null;
    return '${_config.images.secureBaseUrl}${_sizeToString(size)}$path';
  }

  /// Builds a still URL with the specified size
  String? buildStillUrl(String? path, {StillSize size = StillSize.w300}) {
    if (path == null || path.isEmpty) return null;
    return '${_config.images.secureBaseUrl}${_sizeToString(size)}$path';
  }

  /// Builds a logo URL with the specified size
  String? buildLogoUrl(String? path, {LogoSize size = LogoSize.w154}) {
    if (path == null || path.isEmpty) return null;
    return '${_config.images.secureBaseUrl}${_sizeToString(size)}$path';
  }

  /// Gets the original size URL for an image
  String getOriginalUrl(String path) {
    return '${_config.images.secureBaseUrl}original$path';
  }

  /// Converts size enum to string
  String _sizeToString(dynamic size) {
    switch (size) {
      case PosterSize.w92:
      case BackdropSize.w300:
      case ProfileSize.w45:
      case StillSize.w92:
      case LogoSize.w45:
        return 'w92';
      case PosterSize.w154:
      case LogoSize.w92:
        return 'w154';
      case PosterSize.w185:
      case ProfileSize.w185:
      case StillSize.w185:
      case LogoSize.w185:
        return 'w185';
      case PosterSize.w342:
        return 'w342';
      case PosterSize.w500:
      case StillSize.w300:
      case LogoSize.w300:
        return 'w500';
      case PosterSize.w780:
      case BackdropSize.w780:
      case LogoSize.w500:
        return 'w780';
      case BackdropSize.w1280:
        return 'w1280';
      case ProfileSize.h632:
        return 'h632';
      case PosterSize.original:
      case BackdropSize.original:
      case ProfileSize.original:
      case StillSize.original:
      case LogoSize.original:
        return 'original';
      default:
        return 'original';
    }
  }
}
