import 'package:deprem_destek/data/repository/auth_repository.dart';
import 'package:deprem_destek/pages/auth_page/auth_page.dart';
import 'package:deprem_destek/pages/demands_page/home_page.dart';
import 'package:deprem_destek/shared/state/app_cubit.dart';
import 'package:deprem_destek/shared/state/app_state.dart';
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

        return Scaffold(body: HomePage(),);
        
      },
    );
  }

  Column column(bool authorized, AppState appState, BuildContext context) {
    return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text('authorized: $authorized, appState: $appState'),
            ),
            ElevatedButton(
              onPressed: !authorized
                  ? () => AuthPage.show(context)
                  : () => debugPrint('todo'),
              child: const Text('Taleplerim'),
            )
          ],
        );
  }
}
