import 'package:afet_destek/data/models/demand.dart';
import 'package:afet_destek/pages/demands_page/state/demands_state.dart';
import 'package:afet_destek/pages/demands_page/widgets/demand_card.dart';
import 'package:afet_destek/pages/demands_page/widgets/demand_title.dart';
import 'package:afet_destek/shared/theme/colors.dart';
import 'package:afet_destek/shared/widgets/loader.dart';
import 'package:flutter/material.dart';

class GenericListView extends StatelessWidget {
  const GenericListView({
    super.key,
    required ScrollController scrollController,
    required this.demands,
    required this.state,
    required this.maxWidth,
    required this.minWidth,
    required this.crossAxisCount,
  }) : _scrollController = scrollController;
  final ScrollController _scrollController;
  final List<Demand> demands;
  final DemandsState state;
  final int minWidth;
  final int maxWidth;
  final int crossAxisCount;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width.clamp(minWidth, maxWidth).toDouble(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const DemandTitle(),
              TextButton.icon(
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.formFieldTitle,
                  textStyle: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(color: AppColors.formFieldTitle),
                ),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
                icon: const Icon(Icons.menu),
                label: const Text('Filtrele'),
              )
            ],
          ),
          Expanded(
            child: GridView.builder(
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
            ),
          ),
        ],
      ),
    );
  }
}
