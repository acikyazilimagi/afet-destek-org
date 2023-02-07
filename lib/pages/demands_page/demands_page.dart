import 'package:deprem_destek/core/res/theme.dart';
import 'package:deprem_destek/core/res/utils.dart';
import 'package:deprem_destek/data/models/demand.dart';
import 'package:deprem_destek/data/repository/auth_repository.dart';
import 'package:deprem_destek/data/repository/demands_repository.dart';
import 'package:deprem_destek/data/repository/location_repository.dart';
import 'package:deprem_destek/pages/auth_page/auth_page.dart';
import 'package:deprem_destek/pages/demands_page/state/demands_cubit.dart';
import 'package:deprem_destek/pages/my_demand_page/my_demand_page.dart';
import 'package:deprem_destek/shared/state/app_cubit.dart';
import 'package:deprem_destek/pages/demands_page/widgets/demand_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';

class DemandsPage extends StatelessWidget {
  const DemandsPage({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final appState = context.read<AppCubit>().state;

    return StreamBuilder<User?>(
      stream: context.read<AuthRepository>().userStream,
      builder: (context, snapshot) {
        final authorized = snapshot.data != null;

        return Scaffold(
          appBar: AppBar(
            //TODO CHANGE TEXT TO LOGO
            title: const Text("Yardım Ağı"),
            centerTitle: false,
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.filter_list),
              )
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(AppDimens.s),
                child: TextButton(
                  style: AppTheme.redButton().copyWith(),
                  onPressed: () => Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) =>
                          authorized ? const MyDemandPage() : const AuthPage(),
                    ),
                  ),
                  child: const Text(
                    'Taleplerim',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                  child: BlocProvider<DemandsCubit>.value(
                value: DemandsCubit(
                  context.read<LocationRepository>(),
                  context.read<DemandsRepository>(),
                )..getDemands(),
                child: BlocBuilder<DemandsCubit, DemandsState>(
                  builder: (context, state) {
                    return Scaffold(
                      body: ListView.separated(
                        padding: const EdgeInsets.all(16),
                        itemBuilder: (context, index) => DemandWidget(
                          demand: state.demands![index],
                        ),
                        itemCount: state.demands?.length ?? 0,
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 24,
                        ),
                      ),
                    );
                  },
                ),
              ))
            ],
          ),
        );
      },
    );
  }
}
