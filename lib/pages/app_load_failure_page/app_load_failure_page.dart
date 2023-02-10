import 'package:afet_destek/gen/assets.gen.dart';
import 'package:afet_destek/pages/location_tutorial/location_tutorial_page.dart';
import 'package:afet_destek/shared/util/web_reload/web_reload.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppLoadFailurePage extends StatelessWidget {
  const AppLoadFailurePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // implement try again button that calls AppCubit.load again
    // implement a location required warning in the page
    return Scaffold(
      body: SizedBox(
        width: 700,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox.square(
                dimension: size.height * .2,
                child: SvgPicture.asset(Assets.logoSvg),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Lütfen konum izni verdiğinizden emin olun.',
                  textAlign: TextAlign.center,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Konum izni verdiğinizden emin olun.',
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                width: size.width,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  child: ElevatedButton(
                    onPressed: () {
                      if (kIsWeb) {
                        WebReload.reload();
                      } else {
                        // TODO(Nihatcan): for mobile action
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6,
                      ),
                      child: Text(
                        'Sayfayı Yenile',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: size.width,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        width: 2,
                        color: Colors.red,
                      ),
                    ),
                    onPressed: () {
                      LocationTutorialPage.show(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6,
                      ),
                      child: Text(
                        'Konumumu nasıl açarım?',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              fontSize: 16,
                              color: Colors.red,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
