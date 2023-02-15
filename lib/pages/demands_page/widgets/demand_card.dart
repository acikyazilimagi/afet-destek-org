import 'package:afet_destek/data/models/demand.dart';
import 'package:afet_destek/gen/translations/locale_keys.g.dart';
import 'package:afet_destek/pages/demand_details_page/widgets/contacts_group_widget.dart';
import 'package:afet_destek/pages/demands_page/widgets/demand_category_chip.dart';
import 'package:afet_destek/shared/extensions/date_count_down_extension.dart';
import 'package:afet_destek/shared/extensions/translation_extension.dart';
import 'package:afet_destek/shared/state/app_cubit.dart';
import 'package:afet_destek/shared/theme/color_extensions.dart';
import 'package:afet_destek/shared/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
      return LocaleKeys.one_km_less_away.getStr();
    }
    return LocaleKeys.distance_km_away
        .getStrArgs(args: [distanceKm.toString()]);
  }

  @override
  Widget build(BuildContext context) {
    final demandCategories = context.watch<AppCubit>().state.whenOrNull(
          loaded: (_, demandCategories) => demandCategories,
        );
    if (demandCategories == null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('Detaylar yükleniyor.'),
          SizedBox(height: 8),
          Loader(),
        ],
      );
    }
    return GestureDetector(
      onTap: !isDetailed ? () => context.go('/demand/${demand.id}') : null,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.appColors.white,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Column(
          children: [
            Container(
              height: 6,
              decoration: const BoxDecoration(
                color: Color(0xffDC2626),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(9),
                ),
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
                      Expanded(
                        child: Text(
                          demand.addressText,
                          maxLines: 4,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: context.appColors.titles,
                          ),
                        ),
                      ),
                      // Will be added later to sharing func after add routing
                      // const Spacer(),
                      // IconButton(
                      //   onPressed: () {
                      //     Share.share(
                      //       LocaleKeys.share_demand.getStrArgs(args:['https://afetdestek.org/talep/'+demand.id.toString()]),
                      //     );
                      //   },
                      //   icon: const Icon(Icons.share),
                      // )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    children: [
                      Text(
                        demand.modifiedTimeUtc.asElapsedTimeString,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Color(0xff475467),
                        ),
                      ),
                      if (!isDetailed) ...[
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
                      ]
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Divider(color: Color(0xffE7EEF5), height: 1),
                  ),
                  Text(
                    LocaleKeys.needs.getStr(),
                    textAlign: TextAlign.left,
                    style: const TextStyle(
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
                  Text(
                    LocaleKeys.details.getStr(),
                    style: const TextStyle(
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
                          onPressed: () => context.go('/demand/${demand.id}'),
                          child: Text(
                            LocaleKeys.show_demand_details.getStr(),
                            style: TextStyle(
                              fontSize: 16,
                              color: context.appColors.mainRed,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    )
                  ] else ...[
                    ContactsGroupWidget(demand: demand),
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
