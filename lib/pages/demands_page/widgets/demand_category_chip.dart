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
      margin: const EdgeInsets.only(right: 4, bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: const TextStyle(color: AppColors.chipTextColor),
      ),
    );
  }
}
