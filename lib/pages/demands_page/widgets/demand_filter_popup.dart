import 'package:deprem_destek/pages/demands_page/state/demands_cubit.dart';
import 'package:deprem_destek/shared/state/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DemandFilterPopup extends StatefulWidget {
  const DemandFilterPopup._({required this.demandsCubit});
  final DemandsCubit demandsCubit;
  static void show(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (ctx) {
        return DemandFilterPopup._(
          demandsCubit: context.read<DemandsCubit>(),
        );
      },
    );
  }

  @override
  State<DemandFilterPopup> createState() => _DemandFilterPopupState();
}

class _DemandFilterPopupState extends State<DemandFilterPopup> {
  late List<String> _categoryIds;
  double? _filterRadiusKm;
  @override
  void initState() {
    super.initState();
    _categoryIds = List.from(widget.demandsCubit.state.categoryIds ?? []);
    _filterRadiusKm = widget.demandsCubit.state.filterRadiusKm;
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
    final demandCategories = context.read<AppCubit>().state.whenOrNull(
          loaded: (_, demandCategories) => demandCategories,
        )!;

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Slider(
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
            const SizedBox(height: 16),
            Text(
              _filterRadiusKm == null
                  ? 'Her yer'
                  : '${_filterRadiusKm!.toInt()} KM',
            ),
            const SizedBox(height: 16),
            Wrap(
              children: demandCategories.map(
                (category) {
                  final isSelected = _categoryIds.contains(category.id);
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: ChoiceChip(
                      avatar: isSelected
                          ? const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 16,
                            )
                          : null,
                      selected: isSelected,
                      label: Text(category.name),
                      onSelected: (value) => setState(() {
                        if (isSelected) {
                          _categoryIds.remove(category.id);
                        } else {
                          _categoryIds.add(category.id);
                        }
                      }),
                    ),
                  );
                },
              ).toList(),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _onSave,
              child: const Text('Filtrele'),
            )
          ],
        ),
      ),
    );
  }
}
