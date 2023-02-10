import 'package:afet_destek/pages/demands_page/state/demands_cubit.dart';
import 'package:afet_destek/shared/state/app_cubit.dart';
import 'package:afet_destek/shared/theme/colors.dart';
import 'package:afet_destek/shared/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DemandFilterDrawer extends StatefulWidget {
  const DemandFilterDrawer({required this.demandsCubit, super.key});
  final DemandsCubit demandsCubit;

  static Future<void> show(
    BuildContext context, {
    required DemandsCubit demandsCubit,
  }) async {
    await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(
        builder: (context) {
          return DemandFilterDrawer(
            demandsCubit: demandsCubit,
          );
        },
      ),
    );
  }

  @override
  State<DemandFilterDrawer> createState() => _DemandFilterDrawerState();
}

class _DemandFilterDrawerState extends State<DemandFilterDrawer> {
  late List<String> _categoryIds;
  double? _filterRadiusKm;
  @override
  void initState() {
    super.initState();

    _categoryIds = List.from(widget.demandsCubit.state.categoryIds ?? []);
    _filterRadiusKm = widget.demandsCubit.state.filterRadiusKm;
  }

  void _onClear() {
    setState(() {
      _filterRadiusKm = null;
      _categoryIds.clear();
    });
  }

  void _onSave() {
    widget.demandsCubit.setFilters(
      categoryIds: _categoryIds.isNotEmpty ? _categoryIds : null,
      filterRadiusKm: _filterRadiusKm,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.read<AppCubit>().state;
    final demandCategories = appState
        .whenOrNull(
          loaded: (_, demandCategories) => demandCategories,
        )!
        .toList();

    final selectedList = demandCategories
        .where(
          (element) => _categoryIds.contains(element.id),
        )
        .toList();
    final unSelectedList = demandCategories
        .where(
          (element) => !_categoryIds.contains(element.id),
        )
        .toList();

    demandCategories
      ..clear()
      ..addAll([...selectedList, ...unSelectedList]);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Filtrele',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 24,
                color: AppColors.formFieldTitle,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Slider(
              inactiveColor: Colors.grey[200],
              onChanged: (value) => setState(() {
                if (value == 500) {
                  _filterRadiusKm = null;
                } else {
                  _filterRadiusKm = value;
                }
              }),
              value: _filterRadiusKm ?? 500,
              max: 500,
              min: 1,
            ),
            const SizedBox(height: 8),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Mesafe: ',
                    style: TextStyle(color: Color(0xff475467)),
                  ),
                  TextSpan(
                    text: _filterRadiusKm == null 
                    ? 'Her yer'
                    : '${_filterRadiusKm!.toInt()}km',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 8),
            Divider(
              color: Colors.grey[300],
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.topLeft,
              child: Text('İhtiyaç türü (${_categoryIds.length})'),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.topLeft,
              child: Wrap(
                children: demandCategories.map(
                  (category) {
                    final isSelected = _categoryIds.contains(category.id);
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 4,
                      ),
                      child: ChoiceChip(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        selectedColor: AppColors.descriptionColor,
                        selected: isSelected,
                        label: Text(category.name),
                        onSelected: (value) => setState(() {
                          if (isSelected) {
                            _categoryIds.remove(category.id);
                          } else {
                            if (_categoryIds.length == 10) {
                              const AppSnackbars.failure(
                                'En fazla 10 ihtiyaç eklenebilir.',
                              ).show(context);
                            } else {
                              _categoryIds.add(category.id);
                            }
                          }
                        }),
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: 56,
                    child: getElevatedButton(isFilterButton: false),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  flex: 5,
                  child: SizedBox(
                    height: 56,
                    child: getElevatedButton(isFilterButton: true),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  ElevatedButton getElevatedButton({required bool isFilterButton}) {
    return ElevatedButton(
      onPressed: isFilterButton ? _onSave : _onClear,
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll<Color>(
          isFilterButton ? AppColors.red : AppColors.white,
        ),
        shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      child: Text(
        isFilterButton ? 'Filtrele' : 'Temizle',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 16,
              color: isFilterButton ? AppColors.white : AppColors.darkGrey,
            ),
      ),
    );
  }
}
