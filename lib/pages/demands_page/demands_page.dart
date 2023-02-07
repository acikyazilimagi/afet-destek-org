import 'package:deprem_destek/data/repository/auth_repository.dart';
import 'package:deprem_destek/data/repository/demands_repository.dart';
import 'package:deprem_destek/pages/auth_page/auth_page.dart';
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
              FutureBuilder(
                future: context.read<DemandsRepository>().getDemands(
                      page: 1,
                      geo: null,
                      categoryIds: ['n', 'a'],
                      radius: null,
                    ),
                builder: (context, snapshot) {
                  return Text('$snapshot');
                },
              ),
              ElevatedButton(
                onPressed: !authorized ? () => AuthPage.show(context) : null,
                child: const Text('Taleplerim'),
              )
            ],
          ),
        );
      },
    );
  }
}
