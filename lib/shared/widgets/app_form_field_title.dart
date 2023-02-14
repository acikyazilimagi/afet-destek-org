import 'package:afet_destek/shared/theme/color_extensions.dart';
import 'package:flutter/material.dart';

class AppFormFieldTitle extends StatelessWidget {
  const AppFormFieldTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: context.appColors.subtitles,
              ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
