import 'package:afet_destek/data/repository/auth_repository.dart';
import 'package:afet_destek/data/repository/demands_repository.dart';
import 'package:afet_destek/gen/assets.gen.dart';
import 'package:afet_destek/pages/auth_page/auth_page.dart';
import 'package:afet_destek/pages/demands_page/state/demands_cubit.dart';
import 'package:afet_destek/pages/demands_page/widgets/demand_filter_popup.dart';
import 'package:afet_destek/pages/demands_page/widgets/generic_grid_list.dart';
import 'package:afet_destek/pages/demands_page/widgets/list_view_responsive.dart';
import 'package:afet_destek/pages/demands_page/widgets/mobile_list_view.dart';
import 'package:afet_destek/pages/demands_page/widgets/new_demand_information_popup.dart';
import 'package:afet_destek/pages/my_demand_page/my_demand_page.dart';
import 'package:afet_destek/shared/state/app_cubit.dart';
import 'package:afet_destek/shared/theme/colors.dart';
import 'package:afet_destek/shared/widgets/loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    final state = context.watch<DemandsCubit>().state;
    final demands = state.demands;

    if (demands == null) {
      return const Scaffold(body: Loader());
    }
    // TODO(enes): failure page for failure state

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8),
              ),
              onPressed: !widget.isAuthorized
                  ? () {
                      AuthPage.show(
                        context,
                        onClose: () {
                          context.read<DemandsCubit>().refreshDemands();
                        },
                      );
                    }
                  : () {
                      const NewDemandInformationPopup().show(
                        context: context,
                        onClose: () {
                          Navigator.of(context).pop();
                        },
                        onContinue: () {
                          Navigator.of(context).pop();
                          MyDemandPage.show(
                            context,
                            onClose: () {
                              context.read<DemandsCubit>().refreshDemands();
                            },
                          );
                        },
                      );
                    },
              child: Text(
                widget.isAuthorized ? 'Destek Talebim' : 'Talep Oluştur',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          if (MediaQuery.of(context).size.width < 1000)
            Builder(
              builder: (ctx) {
                return IconButton(
                  icon: Stack(
                    children: [
                      const Icon(Icons.filter_list),
                      if (state.hasAnyFilters) ...[
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.red,
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
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: SvgPicture.asset(Assets.logoSvg),
        ),
      ),
      body: demands.isEmpty
          ? Center(
              child: Text(
                state.hasAnyFilters
                    ? 'Sonuç bulunamadı, filtreleri temizlemeyi  deneyin'
                    : '''
Şu anda yardım talebi bulunmamaktadır. 
Eğer yardım talebiniz varsa, destek talebim menüsünden talep oluşturabilirsiniz.
                    ''',
                textAlign: TextAlign.center,
              ),
            )
          : Center(
              child: RefreshIndicator(
                color: AppColors.red,
                onRefresh: () => context.read<DemandsCubit>().refreshDemands(),
                child: ListViewResponsive(
                  desktop: GenericListView(
                    scrollController: _scrollController,
                    demands: demands,
                    state: state,
                    minWidth: 1400,
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
                    minWidth: 600,
                    maxWidth: 1000,
                    crossAxisCount: 2,
                  ),
                  largeDesktop: GenericListView(
                    scrollController: _scrollController,
                    demands: demands,
                    state: state,
                    minWidth: 2000,
                    maxWidth: 2200,
                    crossAxisCount: 4,
                  ),
                ),
              ),
            ),
      endDrawer: DemandFilterDrawer(
        demandsCubit: context.read<DemandsCubit>(),
      ),
    );
  }
}
