import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

enum SnackBarStatus { info, failure, success }

class AppSnackbars {
  const AppSnackbars.info(this.message)
      : status = SnackBarStatus.info,
        title = 'Bilgi';

  const AppSnackbars.failure(this.message)
      : status = SnackBarStatus.failure,
        title = 'Hata';

  const AppSnackbars.success(this.message)
      : status = SnackBarStatus.success,
        title = 'Başarılı';

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
