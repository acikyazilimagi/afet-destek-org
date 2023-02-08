import 'package:deprem_destek/data/models/demand.dart';
import 'package:deprem_destek/pages/demands_page/widgets/demand_category_chip.dart';
import 'package:deprem_destek/shared/extensions/date_count_down_extension.dart';
import 'package:deprem_destek/shared/state/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class DemandCard extends StatelessWidget {
  const DemandCard({
    super.key,
    required this.demand,
  });
  final Demand demand;

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
            decoration: const BoxDecoration(
              color: Color(0xffDC2626),
              borderRadius: BorderRadius.vertical(top: Radius.circular(9)),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xffF0F0F0)),
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(9),
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
                          color: Color(0xff101828),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        demand.modifiedTimeUtc.toLocal().countDown,
                        style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Color(0xff101828),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        '${demand.distanceMeter ~/ 1000} km',
                        style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Color(0xff101828),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    demand.notes,
                    style: const TextStyle(color: Color(0xff475467)),
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
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffDC2626),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: Colors.red),
                    ),
                  ),
                  child: const Text(
                    'Detay',
                    style: TextStyle(fontWeight: FontWeight.w600),
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
