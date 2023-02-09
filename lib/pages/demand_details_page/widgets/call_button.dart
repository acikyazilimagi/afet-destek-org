import 'package:afet_destek/gen/assets.gen.dart';
import 'package:afet_destek/shared/theme/colors.dart';
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
        backgroundColor: AppColors.red,
        textStyle: const TextStyle(
          fontWeight: FontWeight.w400,
        ),
      ),
      onPressed: () async {
        // TODO(resultanyildizi): incoming phone number must be correct
        final telLaunchUri = Uri(scheme: 'tel', path: phoneNumber);

        await launchUrl(telLaunchUri);
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(Assets.tel),
            const SizedBox(width: 8),
            Text('Telefonla ulaş ($phoneNumber)'),
          ],
        ),
      ),
    );
  }
}
