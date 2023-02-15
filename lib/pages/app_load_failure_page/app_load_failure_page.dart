import 'package:afet_destek/gen/assets.gen.dart';
import 'package:afet_destek/gen/translations/locale_keys.g.dart';
import 'package:afet_destek/pages/location_tutorial/location_tutorial_page.dart';
import 'package:afet_destek/shared/extensions/translation_extension.dart';
import 'package:afet_destek/shared/theme/color_extensions.dart';
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
      body: Center(
        child: SizedBox(
          width: 700,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox.square(
                  dimension: size.height * .2,
                  child: SvgPicture.asset(Assets.logoSvg),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    LocaleKeys.error_ocured_when_page_loading.getStr(),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    LocaleKeys
                        .please_make_sure_give_your_localization_permissions
                        .getStr(),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  width: size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 12,
                    ),
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
                          LocaleKeys.refresh_page.getStr(),
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    fontSize: 16,
                                    color: context.appColors.white,
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
                          LocaleKeys.how_can_give_access_your_location.getStr(),
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    fontSize: 16,
                                    color: Colors.red,
                                  ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const SelectableText('info@afetdestek.org')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
