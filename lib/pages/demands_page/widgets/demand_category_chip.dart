import 'package:afet_destek/shared/theme/color_extensions.dart';
import 'package:flutter/material.dart';

class DemandCategoryChip extends StatelessWidget {
  const DemandCategoryChip({
    super.key,
    required this.label,
  });
  final String label;
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffD0D5DD)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: context.appColors.paragraph,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
