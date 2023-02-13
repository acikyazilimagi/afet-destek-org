import 'package:afet_destek/shared/state/lang_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageDropdown extends StatelessWidget {
  const LanguageDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: context.read<LangCubit>().state,
      items: AppLang.values
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(e.langName),
            ),
          )
          .toList(),
      onChanged: (AppLang? locale) {
        if (locale == null) return;
        context.read<LangCubit>().setLocale(
              context,
              locale,
            );
      },
    );
  }
}
