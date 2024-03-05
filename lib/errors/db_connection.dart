class MongoDbConnectionException implements Exception {
  final String message;

  MongoDbConnectionException({required this.message});
}
