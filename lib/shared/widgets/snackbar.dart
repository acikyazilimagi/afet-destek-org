import 'package:afet_destek/gen/translations/locale_keys.g.dart';
import 'package:afet_destek/shared/extensions/translation_extension.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

enum SnackBarStatus { info, failure, success }

class AppSnackbars {
  AppSnackbars.info(this.message)
      : status = SnackBarStatus.info,
        title = LocaleKeys.info.getStr();

  AppSnackbars.failure(this.message)
      : status = SnackBarStatus.failure,
        title = LocaleKeys.error.getStr();

  AppSnackbars.success(this.message)
      : status = SnackBarStatus.success,
        title = LocaleKeys.success.getStr();

  final SnackBarStatus status;
  final String title;
  final String message;

  void show(BuildContext context) {
    switch (status) {
      case SnackBarStatus.info:
        MotionToast.info(
          title: Text(title),
          description: Text(message),
        ).show(context);
        break;
      case SnackBarStatus.failure:
        MotionToast.error(
          title: Text(title),
          description: Text(message),
        ).show(context);
        break;
      case SnackBarStatus.success:
        MotionToast.success(
          title: Text(title),
          description: Text(message),
        ).show(context);
        break;
    }
  }
}
