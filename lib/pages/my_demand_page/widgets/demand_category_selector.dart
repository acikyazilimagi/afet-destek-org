import 'package:collection/collection.dart';
import 'loader.dart';
import '../../../shared/state/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

class DemandCategorySelector extends StatefulWidget {
  const DemandCategorySelector({required this.formControl, super.key});
  final FormControl<List<String>> formControl;

  @override
  State<DemandCategorySelector> createState() => _DemandCategorySelectorState();
}

class _DemandCategorySelectorState extends State<DemandCategorySelector> {
  late List<String> _selectedCategoryIds;

  @override
  Widget build(BuildContext context) {
    // ignore: cast_nullable_to_non_nullable
    _selectedCategoryIds = List.from(widget.formControl.value as List<String>);

    final demandCategories = context.read<AppCubit>().state.whenOrNull(
          loaded: (currentLocation, demandCategories) => demandCategories,
        );

    if (demandCategories == null) {
      return const Loader();
    }

    return Column(
      children: [
        TextFormField(
          onTap: () => showDialog<void>(
            context: context,
            builder: (context) => StatefulBuilder(
              builder: (context, setStateForAlert) {
                return Dialog(
                  child: ListView.builder(
                    itemCount: demandCategories.length,
                    itemBuilder: (context, index) {
                      final category = demandCategories[index];
                      final isSelected =
                          _selectedCategoryIds.contains(category.id);
                      return GestureDetector(
                        onTap: () {
                          setState(
                            () => isSelected
                                ? _selectedCategoryIds.remove(category.id)
                                : _selectedCategoryIds.add(category.id),
                          );
                          setStateForAlert(() {});

                          widget.formControl.value = _selectedCategoryIds;
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Expanded(child: Text(category.name)),
                              Icon(
                                Icons.check,
                                color: isSelected ? Colors.green : Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(
            alignment: WrapAlignment.spaceEvenly,
            runAlignment: WrapAlignment.center,
            spacing: 12,
            children: _selectedCategoryIds.map(
              (categoryId) {
                final category = demandCategories.firstWhereOrNull(
                  (c) => c.id == categoryId,
                );
                return RawChip(
                  label: Text(
                    category?.name ?? '-',
                  ),
                  onDeleted: () {
                    setState(() {
                      _selectedCategoryIds
                          .removeWhere((cId) => cId == categoryId);

                      widget.formControl.value = _selectedCategoryIds;
                    });
                  },
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }
}
