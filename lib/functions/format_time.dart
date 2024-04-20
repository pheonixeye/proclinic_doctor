String formatTime(int hour, int minute) {
  if (hour < 12) {
    return "$hour:$minute ${"A.M."}";
  } else if (hour > 12) {
    return "${hour - 12}:$minute ${"P.M."}";
  } else {
    return "$hour:$minute ${"P.M."}";
  }
}

String formatDate(String date) {
  final d = DateTime.parse(date);
  return "${d.day}-${d.month}-${d.year} - ${formatTime(d.hour, d.minute)}";
}

String formatDateWithoutTime(String date) {
  final d = DateTime.parse(date);
  return "${d.day}-${d.month}-${d.year}";
}
