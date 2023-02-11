import 'package:afet_destek/shared/extensions/translation_extension.dart';

extension DateCountDown on DateTime {
  String get asElapsedTimeString {
    final delta = DateTime.now().difference(this);
    if (delta.inMinutes < 1) {
      return 'duration_second'.getStrPlural(delta.inSeconds);
    } else if (delta.inHours < 1) {
      return 'duration_min'.getStrPlural(delta.inMinutes);
    } else if (delta.inDays < 1) {
      return 'duration_hour'.getStrPlural(delta.inHours);
    } else {
      return 'duration_day'.getStrPlural(delta.inDays);
    }
  }
}
