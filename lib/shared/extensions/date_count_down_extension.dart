import 'package:afet_destek/gen/translations/locale_keys.g.dart';
import 'package:afet_destek/shared/extensions/translation_extension.dart';

extension DateCountDown on DateTime {
  String get asElapsedTimeString {
    final delta = DateTime.now().difference(this);
    if (delta.inMinutes < 1) {
      return LocaleKeys.duration_second.getStrPlural(delta.inSeconds);
    } else if (delta.inHours < 1) {
      return LocaleKeys.duration_min.getStrPlural(delta.inMinutes);
    } else if (delta.inDays < 1) {
      return LocaleKeys.duration_hour.getStrPlural(delta.inHours);
    } else {
      return LocaleKeys.duration_day.getStrPlural(delta.inDays);
    }
  }
}
