import 'package:afet_destek/gen/translations/locale_keys.g.dart';
import 'package:afet_destek/shared/extensions/translation_extension.dart';
import 'package:afet_destek/shared/theme/color_extensions.dart';
import 'package:flutter/material.dart';

class AppInfoBanner extends StatefulWidget {
  const AppInfoBanner({super.key});

  @override
  State<AppInfoBanner> createState() => _AppInfoBannerState();
}

class _AppInfoBannerState extends State<AppInfoBanner> {
  static bool _hidden = false;
  @override
  Widget build(BuildContext context) {
    if (_hidden) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: context.appColors.white,
            border: BorderDirectional(
              start: BorderSide(width: 8, color: context.appColors.mainRed),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 24, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.app_info.getStr(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _hidden = true;
                        });
                      },
                      child: Text(
                        LocaleKeys.ok_btn.getStr(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
