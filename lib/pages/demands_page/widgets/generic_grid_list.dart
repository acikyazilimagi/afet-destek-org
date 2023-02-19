import 'package:afet_destek/data/models/demand.dart';
import 'package:afet_destek/gen/translations/locale_keys.g.dart';
import 'package:afet_destek/pages/demands_page/state/demands_state.dart';
import 'package:afet_destek/pages/demands_page/widgets/demand_card.dart';
import 'package:afet_destek/pages/demands_page/widgets/demand_title.dart';
import 'package:afet_destek/shared/extensions/translation_extension.dart';
import 'package:afet_destek/shared/theme/color_extensions.dart';
import 'package:afet_destek/shared/widgets/app_info_banner.dart';
import 'package:afet_destek/shared/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GenericListView extends StatelessWidget {
  const GenericListView({
    super.key,
    required ScrollController scrollController,
    required this.demands,
    required this.state,
    required this.maxWidth,
    required this.crossAxisCount,
  }) : _scrollController = scrollController;
  final ScrollController _scrollController;
  final List<Demand> demands;
  final DemandsState state;
  final int maxWidth;
  final int crossAxisCount;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width.clamp(0, maxWidth).toDouble(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppInfoBanner(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DemandTitle(title: LocaleKeys.help_demands.getStr()),
                Builder(
                  builder: (ctx) {
                    return TextButton.icon(
                      onPressed: () => Scaffold.of(ctx).openEndDrawer(),
                      icon: Stack(
                        children: [
                          Icon(
                            Icons.filter_list,
                            color: context.appColors.black,
                          ),
                          if (state.hasAnyFilters) ...[
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: context.appColors.mainRed,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      label: Text(
                        LocaleKeys.filter.getStr(),
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: context.appColors.black,
                                ),
                      ),
                    );
                  },
                ),
              ],
            ),
            Expanded(
              child: MasonryGridView.builder(
                //    crossAxisCount: crossAxisCount,
                mainAxisSpacing: 24,
                crossAxisSpacing: 24,
                controller: _scrollController,
                itemCount: demands.length,
                itemBuilder: (context, index) {
                  final demand = demands[index];
                  return Column(
                    children: [
                      DemandCard(demand: demand),
                      if (index == demands.length - 1) ...[
                        if (state.status.maybeWhen(
                          loading: () => true,
                          orElse: () => false,
                        )) ...[
                          const SizedBox(height: 16),
                          const Loader(),
                        ],
                      ]
                    ],
                  );
                },
                gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/*
class gridview extends StatelessWidget {
  const gridview({
    super.key,
    required ScrollController scrollController,
    required this.demands,
    required this.state,
    required this.crossAxisCount,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;
  final List<Demand> demands;
  final DemandsState state;
  final int crossAxisCount;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: _scrollController,
      itemCount: demands.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final demand = demands[index];
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: DemandCard(demand: demand),
            ),
            if (index == demands.length - 1) ...[
              if (state.status.maybeWhen(
                loading: () => true,
                orElse: () => false,
              )) ...[
                const SizedBox(height: 16),
                const Loader(),
              ],
            ]
          ],
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 1.3,
      ),
    );
  }
}*/
