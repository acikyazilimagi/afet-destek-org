// TODO use freezed
// TODO: freezed kullanmadan denendi

part of 'demands_cubit.dart';

@freezed
class DemandsState with _$DemandsState {
  const factory DemandsState.initial() = _Initial;
  const factory DemandsState.loading(bool isLoading) = _Loading;
  const factory DemandsState.completed(List<Demand> demands) = _Completed;
  const factory DemandsState.error(String message) = _Error;
}
