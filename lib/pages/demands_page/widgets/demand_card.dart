import 'package:afet_destek/data/models/demand.dart';
import 'package:afet_destek/pages/demand_details_page/demand_details_page.dart';
import 'package:afet_destek/pages/demands_page/widgets/demand_category_chip.dart';
import 'package:afet_destek/shared/extensions/date_count_down_extension.dart';
import 'package:afet_destek/shared/state/app_cubit.dart';
import 'package:afet_destek/shared/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class DemandCard extends StatelessWidget {
  const DemandCard({
    super.key,
    required this.demand,
    this.isDetailed = false,
  });
  final Demand demand;
  final bool isDetailed;

  String get _distanceString {
    final distanceKm = demand.distanceMeter ~/ 1000;
    if (distanceKm < 1) {
      return '>1km uzaklıkta';
    }
    return '${distanceKm}km uzaklıkta';
  }

  @override
  Widget build(BuildContext context) {
    final demandCategories = context.read<AppCubit>().state.whenOrNull(
          loaded: (_, demandCategories) => demandCategories,
        )!;
    return GestureDetector(
      onTap: !isDetailed
          ? () => DemandDetailsPage.show(context, demand: demand)
          : null,
      child: ColoredBox(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              height: 6,
              decoration: const BoxDecoration(
                color: Color(0xffDC2626),
                borderRadius: BorderRadius.vertical(top: Radius.circular(9)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // const Icon(Icons.location_on),
                      // const SizedBox(width: 4),
                      Text(
                        demand.addressText,
                        maxLines: 1,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: AppColors.textColor,
                        ),
                      ),
                      // Will be added later to sharing func after add routing
                      // const Spacer(),
                      // IconButton(
                      //   onPressed: () {
                      //     Share.share(
                      //       'Yardım talep linki : https://afetdestek.org/talep/${demand.id}',
                      //     );
                      //   },
                      //   icon: const Icon(Icons.share),
                      // )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        demand.modifiedTimeUtc.asElapsedTimeString,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Color(0xff475467),
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        '•',
                        style: TextStyle(
                          color: Color(0xFFB0B5BC),
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        _distanceString,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff475467),
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Divider(color: Color(0xffE7EEF5), height: 1),
                  ),
                  const Text(
                    'İhtiyaçlar',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff475467),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    children: demand
                        .categoryNames(
                          demandCategories: demandCategories,
                        )
                        .map(
                          (category) => Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 4,
                            ),
                            child: DemandCategoryChip(label: category),
                          ),
                        )
                        .toList(),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Divider(color: Color(0xffE7EEF5), height: 1),
                  ),
                  const Text(
                    'Detaylar',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color(
                        0xff475467,
                      ),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    demand.notes,
                    maxLines: isDetailed ? 10000 : 5,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Color(0xff475467)),
                  ),
                  const SizedBox(height: 8),
                  if (!isDetailed) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => DemandDetailsPage.show(
                            context,
                            demand: demand,
                          ),
                          child: const Text(
                            'Talep Detayını Gör',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.red,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    )
                  ]
                ],
              ),
            ),
          ],
        ),
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
