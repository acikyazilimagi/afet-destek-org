import 'package:afet_destek/shared/theme/color_extensions.dart';
import 'package:flutter/material.dart';

class AppInfoBanner extends StatefulWidget {
  const AppInfoBanner({super.key});

  @override
  State<AppInfoBanner> createState() => _AppInfoBannerState();
}

class _AppInfoBannerState extends State<AppInfoBanner> {
  _AppInfoLang _lang = _AppInfoLang.tr;
  static bool _hidden = false;
  @override
  Widget build(BuildContext context) {
    if (_hidden) {
      return const SizedBox.shrink();
    }
    var info = '';
    if (_lang == _AppInfoLang.tr) {
      info = _infoTr;
    } else if (_lang == _AppInfoLang.en) {
      info = _infoEn;
    } else if (_lang == _AppInfoLang.ar) {
      info = _infoAr;
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: context.appColors.white,
            border: Border(
              left: BorderSide(width: 8, color: context.appColors.mainRed),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 24, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Wrap(
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: _lang == _AppInfoLang.tr
                                  ? context.appColors.disabledButton
                                  : null,
                            ),
                            onPressed: () =>
                                setState(() => _lang = _AppInfoLang.tr),
                            child: const Text('TR'),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: _lang == _AppInfoLang.en
                                  ? context.appColors.disabledButton
                                  : null,
                            ),
                            onPressed: () =>
                                setState(() => _lang = _AppInfoLang.en),
                            child: const Text('EN'),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: _lang == _AppInfoLang.ar
                                  ? context.appColors.disabledButton
                                  : null,
                            ),
                            onPressed: () =>
                                setState(() => _lang = _AppInfoLang.ar),
                            child: const Text('AR'),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        setState(() {
                          _hidden = true;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  info,
                  textDirection: _lang == _AppInfoLang.ar
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum _AppInfoLang {
  tr,
  en,
  ar,
}

const _infoTr =
    '''Bu platform, yardıma ihtiyacı olan depremzedeler ile yardım etmek isteyen gönüllüleri bir araya getirmek amacıyla kurulmuştur. Daha fazla yardımseverin haberdar olması için lütfen bizi tüm sosyal medya kanallarında paylaşın.''';
const _infoEn =
    '''This platform was established to bring together earthquake victims who need help and volunteers who want to help. Please share us on all social media channels so that more donors will be notified.''';
const _infoAr =
    '''تم إنشاء هذه المنصة لجمع ضحايا الزلزال الذين يحتاجون إلى المساعدة والمتطوعين الذين يرغبون في المساعدة. يرجى مشاركتنا على جميع قنوات التواصل الاجتماعي لإعلام المزيد من المتبرعين.''';
