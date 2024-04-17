class MongoDbConnectionException implements Exception {
  final String message;

  MongoDbConnectionException({required this.message});

  @override
  String toString() {
    return message;
  }
}
