import 'package:deprem_destek/data/repository/demands_repository.dart';
import 'package:deprem_destek/pages/my_demand_page/state/my_demands_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyDemandsCubit extends Cubit<MyDemandState> {
  MyDemandsCubit({
    required DemandsRepository demandsRepository,
  })  : _demandsRepository = demandsRepository,
        super(const MyDemandState.loading()) {
    getCurrentDemand();
  }

  final DemandsRepository _demandsRepository;
  Future<void> getCurrentDemand() async {
    try {
      emit(const MyDemandState.loading());

      final demand = await _demandsRepository
          .getCurrentDemand()
          .timeout(const Duration(seconds: 10));

      emit(
        MyDemandState.loaded(
          demand: demand,
          loading: false,
        ),
      );
    } catch (_) {
      emit(const MyDemandState.failed());
    }
  }
}
