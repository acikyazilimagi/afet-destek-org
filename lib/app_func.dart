import 'dart:async';

import 'package:afet_destek/app.dart';
import 'package:afet_destek/utils/logger/app_logger.dart';
import 'package:afet_destek/utils/observer/bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:url_strategy/url_strategy.dart';

class AppFunc {
  static String baseUrl = '';
  static Future<void> start({
    required FirebaseOptions options,
    required String sentryDsn,
    required String url,
  }) async {
    baseUrl = url;
    await SentryFlutter.init(
      (options) {
        options
          ..dsn = sentryDsn
          ..tracesSampleRate = 1.0
          ..reportPackages = false
          ..debug = false;
      },
      appRunner: () => runZonedGuarded(
        () async {
          Bloc.observer = AppBlocObserver();
          // await MixPanelAnalytics.initMixPanelAnalytics();
          await Firebase.initializeApp(
            options: options,
          );

          setPathUrlStrategy();

          runApp(const DepremDestekApp());
        },
        (error, stackTrace) =>
            AppLoggerImpl.log.e(error.toString(), stackTrace),
      ),
    );
  }
}

enum AppType {
  dev,
  prod,
}
