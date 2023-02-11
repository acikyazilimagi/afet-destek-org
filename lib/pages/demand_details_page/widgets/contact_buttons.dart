import 'package:afet_destek/pages/demand_details_page/widgets/copy_button.dart';
import 'package:flutter/material.dart';

class ContactButtons extends StatelessWidget {
  const ContactButtons({
    super.key,
    required this.copyButton,
    required this.actionButton,
  });

  final CopyButton copyButton;
  final Widget actionButton;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: copyButton,
        ),
        const SizedBox(width: 17.2),
        Expanded(
          child: actionButton,
        ),
      ],
    );
  }
}
