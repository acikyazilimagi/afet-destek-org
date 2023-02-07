import 'package:deprem_destek/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyASFP7KxEb8f1JbiDkXDzsj1-e7bPRoaw0',
      appId: '1:529071733784:web:dfa3729d7ed5c5494c976d',
      messagingSenderId: '529071733784',
      projectId: 'deprem-destek-org',
    ),
  );
  runApp(
    Sizer(
      builder: (BuildContext context, Orientation orientation, DeviceType deviceType) {
        return const DepremDestekApp();
      },
    ),
  );
}
