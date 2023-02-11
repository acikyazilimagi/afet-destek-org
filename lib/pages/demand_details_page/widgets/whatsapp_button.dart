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
      ),
      onPressed: () async {
        // TODO(resultanyildizi): incoming phone number should start with 0
        final whatsapplink =
            'https://api.whatsapp.com/send?phone=${Uri.encodeComponent(phoneNumber)}';

        final uri = Uri.parse(whatsapplink);
        await launchUrl(uri);
      },
      child: const SizedBox(
        height: 40,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 37.42),
          child: Center(
            child: Text(
              'Whatsapp',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
