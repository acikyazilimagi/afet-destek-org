import 'package:deprem_destek/shared/util/web_reload/web_reload.dart';
import 'package:flutter/material.dart';

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
            const Text('Bu sayfa yapım aşamasındadır.'),
            const Text('Lokasyon izni verdiğinizden emin olunuz.'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: WebReload.reload,
              child: const Text('Tekrar Dene'),
            )
          ],
        ),
      ),
    );
  }
}
