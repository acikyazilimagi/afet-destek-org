import 'package:afet_destek/shared/theme/color_extensions.dart';
import 'package:flutter/material.dart';

class NewDemandInformationPopup extends StatelessWidget {
  const NewDemandInformationPopup._({
    this.onClose,
    this.onContinue,
  });
  final void Function()? onClose;
  final void Function()? onContinue;

  static const String _newDemandInformationText = '''
Oluşturulacak yardım talebi sadece bulunduğunuz konuma talep oluşturmaktadır. Yardıma ihtiyacı olanlara hızlı erişebilmemiz için, lütfen afet bölgesinde değilseniz talep oluşturmayınız.''';

  static Future<void> show({
    required BuildContext context,
    required void Function() onClose,
    required void Function() onContinue,
  }) {
    return showDialog(
      context: context,
      builder: (context) => NewDemandInformationPopup._(
        onClose: onClose,
        onContinue: onContinue,
      ),
    );
  }

  ElevatedButton getElevatedButton({
    required BuildContext context,
    required bool stillCreate,
  }) {
    return ElevatedButton(
      onPressed: stillCreate ? onContinue : onClose,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            stillCreate ? context.appColors.mainRed : context.appColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: stillCreate ? BorderSide.none : const BorderSide(),
        ),
        padding: EdgeInsets.zero,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Text(
          stillCreate ? 'Yine de oluştur' : 'Vazgeç',
          style: TextStyle(
            fontSize: 16,
            color: stillCreate
                ? context.appColors.white
                : context.appColors.notificationTermTexts,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      child: SizedBox(
        height: (MediaQuery.of(context).size.height * .35).clamp(0, 400),
        width: (MediaQuery.of(context).size.width * .95).clamp(0, 500),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Icon(Icons.info_outline),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      'Bilgilendirme',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontSize: 16,
                            color: context.appColors.titles,
                          ),
                    ),
                  ),
                ],
              ),
              const Divider(),
              const Expanded(
                child: Text(
                  _newDemandInformationText,
                ),
              ),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  SizedBox(
                    height: (MediaQuery.of(context).size.height * 0.06)
                        .clamp(0, 54),
                    child: getElevatedButton(
                      stillCreate: false,
                      context: context,
                    ),
                  ),
                  SizedBox(
                    height: (MediaQuery.of(context).size.height * 0.06)
                        .clamp(0, 54),
                    child: getElevatedButton(
                      stillCreate: true,
                      context: context,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
