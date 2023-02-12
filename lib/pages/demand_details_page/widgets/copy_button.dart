import 'package:afet_destek/gen/translations/locale_keys.g.dart';
import 'package:afet_destek/shared/extensions/translation_extension.dart';
import 'package:afet_destek/shared/theme/color_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyButton extends StatelessWidget {
  const CopyButton({super.key, required this.phoneNumber});
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        side: BorderSide(color: context.appColors.notificationTermTexts),
        foregroundColor: context.appColors.notificationTermTexts,
        textStyle: const TextStyle(
          fontWeight: FontWeight.w400,
        ),
        padding: EdgeInsets.zero,
      ),
      onPressed: () async {
        await Clipboard.setData(ClipboardData(text: phoneNumber));
      },
      child: SizedBox(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FittedBox(child: Icon(Icons.content_copy_rounded)),
            Text(LocaleKeys.copy_button.getStr()),
          ],
        ),
      ),
    );
  }
}
