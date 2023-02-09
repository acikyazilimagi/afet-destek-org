import 'package:afet_destek/shared/util/web_reload/io/web_reload.dart'
    if (dart.library.html) 'package:afet_destek/shared/util/web_reload/html/web_reload.dart'
    as html;

class WebReload {
  static void reload() {
    html.WebReload.reload();
  }
}
