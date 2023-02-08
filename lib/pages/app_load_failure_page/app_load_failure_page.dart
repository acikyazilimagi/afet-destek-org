//import 'package:deprem_destek/data/models/app_images/app_images.dart';
import 'package:deprem_destek/shared/state/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppLoadFailurePage extends StatelessWidget {
  const AppLoadFailurePage({super.key});

  @override
  Widget build(BuildContext context) {
    // implement try again button that calls AppCubit.load again
    // implement a location required warning in the page
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Lokasyon izni verdiğinizden emin olunuz.'),
            //! Usage of base64 images. Photos can change in the future.
            //Image(image: AppImages.askLocationPage1),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: context.read<AppCubit>().load,
              child: const Text('Tekrar Dene'),
            )
          ],
        ),
      ),
    );
  }
}
