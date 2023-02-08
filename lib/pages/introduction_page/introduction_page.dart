import 'package:deprem_destek/shared/state/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text('konum izni ver'),
          onPressed: () => context.read<AppCubit>().startApp(),
        ),
      ),
    );
  }
}
