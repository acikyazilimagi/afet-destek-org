import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) => Center(
        child: CupertinoActivityIndicator(
          radius: 12,
          color: Theme.of(context).colorScheme.secondary,
        ),
      );
}
