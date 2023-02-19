import 'package:afet_destek/shared/theme/color_extensions.dart';
import 'package:flutter/material.dart';

class DemandTitle extends StatelessWidget {
  const DemandTitle({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: context.appColors.black,
            ),
      ),
    );
  }
}
