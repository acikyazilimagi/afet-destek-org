extension DateCountDown on DateTime {
  String get asElapsedTimeString {
    final delta = difference(DateTime.now());
    if (delta.inMinutes < 1) {
      return '${delta.inSeconds} Saniye Önce';
    } else if (delta.inHours < 1) {
      return '${delta.inMinutes} Dakika Önce';
    } else if (delta.inDays < 1) {
      return '${delta.inHours} Saat Önce';
    } else {
      return '${delta.inDays} Gün Önce';
    }
  }
}
