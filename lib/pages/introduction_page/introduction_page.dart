// ignore_for_file: avoid_escaping_inner_quotes

import 'package:afet_destek/gen/assets.gen.dart';
import 'package:afet_destek/gen/translations/locale_keys.g.dart';
import 'package:afet_destek/pages/kvkk_page/kvkk_page.dart';
import 'package:afet_destek/shared/extensions/translation_extension.dart';
import 'package:afet_destek/shared/state/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:styled_text/styled_text.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({super.key});

  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  bool _isKVKKAccepted = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 700,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(height: height * 0.2),
                buildLogo(height),
                SizedBox(height: height * 0.05),
                buildTitle(context),
                SizedBox(height: height * 0.05),
                buildContent(context),
                SizedBox(height: height * 0.05),
                SizedBox(height: height * 0.01),
                SizedBox(
                  width: width * .8,
                  child: _KVKKCheckBox(
                    isAccepted: _isKVKKAccepted,
                    onAccepted: (value) {
                      setState(() {
                        _isKVKKAccepted = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: height * 0.01),
                SizedBox(
                  width: width * .8,
                  child: ElevatedButton(
                    onPressed: _isKVKKAccepted
                        ? () => context.read<AppCubit>().startApp()
                        : null,
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(width * .8, 50),
                      maximumSize: Size(width * .8, 70),
                    ),
                    child: Text(LocaleKeys.give_access_your_location.getStr()),
                  ),
                ),
                SizedBox(height: height * 0.02),
                const SelectableText('info@afetdestek.org')
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text buildContent(BuildContext context) {
    return Text(
      LocaleKeys.make_sure_you_are_permisson_granted.getStr(),
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.titleSmall,
    );
  }

  Text buildTitle(BuildContext context) {
    return Text(
      LocaleKeys.app_name.getStr(),
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }

  SvgPicture buildLogo(double height) {
    return SvgPicture.asset(
      Assets.logoSvg,
      height: height * .15,
    );
  }
}

class _KVKKCheckBox extends StatelessWidget {
  const _KVKKCheckBox({required this.isAccepted, required this.onAccepted});
  final bool isAccepted;
  final void Function(bool value) onAccepted;

  static bool _isOpenedOnce = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, right: 8),
      child: Row(
        children: [
          SizedBox(
            height: 24,
            width: 24,
            child: Checkbox(
              value: isAccepted,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              onChanged: (value) {
                onAccepted(value ?? false);
                if (!_isOpenedOnce) {
                  TermsPage.show(context, body: kvkkBody, title: kvkkTitle);
                  _isOpenedOnce = true;
                }
              },
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: StyledText(
                textAlign: TextAlign.left,
                maxLines: 1000,
                text: LocaleKeys.kvkk_info.getStr(),
                style: const TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 14,
                ),
                tags: {
                  'link': StyledTextActionTag(
                    (String? text, Map<String?, String?> attrs) {
                      TermsPage.show(
                        context,
                        body: kvkkBody,
                        title: kvkkTitle,
                      );
                    },
                    style: const TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 14,
                    ),
                  ),
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String kvkkTitle = LocaleKeys.kvkk_title.getStr();
String kvkkBody = LocaleKeys.kvkk_text.getStr();
