import 'package:afet_destek/data/models/demand_category.dart';
import 'package:afet_destek/pages/demands_page/state/demands_cubit.dart';
import 'package:afet_destek/shared/state/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DemandFilterDrawer extends StatefulWidget {
  const DemandFilterDrawer({required this.demandsCubit, super.key});
  final DemandsCubit demandsCubit;

  @override
  State<DemandFilterDrawer> createState() => _DemandFilterDrawerState();
}

class _DemandFilterDrawerState extends State<DemandFilterDrawer> {
  late List<String> _categoryIds;
  double? _filterRadiusKm;
  late List<DemandCategory> demandCategories;
  @override
  void initState() {
    super.initState();
    final appState = context.read<AppCubit>().state;
    demandCategories = appState
        .whenOrNull(loaded: (_, demandCategories) => demandCategories)!
        .toList();
    _categoryIds = List.from(widget.demandsCubit.state.categoryIds ?? []);
    _filterRadiusKm = widget.demandsCubit.state.filterRadiusKm;
    _orderChipList();
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

  void _orderChipList() {
    final selectedList = demandCategories.where(
      (element) => _categoryIds.contains(element.id),
    );
    final unSelectedList = demandCategories.where(
      (element) => !_categoryIds.contains(element.id),
    );

    demandCategories = [...selectedList, ...unSelectedList];
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 4),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Text(
                    'Filtreler',
                    style: TextStyle(fontSize: 20),
                  ),
                  const Spacer(),
                  if (_categoryIds.isNotEmpty || _filterRadiusKm != null) ...[
                    OutlinedButton.icon(
                      icon: const Icon(Icons.delete),
                      label: const Text('Temizle'),
                      onPressed: _onClear,
                    ),
                    const SizedBox(width: 4),
                  ],
                  IconButton(
                    onPressed: _onSave,
                    icon: const Icon(Icons.check_rounded),
                  )
                ],
              ),
              const SizedBox(height: 8),
              Divider(
                color: Colors.grey[300],
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
                          ? 'Her Yer'
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
                          horizontal: 2,
                        ),
                        child: ChoiceChip(
                          padding: const EdgeInsets.all(4),
                          selectedColor: Colors.red,
                          selected: isSelected,
                          label: Text(category.name),
                          onSelected: (value) => setState(() {
                            if (isSelected) {
                              _categoryIds.remove(category.id);
                              _orderChipList();
                            } else {
                              _categoryIds.add(category.id);
                              _orderChipList();
                            }
                          }),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
// const SizedBox(height: 8),
// Divider(
//   color: Colors.grey[300],
// ),
// const SizedBox(height: 8),
// Row(
//   children: [
//     Expanded(
//       child: OutlinedButton(
//         onPressed: _onClear,
//         child: const SizedBox(
//           height: 40,
//           child: Center(
//             child: Text(
//               'Filtreyi temizle',
//             ),
//           ),
//         ),
//       ),
//     ),
//     const SizedBox(
//       width: 16,
//     ),
//     Expanded(
//       child: ElevatedButton(
//         onPressed: _onSave,
//         style: ButtonStyle(
//           shape:
//               MaterialStateProperty.all<RoundedRectangleBorder>(
//             RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//         ),
//         child: const SizedBox(
//           height: 40,
//           child: Center(
//             child: Text(
//               'Filtrele',
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//         ),
//       ),
//     ),
//   ],
// )
            ],
          ),
        ),
      ),
    );
  }
}
