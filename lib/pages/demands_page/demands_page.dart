import 'package:deprem_destek/data/repository/auth_repository.dart';
import 'package:deprem_destek/data/repository/demands_repository.dart';
import 'package:deprem_destek/pages/auth_page/auth_page.dart';
import 'package:deprem_destek/pages/my_demand_page/my_demand_page.dart';
import 'package:deprem_destek/shared/state/app_cubit.dart';
import 'package:deprem_destek/shared/widget/scaffold_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_geocoding_api/google_geocoding_api.dart';

class DemandsPage extends StatelessWidget {
  DemandsPage({super.key});
  final scaffoldWidgetKey = GlobalKey<ScaffoldWidgetState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final appState = context.read<AppCubit>().state;

    return StreamBuilder<User?>(
      stream: context.read<AuthRepository>().userStream,
      builder: (context, snapshot) {
        // ignore: unused_local_variable
        final authorized = snapshot.data != null;
        return ScaffoldWidget(
          title: 'Yardim agi',
          endDrawer: Drawer(
            child: ListView.builder(
              // TODO(BurakAkten): ekranini drawer keyleri eklenmeli
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: () => _scaffoldKey.currentState?.closeEndDrawer(),
                  leading: const Icon(Icons.list),
                  title: Text('item $index'),
                  trailing: const Icon(Icons.done),
                );
              },
            ),
          ),
          key: scaffoldWidgetKey,
          scaffoldKey: _scaffoldKey,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text('authorized: $authorized, appState: $appState'),
                ),
                appState.maybeWhen(
                  orElse: () => const SizedBox.shrink(),
                  loaded: (currentLocation, demandCategories) {
                    return FutureBuilder(
                      future: context.read<DemandsRepository>().getDemands(
                            page: 1,
                            geo: const GoogleGeocodingLocation(
                              lat: 36.7741001,
                              lng: 28.8179202,
                            ),
                            categoryIds: [],
                            radius: 1,
                          ),
                      builder: (context, snapshot) {
                        return Text('${snapshot.data}');
                      },
                    );
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    // TODO(BurakAkten): Örnek Kullanim
                    scaffoldWidgetKey.currentState?.showSnackBarMessage(
                      'Yardım Ağı',
                    );
                    if (!authorized) {
                      AuthPage.show(context);
                    } else {
                      MyDemandPage.show(context);
                    }
                  },
                  child: const Text('Taleplerim'),
                ),
                const Spacer()
              ],
            ),
          ),
        );
      },
    );
  }
}
