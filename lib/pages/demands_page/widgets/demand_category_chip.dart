import 'package:deprem_destek/shared/theme/colors.dart';
import 'package:flutter/material.dart';

class DemandCategoryChip extends StatelessWidget {
  const DemandCategoryChip({
    super.key,
    required this.label,
  });
  final String label;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8, bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffD0D5DD)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: AppColors.textColor,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
