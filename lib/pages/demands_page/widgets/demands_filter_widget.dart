import 'package:deprem_destek/pages/demands_page/state/demands_cubit.dart';
import 'package:deprem_destek/pages/demands_page/state/demands_state.dart';
import 'package:deprem_destek/shared/state/app_cubit.dart';
import 'package:deprem_destek/shared/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DemandsFilterWidget extends StatelessWidget {
  const DemandsFilterWidget(
      {super.key, required this.radius, required this.showFilter});

  final double radius;
  final bool showFilter;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 16),
      padding: const EdgeInsets.only(
        top: 48,
        bottom: 16,
        left: 12,
        right: 12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Slider(
            value: radius,
            onChanged: (radius) =>
                context.read<DemandsCubit>().radiusChanged(radius),
            min: 1,
            max: 101,
            label: radius == 101 ? '∞' : '${radius.toInt()} km',
            divisions: 100,
          ),
          BlocBuilder<AppCubit, AppState>(
            builder: (context, state) {
              return state.whenOrNull(
                      loaded: (_, demandList) => Expanded(
                            child: ListView.builder(
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  demandList[index].name,
                                ),
                              ),
                              itemCount: demandList.length,
                            ),
                          )) ??
                  const SizedBox();
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => context
                        .read<DemandsCubit>()
                        .getDemands(reloadPage: true),
                    child: const Text('Filtrele'),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => context
                        .read<DemandsCubit>()
                        .changeFilterVisibility(showFilter: showFilter),
                    child: const Text('Filtreyi Kapat'),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
