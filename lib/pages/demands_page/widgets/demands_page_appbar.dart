import 'package:afet_destek/pages/auth_page/auth_page.dart';
import 'package:afet_destek/pages/demands_page/state/demands_cubit.dart';
import 'package:afet_destek/pages/my_demand_page/my_demand_page.dart';
import 'package:afet_destek/shared/theme/color_extensions.dart';
import 'package:afet_destek/shared/widgets/responsive_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DemandPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DemandPageAppBar({
    super.key,
    required this.isAuthorized,
    required this.hasAnyFilters,
  });

  final bool isAuthorized;
  final bool hasAnyFilters;
  @override
  Widget build(BuildContext context) {
    return ResponsiveAppBar(
      hasMobileLeading: true,
      mobileTile: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ElevatedButton(
              onPressed: !isAuthorized
                  ? () {
                      AuthPage.show(
                        context,
                        onClose: () {
                          context.read<DemandsCubit>().refreshDemands();
                        },
                      );
                    }
                  : () {
                      MyDemandPage.show(
                        context,
                        onClose: () {
                          context.read<DemandsCubit>().refreshDemands();
                        },
                      );
                    },
              child: Text(
                isAuthorized ? 'Destek Talebim' : 'Talep Oluştur',
              ),
            ),
          ),
          const SizedBox(width: 12),
          Builder(
            builder: (ctx) {
              return IconButton(
                icon: Stack(
                  children: [
                    const Icon(Icons.filter_list),
                    if (hasAnyFilters) ...[
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
                onPressed: () => Scaffold.of(ctx).openEndDrawer(),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      desktopTile: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ElevatedButton(
              onPressed: !isAuthorized
                  ? () {
                      AuthPage.show(
                        context,
                        onClose: () {
                          context.read<DemandsCubit>().refreshDemands();
                        },
                      );
                    }
                  : () {
                      MyDemandPage.show(
                        context,
                        onClose: () {
                          context.read<DemandsCubit>().refreshDemands();
                        },
                      );
                    },
              child: Text(
                isAuthorized ? 'Destek Talebim' : 'Talep Oluştur',
              ),
            ),
          ),
          const SizedBox(width: 12),
          Builder(
            builder: (ctx) {
              return IconButton(
                icon: Stack(
                  children: [
                    const Icon(Icons.filter_list),
                    if (hasAnyFilters) ...[
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
                onPressed: () => Scaffold.of(ctx).openEndDrawer(),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
