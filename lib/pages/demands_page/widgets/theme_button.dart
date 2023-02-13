import 'package:afet_destek/shared/theme/state/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeButton extends StatelessWidget {
  const ThemeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 30),
      child: IconButton(
        onPressed: () {
          context.read<ThemeCubit>().switchTheme();
        },
        icon: const Icon(Icons.light_mode),
      ),
    );
  }
}
