import 'package:afet_destek/shared/theme/colors.dart';
import 'package:flutter/material.dart';

class NewDemandInformationPopup extends StatelessWidget {
  const NewDemandInformationPopup({
    super.key,
    this.onClose,
    this.onStillCreate,
  });
  final void Function()? onClose;
  final void Function()? onStillCreate;

  static const String _newDemandInformationText = '''
Oluşturulacak yardım talebi sadece bulunduğunuz konuma talep oluşturmaktadır. Yardıma ihtiyacı olanlara hızlı erişebilmemiz için, lütfen afet bölgesinde değilseniz talep oluşturmayınız.''';

  Future<void> show({
    required BuildContext context,
    required void Function() onClose,
    required void Function() onStillCreate,
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
                  'Bilgilendirme',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 16,
                        color: AppColors.textColor,
                      ),
                ),
              ],
            ),
            const Divider(),
          ],
        ),
        content: NewDemandInformationPopup(
          onClose: onClose,
          onStillCreate: onStillCreate,
        ),
      ),
    );
  }

  ElevatedButton getElevatedButton({
    required BuildContext context,
    required bool stillCreate,
  }) {
    return ElevatedButton(
      onPressed: stillCreate ? onStillCreate : onClose,
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll<Color>(
          stillCreate ? AppColors.red : AppColors.white,
        ),
        shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: stillCreate ? BorderSide.none : const BorderSide(),
          ),
        ),
      ),
      child: Text(
        stillCreate ? 'Yine de oluştur' : 'Vazgeç',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 16,
              color: stillCreate ? AppColors.white : AppColors.darkGrey,
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
          const Expanded(
            child: Text(
              _newDemandInformationText,
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: SizedBox(
                  height: 56,
                  child: getElevatedButton(
                    stillCreate: false,
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
                  child: getElevatedButton(
                    stillCreate: true,
                    context: context,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
