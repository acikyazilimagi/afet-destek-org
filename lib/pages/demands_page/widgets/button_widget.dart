import 'package:flutter/material.dart';

class BorderButton extends StatelessWidget {
   BorderButton({required this.onPressed, required this.text,
    super.key, 
  });

 void Function()? onPressed;
 final String text;
  @override
  Widget build(BuildContext context) {
    const edgeInsets = EdgeInsets.symmetric(horizontal: 30.0);
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xffD0D5DD),
          side: const BorderSide(
            color: Color(0xffD0D5DD),
            width: 1,
          ),
        ),
        onPressed: onPressed,
        child:  Padding(
          padding: edgeInsets,
          child: Text(text),
        ));
  }
}

class RedButton extends StatelessWidget {
  const RedButton({
    super.key,
    required this.redColor,
    required this.text
  });

  final Color redColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: redColor),
        onPressed: () {},
        child: Text(text));
  }
}

