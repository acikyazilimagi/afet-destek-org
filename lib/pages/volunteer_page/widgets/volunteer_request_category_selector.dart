import 'package:afet_destek/gen/translations/locale_keys.g.dart';
import 'package:afet_destek/shared/extensions/translation_extension.dart';
import 'package:afet_destek/shared/state/app_cubit.dart';
import 'package:afet_destek/shared/theme/color_extensions.dart';
import 'package:afet_destek/shared/widgets/loader.dart';
import 'package:afet_destek/shared/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VolunteerCategorySelector extends StatelessWidget {
  const VolunteerCategorySelector({
    required this.categoryIds,
    required this.onChanged,
    super.key,
  });
  final List<String> categoryIds;
  final void Function(List<String> categoryIds) onChanged;
  @override
  Widget build(BuildContext context) {
    final cats = context
        .read<AppCubit>()
        .state
        .whenOrNull(
          loaded: (currentLocation, demandCategories) => demandCategories,
        )
        ?.toList();

    if (cats == null) {
      return const Loader();
    }

    // cats.sort((a, b) {
    //   return categoryIds.contains(a.id) ? -1 : 1;
    // });

    final demandCategories = cats;

    return Wrap(
      children: demandCategories.map(
        (category) {
          final isSelected = categoryIds.contains(
            category.id,
          );

          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 4,
            ),
            child: ChoiceChip(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              selectedColor: context.appColors.tags,
              selected: isSelected,
              label: Text(category.name),
              onSelected: (value) {
                final ids = List<String>.from(categoryIds);

                if (isSelected) {
                  ids.remove(category.id);
                } else {
                  if (ids.length == 10) {
                    AppSnackbars.failure(
                      LocaleKeys.you_can_only_select_10_categories.getStr(),
                    ).show(context);
                  } else {
                    ids.add(category.id);
                  }
                }

                onChanged(ids);
              },
            ),
          );
        },
      ).toList(),
    );
  }
}
