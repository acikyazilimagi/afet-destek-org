import 'package:afet_destek/gen/translations/locale_keys.g.dart';
import 'package:afet_destek/pages/demands_page/state/demands_cubit.dart';
import 'package:afet_destek/shared/extensions/translation_extension.dart';
import 'package:afet_destek/shared/state/app_cubit.dart';
import 'package:afet_destek/shared/theme/color_extensions.dart';
import 'package:afet_destek/shared/widgets/responsive_app_bar.dart';
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
    final size = MediaQuery.of(context).size;
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
      appBar: ResponsiveAppBar(title: LocaleKeys.filter.getStr()),
      body: Center(
        child: SizedBox(
          width: 700,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (size.width >= 1000)
                  Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.arrow_back),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.1),
                    ],
                  ),
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
                      TextSpan(
                        text: LocaleKeys.distance.getStr(),
                        style: const TextStyle(color: Color(0xff475467)),
                      ),
                      TextSpan(
                        text: _filterRadiusKm == null
                            ? LocaleKeys.everywhere.getStr()
                            : LocaleKeys.distance_km.getStrArgs(
                                args: ['${_filterRadiusKm!.toInt()}'],
                              ),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: context.appColors.mainRed,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Divider(
                  color: context.appColors.stroke,
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    LocaleKeys.demands_type
                        .getStrArgs(args: ['${_categoryIds.length}']),
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: SingleChildScrollView(
                      child: Wrap(
                        children: demandCategories.map(
                          (category) {
                            final isSelected = _categoryIds.contains(
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
                                onSelected: (value) => setState(() {
                                  if (isSelected) {
                                    _categoryIds.remove(category.id);
                                  } else {
                                    if (_categoryIds.length == 10) {
                                      AppSnackbars.failure(
                                        LocaleKeys
                                            .you_can_only_select_10_categories
                                            .getStr(),
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
                  ),
                ),
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
        ),
      ),
    );
  }

  ElevatedButton getElevatedButton({required bool isFilterButton}) {
    return ElevatedButton(
      onPressed: isFilterButton ? _onSave : _onClear,
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll<Color>(
          isFilterButton ? context.appColors.mainRed : context.appColors.white,
        ),
        shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      child: Text(
        isFilterButton ? LocaleKeys.filter.getStr() : LocaleKeys.clear.getStr(),
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 16,
              color: isFilterButton
                  ? context.appColors.white
                  : context.appColors.notificationTermTexts,
            ),
      ),
    );
  }
}
