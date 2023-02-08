import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    required AuthStateStatus status,
  }) = _AuthState;
}

enum AuthStateStatus {
  initial,
  sendingSms,
  smsFailure,
  smsSent,
  codeVerificationFailure,
  verifyingCode,
  authorized,
}
