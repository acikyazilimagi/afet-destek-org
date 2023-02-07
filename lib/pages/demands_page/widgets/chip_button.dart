import 'package:flutter/material.dart';

class ChipButton extends StatefulWidget {
  ChipButton( {this.color, this.onDeleted, this.text, this.onTap,this.textColor,this.backgroundColor,this.borderColor,super.key});

  Color? color = Colors.black;
  void Function()? onDeleted;
  Color? backgroundColor = Colors.white;
  Color? borderColor = Colors.white;
  String? text = "";
  Color? textColor = Colors.black;
  void Function()? onTap;

  @override
  State<ChipButton> createState() => _ChipButtonState();
}

class _ChipButtonState extends State<ChipButton> {
      final double width2 = 1.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Chip(
            deleteIcon: Icon(Icons.close,size: 14, color: widget.color),
            onDeleted: widget.onDeleted,
            backgroundColor:widget.backgroundColor,
            side: BorderSide(color: widget.borderColor ?? Colors.white, width: width2),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            // deleteIcon: Icon(Icons.close),
            label: Text(
              widget.text ?? "",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: widget.textColor),
            )),
      ),
    );
  }
}
