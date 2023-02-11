import 'package:afet_destek/data/models/demand.dart';
import 'package:afet_destek/pages/demands_page/state/demands_cubit.dart';
import 'package:afet_destek/pages/demands_page/state/demands_state.dart';
import 'package:afet_destek/pages/demands_page/widgets/demand_card.dart';
import 'package:afet_destek/pages/demands_page/widgets/demand_title.dart';
import 'package:afet_destek/shared/theme/color_extensions.dart';
import 'package:afet_destek/shared/widgets/app_info_banner.dart';
import 'package:afet_destek/shared/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MobileList extends StatelessWidget {
  const MobileList({
    super.key,
    required ScrollController scrollController,
    required this.demands,
    required this.state,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;
  final List<Demand>? demands;
  final DemandsState state;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width.clamp(0, 600),
      child: RefreshIndicator(
        color: context.appColors.mainRed,
        onRefresh: () => context.read<DemandsCubit>().refreshDemands(),
        child: ListView.builder(
          controller: _scrollController,
          itemCount: demands!.length,
          itemBuilder: (context, index) {
            final demand = demands![index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (index == 0) ...[const AppInfoBanner(), const DemandTitle()],
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: DemandCard(demand: demand),
                ),
                if (index == demands!.length - 1) ...[
                  if (state.status.maybeWhen(
                    loading: () => true,
                    orElse: () => false,
                  )) ...[
                    const SizedBox(height: 16),
                    const Loader(),
                  ],
                  const SizedBox(height: 64)
                ]
              ],
            );
          },
        ),
      ),
    );
  }
}
