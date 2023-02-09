import 'dart:async';

import 'package:afet_destek/data/repository/auth_repository.dart';
import 'package:afet_destek/pages/auth_page/state/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AuthState(status: AuthStateStatus.initial));
  final AuthRepository _authRepository;

  Future<void> sendSms({
    required String number,
  }) async {
    try {
      emit(state.copyWith(status: AuthStateStatus.sendingSms));
      await _authRepository.sendSMS(number: number);
      emit(state.copyWith(status: AuthStateStatus.smsSent));
    } catch (_) {
      emit(state.copyWith(status: AuthStateStatus.smsFailure));
    }
  }

  Future<void> verifySMSCode({
    required String code,
  }) async {
    try {
      emit(state.copyWith(status: AuthStateStatus.verifyingCode));
      await _authRepository.verifySMSCode(code: code);
      emit(state.copyWith(status: AuthStateStatus.authorized));
    } catch (_) {
      emit(state.copyWith(status: AuthStateStatus.codeVerificationFailure));
    }
  }
}
