import 'package:deprem_destek/data/models/demand.dart';
import 'package:deprem_destek/data/models/demand_category.dart';
import 'package:deprem_destek/data/repository/demands_repository.dart';
import 'package:deprem_destek/pages/my_demand_page/state/my_demands_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyDemandsCubit extends Cubit<MyDemandState> {
  MyDemandsCubit({
    required DemandsRepository demandsRepository,
  })  : _demandsRepository = demandsRepository,
        super(const MyDemandState.loaded(demand: null, loading: false)) {
    getCurrentDemand();
  }
  final DemandsRepository _demandsRepository;
  late final List<String> categoryIds;
  Future<void> getCurrentDemand() async {
    try {
      emit(state.copyWith(loading: true));

      print(state.loading);
      final demand = await _demandsRepository.getCurrentDemand();

      if (demand != null) {
        categoryIds = demand.categoryIds;
      }
      emit(state.copyWith(loading: false, demand: demand));
      print(state.loading);
    } catch (_) {
      // emit(const MyDemandState.failed());
    }
  }

  Future<void> submitDemand({
    required Demand demand,
    required List<String> categories,
  }) async {
    try {
      emit(state.copyWith(loading: !state.loading));

      await _demandsRepository.addDemand(
        categories: categories,
        geo: demand.geo.geoPoint,
        isActive: demand.isActive,
        notes: demand.notes,
        phoneNumber: demand.phoneNumber,
      );

      emit(state.copyWith(loading: !state.loading));
    } catch (_) {
      // emit(const MyDemandState.failed());
    }
  }
}
