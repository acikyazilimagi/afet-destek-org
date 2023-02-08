import 'package:deprem_destek/gen/assets.gen.dart';
import 'package:deprem_destek/shared/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class SmsButton extends StatelessWidget {
  const SmsButton({super.key, required this.phoneNumber});
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.red,
          textStyle: const TextStyle(
            fontWeight: FontWeight.w400,
          ),
        ),
        onPressed: () async {
          // TODO(resultanyildizi): incoming phone number must be correct
          final smsLaunchUri = Uri(
            scheme: 'sms',
            path: phoneNumber,
            queryParameters: <String, String>{
              'body':
                  Uri.encodeComponent('Example Subject & Symbols are allowed!'),
            },
          );

          await launchUrl(smsLaunchUri);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(Assets.sms),
            const SizedBox(width: 4),
            const Text('SMS ile ulaş'),
          ],
        ),
      ),
    );
  }
}
