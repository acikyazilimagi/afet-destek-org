import 'package:afet_destek/shared/theme/color_extensions.dart';
import 'package:flutter/material.dart';

class MyDemandButton extends StatelessWidget {
  const MyDemandButton({
    super.key,
    required this.text,
    required this.onTap,
  });
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
          color: context.appColors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
