import 'package:afet_destek/gen/translations/locale_keys.g.dart';
import 'package:afet_destek/shared/extensions/translation_extension.dart';
import 'package:afet_destek/shared/theme/color_extensions.dart';
import 'package:flutter/material.dart';

class CoreConfirmationDialog extends StatelessWidget {
  const CoreConfirmationDialog({
    super.key,
    this.onPrimaryButton,
    this.onSecondaryButton,
    this.title,
    this.primaryButtonText,
    this.secondaryButtonText,
    this.subtitle,
  });
  final void Function()? onPrimaryButton;
  final void Function()? onSecondaryButton;
  final String? title;
  final String? subtitle;
  final String? primaryButtonText;
  final String? secondaryButtonText;

  Future<void> show({
    required BuildContext context,
    required void Function() onPrimaryButton,
    required void Function() onSecondaryButton,
    required String title,
    required String subtitle,
    required String primaryButtonText,
    required String secondaryButtonText,
  }) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.info_outline),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 16,
                        color: context.appColors.titles,
                      ),
                ),
              ],
            ),
            const Divider(),
          ],
        ),
        content: CoreConfirmationDialog(
          onPrimaryButton: onPrimaryButton,
          onSecondaryButton: onSecondaryButton,
          primaryButtonText: primaryButtonText,
          secondaryButtonText: secondaryButtonText,
          title: title,
          subtitle: subtitle,
        ),
      ),
    );
  }

  ElevatedButton getButton({
    required BuildContext context,
    required bool isPrimary,
  }) {
    return ElevatedButton(
      onPressed: isPrimary ? onPrimaryButton : onSecondaryButton,
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll<Color>(
          isPrimary ? context.appColors.mainRed : context.appColors.white,
        ),
        shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: isPrimary ? BorderSide.none : const BorderSide(),
          ),
        ),
      ),
      child: Text(
        isPrimary
            ? primaryButtonText ?? LocaleKeys.approve_single.getStr()
            : secondaryButtonText ?? LocaleKeys.give_up.getStr(),
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 16,
              color: isPrimary
                  ? context.appColors.white
                  : context.appColors.notificationTermTexts,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 4,
      child: Column(
        children: [
          const Spacer(),
          Expanded(
            child: Text(
              subtitle ?? '',
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: SizedBox(
                  height: 56,
                  child: getButton(
                    isPrimary: false,
                    context: context,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                flex: 5,
                child: SizedBox(
                  height: 56,
                  child: getButton(
                    isPrimary: true,
                    context: context,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
