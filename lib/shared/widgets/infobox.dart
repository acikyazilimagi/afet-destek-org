import 'package:afet_destek/shared/theme/colors.dart';
import 'package:flutter/material.dart';

class Infobox extends StatelessWidget {
  const Infobox({super.key, required this.info});
  final String info;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.cardBorderColor,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Container(
              width: 10,
              margin: const EdgeInsets.only(right: 8),
              height: MediaQuery.of(context).size.height,
              color: AppColors.red,
            ),
            Text(
              info,
              style: const TextStyle(height: 1.5),
            )
          ],
        ),
      ),
    );
  }
}
