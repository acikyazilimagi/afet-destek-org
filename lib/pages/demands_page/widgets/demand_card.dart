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
    required this.isDetail,
  });
  final Demand demand;
  final bool isDetail;

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
            height: 6,
            decoration: const BoxDecoration(
              color: Color(0xffDC2626),
              borderRadius: BorderRadius.vertical(top: Radius.circular(9)),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding:
                const EdgeInsets.only(top: 14, bottom: 20, right: 16, left: 16),
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(color: AppColors.cardBorderColor),
              borderRadius: BorderRadius.circular(
                9,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  demand.addressText,
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: AppColors.textColor,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      demand.modifiedTimeUtc.toLocal().asElapsedTimeString,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color(0xff475467),
                      ),
                    ),
                    const CircleAvatar(
                      backgroundColor: AppColors.cardBorderColor,
                      radius: 3,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${demand.distanceMeter ~/ 1000} km',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff475467),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
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
                const SizedBox(
                  height: 8,
                ),
                Wrap(
                  children: [
                    for (var category in demand.categoryNames(
                      demandCategories: demandCategories,
                    ))
                      DemandCategoryChip(label: category),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    (demand.notes * 100).substring(
                      0,
                      demand.notes.length <= 1000 ? demand.notes.length : 1000,
                    ),
                    overflow: TextOverflow.fade,
                    style: const TextStyle(color: Color(0xff475467)),
                  ),
                ),
                if (!isDetail) ...[
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          DemandDetailsPage.show(context, demand: demand);
                        },
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
