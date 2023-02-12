import 'package:afet_destek/gen/translations/locale_keys.g.dart';
import 'package:afet_destek/shared/extensions/translation_extension.dart';
import 'package:afet_destek/shared/theme/color_extensions.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsappButton extends StatelessWidget {
  const WhatsappButton({super.key, required this.phoneNumber});
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: context.appColors.whatsApp,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w400,
        ),
        padding: EdgeInsets.zero,
      ),
      onPressed: () async {
        // TODO(resultanyildizi): incoming phone number should start with 0
        final whatsapplink =
            'https://api.whatsapp.com/send?phone=${Uri.encodeComponent(phoneNumber)}';

        final uri = Uri.parse(whatsapplink);
        await launchUrl(uri);
      },
      child: SizedBox(
        height: 40,
        child: Center(
          child: Text(
            LocaleKeys.whatsapp.getStr(),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
