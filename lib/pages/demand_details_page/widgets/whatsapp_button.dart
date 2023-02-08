import 'package:deprem_destek/gen/assets.gen.dart';
import 'package:deprem_destek/shared/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsappButton extends StatelessWidget {
  const WhatsappButton({super.key, required this.phoneNumber});
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.whatsapp,
          textStyle: const TextStyle(
            fontWeight: FontWeight.w400,
          ),
        ),
        onPressed: () async {
          // TODO(resultanyildizi): incoming phone number should start with 0
          final whatsapplink = 'https://wa.me/$phoneNumber';

          final uri = Uri.parse(whatsapplink);
          await launchUrl(uri);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(Assets.whatsapp),
            const SizedBox(width: 4),
            const Text('Whatsapp ile ulaş'),
          ],
        ),
      ),
    );
  }
}
