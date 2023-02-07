import 'package:deprem_destek/data/repository/auth_repository.dart';
import 'package:deprem_destek/data/repository/demands_repository.dart';
import 'package:deprem_destek/pages/auth_page/auth_page.dart';
import 'package:deprem_destek/pages/my_demand_page/my_demand_page.dart';
import 'package:deprem_destek/shared/state/app_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DemandsPage extends StatelessWidget {
  const DemandsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.read<AppCubit>().state;

    return StreamBuilder<User?>(
      stream: context.read<AuthRepository>().userStream,
      builder: (context, snapshot) {
        // ignore: unused_local_variable
        final authorized = snapshot.data != null;

        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text('authorized: $authorized, appState: $appState'),
              ),
              Expanded(
                child: FutureBuilder(
                  future: context.read<DemandsRepository>().getDemands(
                        page: 1,
                        geo: null,
                        categoryIds: ['n', 'a'],
                        radius: null,
                      ),
                  builder: (context, snapshot) {
                    return SingleChildScrollView(child: Text('$snapshot'));
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (!authorized) {
                    AuthPage.show(context);
                  } else {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute<bool>(
                        builder: (ctx) => const MyDemandPage(),
                      ),
                    );
                  }
                },
                child: const Text('Taleplerim'),
              ),
              const Spacer()
            ],
          ),
        );
      },
    );
  }
}
