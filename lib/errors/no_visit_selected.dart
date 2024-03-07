class NoVisitSelectedException implements Exception {
  final String message = 'No Visit Selected.';

  @override
  String toString() {
    return message;
  }
}
