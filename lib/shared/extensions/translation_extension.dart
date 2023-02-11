import 'package:easy_localization/easy_localization.dart';

extension TranslationExtension on String? {
  String getStr() {
    try {
      if (this == null) {
        assert(false, 'getStr: _inp is null');
        return '';
      }

      final trans = this!.tr();
      final hasTrans = this!.isNotEmpty == true;
      assert(hasTrans, 'getStr: $this is not translated');
      return hasTrans ? trans : '';
    } catch (e) {
      // we do not want to break prod, but at the same
      // time we wanna catch these errors at debug
      assert(false, e);
      return '';
    }
  }

  String getStrArgs({
    required List<String> args,
  }) {
    try {
      if (this == null) {
        assert(false, 'getStr: _inp is null');
        return '';
      }

      final trans = this!.tr(args: args);
      final hasTrans = this!.isNotEmpty == true;
      assert(hasTrans, 'getStr: $this has no translation');
      return hasTrans ? trans : '';
    } catch (e) {
      // we do not want to break prod, but at the same
      // time we wanna catch these errors at debug
      assert(false, e);
      return '';
    }
  }

  String getStrPlural(
    num value, {
    List<String>? args,
    Map<String, String>? namedArgs,
    String? name,
    NumberFormat? format,
  }) {
    try {
      if (this == null) {
        assert(false, 'getStr: _inp is null');
        return '';
      }

      final trans = plural(
        this!,
        value,
        args: args,
        namedArgs: namedArgs,
        name: name,
        format: format,
      );

      final hasTrans = this!.isNotEmpty == true;
      assert(hasTrans, 'getStrPlural: hasTrans is false');
      return hasTrans ? trans : '';
    } catch (e) {
      // we do not want to break prod, but at the same
      // time we wanna catch these errors at debug
      assert(false, e);
      return '';
    }
  }
}
