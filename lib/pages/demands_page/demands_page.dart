import 'package:deprem_destek/data/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DemandsPage extends StatelessWidget {
  const DemandsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: context.read<AuthRepository>().userStream,
      builder: (context, snapshot) {
        // ignore: unused_local_variable
        final authorized = snapshot.data != null;

        return Container();
      },
    );
  }
}
