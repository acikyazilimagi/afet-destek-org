import 'package:flutter/material.dart';

void showInfoSnackBar(
  BuildContext context,
  String message, {
  Duration duration = const Duration(milliseconds: 3000),
}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      content: Text(
        message,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSecondary,
          fontSize: 15,
        ),
      ),
      duration: duration,
      elevation: 0,
    ),
  );
}

void showFailureSnackBar(
  BuildContext context,
  String message, {
  Duration duration = const Duration(seconds: 5),
  Color? backgroundColor,
  Color? foregroundColor,
}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.error,
      content: Text(
        message,
        style: TextStyle(
          color: foregroundColor ?? Theme.of(context).colorScheme.onError,
          fontSize: 15,
        ),
      ),
      duration: duration,
      elevation: 0,
    ),
  );
}
