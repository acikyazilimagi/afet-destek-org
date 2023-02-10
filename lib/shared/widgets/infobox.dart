import 'package:afet_destek/shared/theme/color_extensions.dart';
import 'package:flutter/material.dart';

class Infobox extends StatelessWidget {
  const Infobox({super.key, required this.info});
  final String info;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: context.appColors.white,
          border: Border(
            left: BorderSide(width: 8, color: context.appColors.mainRed),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 24, 16),
          child: Text(
            info,
            style: const TextStyle(height: 1.5),
          ),
        ),
      ),
    );
  }
}
