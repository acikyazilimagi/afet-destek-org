import 'package:collection/collection.dart';
import 'package:deprem_destek/shared/state/app_cubit.dart';
import 'package:deprem_destek/shared/widgets/loader.dart';
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: TextFormField(
            readOnly: true,
            decoration: InputDecoration(
              hintText: 'Kategori seçin',
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(width: 2, color: Colors.red),
              ),
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(width: 2, color: Colors.grey.shade200),
              ),
              hintStyle: TextStyle(color: Colors.grey.shade500),
            ),
            onTap: () => showDialog<void>(
              context: context,
              builder: (context) => StatefulBuilder(
                builder: (context, setStateForAlert) {
                  return Dialog(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * .5,
                        minHeight: MediaQuery.of(context).size.height * .5,
                        minWidth: MediaQuery.of(context).size.width * .8,
                        maxWidth: MediaQuery.of(context).size.width * .8,
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: demandCategories.length,
                              itemBuilder: (context, index) {
                                final category = demandCategories[index];
                                final isSelected =
                                    _selectedCategoryIds.contains(category.id);
                                return GestureDetector(
                                  onTap: () {
                                    setState(
                                      () => isSelected
                                          ? _selectedCategoryIds
                                              .remove(category.id)
                                          : _selectedCategoryIds
                                              .add(category.id),
                                    );
                                    setStateForAlert(() {});

                                    widget.formControl.value =
                                        _selectedCategoryIds;
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Card(
                                      color: isSelected
                                          ? Colors.grey
                                          : Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                category.name,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              onPressed: () => Navigator.of(context).pop(),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  'Tamam',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(
            alignment: WrapAlignment.spaceEvenly,
            spacing: 12,
            children: _selectedCategoryIds.map(
              (categoryId) {
                final category = demandCategories.firstWhereOrNull(
                  (c) => c.id == categoryId,
                );
                return RawChip(
                  padding: const EdgeInsets.all(12),
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: Colors.grey),
                  ),
                  label: Text(
                    category?.name ?? '-',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  labelStyle: Theme.of(context).textTheme.bodyLarge,
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
