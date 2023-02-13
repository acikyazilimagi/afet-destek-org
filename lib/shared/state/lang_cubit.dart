import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum AppLang {
  tr,
  en,
  ar;

  Locale get locale {
    switch (this) {
      case AppLang.tr:
        return const Locale('tr', 'TR');
      case AppLang.en:
        return const Locale('en', 'US');
      case AppLang.ar:
        return const Locale('ar', 'SY');
    }
  }

  String get langName {
    switch (this) {
      case AppLang.tr:
        return 'Türkçe';
      case AppLang.en:
        return 'English';
      case AppLang.ar:
        return 'العربية';
    }
  }
}

extension LangCode on String? {
  AppLang toLangEnum() {
    switch (this) {
      case 'tr':
        return AppLang.tr;
      case 'en':
        return AppLang.en;
      case 'ar':
        return AppLang.ar;
      default:
        return AppLang.tr;
    }
  }
}

extension LangCodeLocale on Locale {
  AppLang toLangEnum() => languageCode.toLangEnum();
}

class LangCubit extends Cubit<AppLang> {
  LangCubit({
    required String? languageCode,
  }) : super(
          languageCode.toLangEnum(),
        );

  void setLocale(
    BuildContext context,
    AppLang lang,
  ) {
    EasyLocalization.of(context)?.setLocale(lang.locale);
    emit(lang);
  }
}
