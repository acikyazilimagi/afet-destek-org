import 'package:deprem_destek/data/models/demand.dart';
import 'package:deprem_destek/pages/demand_details_page/demand_details_page.dart';
import 'package:deprem_destek/pages/demands_page/widgets/demand_category_chip.dart';
import 'package:deprem_destek/shared/extensions/date_count_down_extension.dart';
import 'package:deprem_destek/shared/state/app_cubit.dart';
import 'package:deprem_destek/shared/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class DemandCard extends StatelessWidget {
  const DemandCard({
    super.key,
    required this.demand,
    this.showDetailButton = true,
  });
  final Demand demand;
  final bool showDetailButton;

  @override
  Widget build(BuildContext context) {
    final demandCategories = context.read<AppCubit>().state.whenOrNull(
          loaded: (_, demandCategories) => demandCategories,
        )!;
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Container(
            height: 10,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(9)),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.cardBorderColor),
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(8),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        demand.addressText,
                        maxLines: 1,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        demand.modifiedTimeUtc.toLocal().asElapsedTimeString,
                        style: const TextStyle(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        '${demand.distanceMeter ~/ 1000} km',
                        style: const TextStyle(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    demand.notes,
                  ),
                ),
                Wrap(
                  children: [
                    for (var category in demand.categoryNames(
                      demandCategories: demandCategories,
                    ))
                      DemandCategoryChip(label: category),
                  ],
                ),
                if (showDetailButton)
                  ElevatedButton(
                    onPressed: () {
                      DemandDetailsPage.show(context, demand: demand);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Detay',
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String dateFormatter(DateTime date) {
    final delta = DateTime.now().difference(date);
    if (delta.inMinutes < 1) {
      return '${delta.inSeconds} Saniye Önce';
    } else if (delta.inHours < 1) {
      return '${delta.inMinutes} Dakika Önce';
    } else if (delta.inDays < 1) {
      return '${delta.inHours} Saat Önce';
    } else {
      return '${delta.inDays} Gün Önce';
    }
  }
}
