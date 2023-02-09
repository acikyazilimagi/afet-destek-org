import 'package:afet_destek/app_func.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //catch Unhandled exceptions and errors
  await AppFunc.start(
    url: 'https://us-central1-deprem-destek-org.cloudfunctions.net/',
    options: const FirebaseOptions(
      apiKey: 'AIzaSyASFP7KxEb8f1JbiDkXDzsj1-e7bPRoaw0',
      appId: '1:529071733784:web:dfa3729d7ed5c5494c976d',
      messagingSenderId: '529071733784',
      projectId: 'deprem-destek-org',
    ),
    sentryDsn:
        'https://bc941e7fb9ab4ae793bbd16c77844d29@o4504644634607616.ingest.sentry.io/4504644636246016',
  );
}
