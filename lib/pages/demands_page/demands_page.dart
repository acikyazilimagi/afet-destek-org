import 'package:deprem_destek/core/res/theme.dart';
import 'package:deprem_destek/data/repository/auth_repository.dart';
import 'package:deprem_destek/pages/app_load_failure_page/app_load_failure_page.dart';
import 'package:deprem_destek/pages/auth_page/auth_page.dart';
import 'package:deprem_destek/pages/demands_page/state/demands_cubit.dart';
import 'package:deprem_destek/pages/demands_page/state/demands_state.dart';
import 'package:deprem_destek/pages/demands_page/widgets/demand_widget.dart';
import 'package:deprem_destek/pages/demands_page/widgets/demands_filter_widget.dart';
import 'package:deprem_destek/pages/my_demand_page/widgets/loader.dart';
import 'package:deprem_destek/shared/state/app_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DemandsPage extends StatefulWidget {
  const DemandsPage({
    super.key,
  });

  @override
  State<DemandsPage> createState() => _DemandsPageState();
}

class _DemandsPageState extends State<DemandsPage> {
  @override
  void initState() {
    context
        .read<DemandsCubit>()
        .scrollController
        .addListener(context.read<DemandsCubit>().getDemands);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.read<AppCubit>().state;

    return StreamBuilder<User?>(
      stream: context.read<AuthRepository>().userStream,
      builder: (context, snapshot) {
        final authorized = snapshot.data != null;

        return BlocBuilder<DemandsCubit, DemandsState>(
          builder: (context, state) {
            return state.when(
              loaded: (demands, showFilter, radius) => Scaffold(
                appBar: AppBar(
                  //TODO CHANGE TEXT TO LOGO
                  title: const Text("Yardım Ağı"),
                  centerTitle: false,
                  actions: [
                    IconButton(
                      onPressed: () => context
                          .read<DemandsCubit>()
                          .changeFilterVisibility(
                              showFilter: showFilter ?? false),
                      icon: const Icon(Icons.filter_list),
                    )
                  ],
                ),
                body: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: TextButton(
                            style: AppTheme.redButton().copyWith(),
                            onPressed: !authorized
                                ? () => AuthPage.show(context)
                                : () => const DemandsPage(),
                            child: const Text(
                              'Taleplerim',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            controller:
                                context.read<DemandsCubit>().scrollController,
                            padding: const EdgeInsets.all(16),
                            itemBuilder: (context, index) => DemandWidget(
                              demand: demands![index],
                            ),
                            itemCount: demands?.length ?? 0,
                          ),
                        )
                      ],
                    ),
                    Visibility(
                      visible: showFilter ?? false,
                      child: Container(
                        color: Colors.black.withOpacity(.7),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                      ),
                    ),
                    Visibility(
                      visible: showFilter ?? false,
                      child: DemandsFilterWidget(
                        showFilter: showFilter ?? false,
                        radius: radius ?? 1,
                      ),
                    )
                  ],
                ),
              ),
              loading: () => const Scaffold(body: Loader()),
              failed: () => const AppLoadFailurePage(),
            );
          },
        );
      },
    );
  }
}
