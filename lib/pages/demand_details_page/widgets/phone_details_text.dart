import 'package:flutter/material.dart';

class PhoneDetailText extends StatelessWidget {
  const PhoneDetailText({
    super.key,
    required this.phone,
    required this.icon,
  });

  final String phone;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        const SizedBox(width: 8),
        SelectableText(
          phone,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
