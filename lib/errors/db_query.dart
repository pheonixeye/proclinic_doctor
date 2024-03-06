class MongoDbQueryError implements Exception {
  final String message;

  MongoDbQueryError({required this.message});

  @override
  String toString() {
    return message;
  }
}
