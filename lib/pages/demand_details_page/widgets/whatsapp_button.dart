import 'package:afet_destek/gen/assets.gen.dart';
import 'package:afet_destek/shared/theme/color_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsappButton extends StatelessWidget {
  const WhatsappButton({super.key, required this.phoneNumber});
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: context.appColors.whatsApp,
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
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(Assets.whatsapp),
            const SizedBox(width: 8),
            const Text('Whatsapp mesajı gönder'),
          ],
        ),
      ),
    );
  }
}
