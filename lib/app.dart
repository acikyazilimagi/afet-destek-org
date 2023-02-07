import 'package:deprem_destek/data/repository/auth_repository.dart';
import 'package:deprem_destek/data/repository/demands_repository.dart';
import 'package:deprem_destek/pages/demands_page/demands_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DepremDestekApp extends StatefulWidget {
  const DepremDestekApp({super.key});

  @override
  State<DepremDestekApp> createState() => _DepremDestekAppState();
}

class _DepremDestekAppState extends State<DepremDestekApp> {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider<DemandsRepository>(
          create: (context) => DemandsRepository(),
        ),
      ],
      child: const MaterialApp(
        home: DemandsPage(),
      ),
    );
  }
}
