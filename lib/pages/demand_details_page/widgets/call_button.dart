import 'package:afet_destek/gen/assets.gen.dart';
import 'package:afet_destek/shared/theme/color_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class CallButton extends StatelessWidget {
  const CallButton({super.key, required this.phoneNumber});
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: context.appColors.mainRed,
        textStyle: const TextStyle(
          fontWeight: FontWeight.w400,
        ),
      ),
      onPressed: () async {
        final smsLaunchUri = Uri(scheme: 'sms', path: phoneNumber);
        await launchUrl(smsLaunchUri);
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(Assets.sms),
            const SizedBox(width: 8),
            Text('SMS ile ulaş ($phoneNumber)'),
          ],
        ),
      ),
    );
  }
}
