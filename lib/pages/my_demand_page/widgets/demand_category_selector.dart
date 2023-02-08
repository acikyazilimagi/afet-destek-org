import 'package:collection/collection.dart';
import 'package:deprem_destek/shared/state/app_cubit.dart';
import 'package:deprem_destek/shared/theme/colors.dart';
import 'package:deprem_destek/shared/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
              suffixIcon: const Icon(Icons.arrow_forward_ios_sharp),
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
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * .6,
                        minHeight: MediaQuery.of(context).size.height * .6,
                        minWidth: MediaQuery.of(context).size.width * .9,
                        maxWidth: MediaQuery.of(context).size.width * .9,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  'İhtiyaç Türü ${_selectedCategoryIds.length}',
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                              IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  icon: const Icon(Icons.close))
                            ],
                          ),
                          const Divider(),
                          ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: demandCategories.length,
                            itemBuilder: (context, index) {
                              final category = demandCategories[index];
                              final isSelected =
                                  _selectedCategoryIds.contains(category.id);
                              return CheckboxListTile(
                                contentPadding: EdgeInsets.zero,
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                title: Text(category.name),
                                value: isSelected,
                                onChanged: (value) {
                                  setState(
                                    () => isSelected
                                        ? _selectedCategoryIds
                                            .remove(category.id)
                                        : _selectedCategoryIds.add(category.id),
                                  );
                                  setStateForAlert(() {});

                                  widget.formControl.value =
                                      _selectedCategoryIds;
                                },
                              );
                            },
                          ),
                          const Divider(),
                          Text('Birden fazla seçim yapabilirsiniz',
                              style: Theme.of(context).textTheme.bodySmall),
                          const SizedBox(height: 6),
                          SizedBox(
                            height: 56,
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              onPressed: () => Navigator.of(context).pop(),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  'Kaydet',
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
