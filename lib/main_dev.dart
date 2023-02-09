import 'package:afet_destek/app_func.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //catch Unhandled exceptions and errors
  await AppFunc.start(
    url: 'https://us-central1-env-deprem-destek-org.cloudfunctions.net/',
    options: const FirebaseOptions(
      apiKey: 'AIzaSyAwga9Tzl9ODSGdVRNtw8lgAS5MoIl16Ck',
      appId: '1:643767075935:web:3cc9d6c4658af4ded7c7ea',
      messagingSenderId: '643767075935',
      projectId: 'env-deprem-destek-org',
      authDomain: 'env-deprem-destek-org.firebaseapp.com',
      storageBucket: 'env-deprem-destek-org.appspot.com',
      measurementId: 'G-G552720SJK',
    ),
    sentryDsn:
        'https://a472fdea96db4bd3b3ca80ce8583e9ba@o4504644634607616.ingest.sentry.io/4504651796381696',
  );
}
