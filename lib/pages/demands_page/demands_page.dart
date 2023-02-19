import 'package:afet_destek/data/repository/auth_repository.dart';
import 'package:afet_destek/data/repository/demands_repository.dart';
import 'package:afet_destek/gen/translations/locale_keys.g.dart';
import 'package:afet_destek/pages/app_load_failure_page/app_load_failure_page.dart';
import 'package:afet_destek/pages/demands_page/state/demands_cubit.dart';
import 'package:afet_destek/pages/demands_page/widgets/demand_filter_popup.dart';
import 'package:afet_destek/pages/demands_page/widgets/demand_title.dart';
import 'package:afet_destek/pages/demands_page/widgets/demands_page_appbar.dart';
import 'package:afet_destek/pages/demands_page/widgets/generic_grid_list.dart';
import 'package:afet_destek/pages/demands_page/widgets/list_view_responsive.dart';
import 'package:afet_destek/pages/demands_page/widgets/mobile_list_view.dart';
import 'package:afet_destek/shared/extensions/translation_extension.dart';
import 'package:afet_destek/shared/state/app_cubit.dart';
import 'package:afet_destek/shared/theme/color_extensions.dart';
import 'package:afet_destek/shared/widgets/loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DemandsPage extends StatelessWidget {
  const DemandsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLocation = context.read<AppCubit>().state.whenOrNull(
          loaded: (currentLocation, demandCategories) => currentLocation,
        );

    if (currentLocation == null) {
      return const Scaffold(body: Loader());
    }

    return BlocProvider<DemandsCubit>(
      create: (context) => DemandsCubit(
        demandsRepository: context.read<DemandsRepository>(),
        currentLocation: currentLocation.geometry!.location,
      ),
      child: StreamBuilder<User?>(
        stream: context.read<AuthRepository>().userStream,
        builder: (context, snapshot) {
          final authorized = snapshot.data != null;
          return _DemandsPageView(isAuthorized: authorized);
        },
      ),
    );
  }
}

class _DemandsPageView extends StatefulWidget {
  const _DemandsPageView({required this.isAuthorized});
  final bool isAuthorized;

  @override
  State<_DemandsPageView> createState() => _DemandsPageViewState();
}

class _DemandsPageViewState extends State<_DemandsPageView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final shouldLoadNext = _scrollController.offset >
          _scrollController.position.maxScrollExtent * 0.9;
      if (shouldLoadNext) {
        context.read<DemandsCubit>().loadNextPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final state = context.watch<DemandsCubit>().state;
    final demands = state.demands;

    if (demands == null) {
      if (state.status.maybeWhen(
        orElse: () => false,
        failure: () => true,
      )) {
        return const AppLoadFailurePage();
      }
      return const Scaffold(body: Loader());
    }

    return Scaffold(
      appBar: DemandPageAppBar(
        isAuthorized: widget.isAuthorized,
        hasAnyFilters: state.hasAnyFilters,
      ),
      body: Column(
        mainAxisAlignment: size.width >= 1000
            ? MainAxisAlignment.start
            : MainAxisAlignment.center,
        children: [
          if (size.width >= 1000 && demands.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DemandTitle(
                        title: LocaleKeys.help_demands_not_found.getStr(),
                      ),
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
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    color: context.appColors.black,
                                  ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height / 2 - 100,
                  ),
                ],
              ),
            ),
          if (demands.isEmpty)
            Center(
              child: Column(
                children: [
                  Text(
                    state.hasAnyFilters
                        ? LocaleKeys.can_not_find_result_try_clearing_filters
                            .getStr()
                        : LocaleKeys.no_demand_yet.getStr(),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<DemandsCubit>().setFilters(
                            categoryIds: null,
                            filterRadiusKm: null,
                          );
                    },
                    child: Text(LocaleKeys.clear_filters.getStr()),
                  )
                ],
              ),
            )
          else
            Expanded(
              child: Center(
                child: ListViewResponsive(
                  desktop: GenericListView(
                    scrollController: _scrollController,
                    demands: demands,
                    state: state,
                    maxWidth: 1450,
                    crossAxisCount: 3,
                  ),
                  mobile: MobileList(
                    scrollController: _scrollController,
                    demands: demands,
                    state: state,
                  ),
                  tablet: GenericListView(
                    scrollController: _scrollController,
                    demands: demands,
                    state: state,
                    maxWidth: 1000,
                    crossAxisCount: 2,
                  ),
                  largeDesktop: GenericListView(
                    scrollController: _scrollController,
                    demands: demands,
                    state: state,
                    maxWidth: 2200,
                    crossAxisCount: 4,
                  ),
                ),
              ),
            ),
        ],
      ),
      endDrawer: DemandFilterDrawer(
        demandsCubit: context.read<DemandsCubit>(),
      ),
    );
  }
}
