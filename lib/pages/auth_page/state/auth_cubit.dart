import 'dart:async';

import 'package:deprem_destek/data/repository/auth_repository.dart';
import 'package:deprem_destek/pages/auth_page/state/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AuthState(status: AuthStateStatus.initial));
  final AuthRepository _authRepository;

  final _Ticker _ticker = _Ticker(ticks: 180);
  StreamSubscription<int>? _tickerSubscription;

  Future<void> sendSms({
    required String number,
  }) async {
    try {
      emit(state.copyWith(status: AuthStateStatus.sendingSms));
      await _authRepository.sendSMS(number: number);
      emit(state.copyWith(status: AuthStateStatus.smsSent));
      _tickerSubscription = _ticker.tick(ticks: 180).listen((duration) {
        emit(state.copyWith(status: AuthStateStatus.smsSent, timer: duration));
      });
    } catch (_) {
      _tickerSubscription = _ticker.tick(ticks: 180).listen((duration) {});
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

class _Ticker {
  _Ticker({required this.ticks});

  final int ticks;

  Stream<int> tick({required int ticks}) {
    return Stream.periodic(
      const Duration(seconds: 1),
      (x) => ticks - x - 1,
    ).take(ticks);
  }
}
