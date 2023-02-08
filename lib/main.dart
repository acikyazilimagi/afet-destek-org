import 'package:deprem_destek/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyASFP7KxEb8f1JbiDkXDzsj1-e7bPRoaw0',
      appId: '1:529071733784:web:dfa3729d7ed5c5494c976d',
      messagingSenderId: '529071733784',
      projectId: 'deprem-destek-org',
    ),
  );
  //catch Unhandled exceptions and errors
  await SentryFlutter.init(
    (options) {
      options
        ..dsn =
            'https://bc941e7fb9ab4ae793bbd16c77844d29@o4504644634607616.ingest.sentry.io/4504644636246016'
        ..tracesSampleRate = 1.0
        ..reportPackages = false
        ..debug = false;
    },
    appRunner: () => runApp(const DepremDestekApp()),
  );
}
