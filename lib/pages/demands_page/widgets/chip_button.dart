import 'package:flutter/material.dart';

class ChipButton extends StatelessWidget {
  ChipButton(
      {this.color,
      this.onDeleted,
      this.text,
      this.onTap,
      this.textColor,
      this.backgroundColor,
      this.borderColor,
      super.key});

  Color? color = Colors.black;
  void Function()? onDeleted;
  Color? backgroundColor = Colors.white;
  Color? borderColor = Colors.white;
  String? text = "";
  Color? textColor = Colors.black;
  void Function()? onTap;

  final double width2 = 1.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: GestureDetector(
        onTap: onTap,
        child: Chip(
          deleteIcon: Icon(Icons.close, size: 14, color: color),
          onDeleted: onDeleted,
          backgroundColor: backgroundColor,
          side: BorderSide(color: borderColor ?? Colors.white, width: width2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          label: Text(
            text ?? "",
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: textColor),
          ),
        ),
      ),
    );
  }
}
