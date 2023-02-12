import 'package:afet_destek/gen/translations/locale_keys.g.dart';
import 'package:afet_destek/shared/extensions/translation_extension.dart';
import 'package:flutter/material.dart';

class DemandTitle extends StatelessWidget {
  const DemandTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Text(
        LocaleKeys.help_demands.getStr(),
        style: Theme.of(context).textTheme.displaySmall,
      ),
    );
  }
}
