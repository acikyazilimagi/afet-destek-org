import 'package:afet_destek/gen/translations/locale_keys.g.dart';
import 'package:afet_destek/shared/extensions/translation_extension.dart';
import 'package:afet_destek/shared/state/app_cubit.dart';
import 'package:afet_destek/shared/theme/color_extensions.dart';
import 'package:afet_destek/shared/widgets/loader.dart';
import 'package:afet_destek/shared/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

class VolunteerCategorySelector extends StatelessWidget {
  const VolunteerCategorySelector({required this.formControl, super.key});
  final FormControl<List<String>> formControl;

  @override
  Widget build(BuildContext context) {
    final selectedCategoryIds = List<String>.from(formControl.value ?? []);

    final cats = context
        .read<AppCubit>()
        .state
        .whenOrNull(
          loaded: (currentLocation, position, demandCategories) =>
              demandCategories,
        )
        ?.toList();

    if (cats == null) {
      return const Loader();
    }

    cats.sort((a, b) {
      return selectedCategoryIds.contains(a.id) ? -1 : 1;
    });

    final demandCategories = cats;

    return Expanded(
      child: Align(
        alignment: Alignment.topLeft,
        child: SingleChildScrollView(
          child: Wrap(
            children: demandCategories.map(
              (category) {
                final isSelected = selectedCategoryIds.contains(
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
                      final ids = selectedCategoryIds;

                      if (isSelected) {
                        ids.remove(category.id);
                      } else {
                        if (ids.length == 10) {
                          AppSnackbars.failure(
                            LocaleKeys.you_can_only_select_10_categories
                                .getStr(),
                          ).show(context);
                        } else {
                          ids.add(category.id);
                        }
                      }

                      formControl.value = ids;
                    },
                  ),
                );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }
}
