class NoInternetException implements Exception {}

class ServerException implements Exception {
  final String message;

  const ServerException({
    required this.message,
  });
}

class CacheException implements Exception {}

class NullException implements Exception {}

class NoDataException implements Exception {}
