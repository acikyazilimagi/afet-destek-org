part of 'demands_cubit.dart';

@immutable
class DemandsState {
  const DemandsState({this.demands});

  final List<Demand>? demands;

  DemandsState copyWith({
    List<Demand>? demands,
  }) {
    return DemandsState(
      demands: demands ?? this.demands,
    );
  }
}
