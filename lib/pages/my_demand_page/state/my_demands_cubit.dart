import 'dart:async';

import 'package:afet_destek/data/repository/demands_repository.dart';
import 'package:afet_destek/pages/my_demand_page/state/my_demands_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_geocoding_api/google_geocoding_api.dart';

class MyDemandsCubit extends Cubit<MyDemandState> {
  MyDemandsCubit({
    required DemandsRepository demandsRepository,
  })  : _demandsRepository = demandsRepository,
        super(
          const MyDemandState(
            demand: null,
            status: MyDemandStateStatus.loadingCurrentDemand(),
          ),
        ) {
    getCurrentDemand();
  }
  final DemandsRepository _demandsRepository;

  Future<void> getCurrentDemand() async {
    try {
      emit(
        state.copyWith(
          status: const MyDemandStateStatus.loadingCurrentDemand(),
        ),
      );

      final demand = await _demandsRepository.getCurrentDemand();

      emit(
        state.copyWith(
          demand: demand,
          status: const MyDemandStateStatus.loadedCurrentDemand(),
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: const MyDemandStateStatus.loadFailed()));
    }
  }

  Future<void> addDemand({
    required GoogleGeocodingResult geo,
    required List<String> categoryIds,
    required String notes,
    required String phoneNumber,
    required String? whatsappNumber,
  }) async {
    try {
      emit(state.copyWith(status: const MyDemandStateStatus.saving()));

      await _demandsRepository.addDemand(
        categoryIds: categoryIds,
        geo: geo,
        notes: notes,
        phoneNumber: phoneNumber,
        whatsappNumber: whatsappNumber,
      );

      emit(state.copyWith(status: const MyDemandStateStatus.saveSuccess()));
    } catch (_) {
      emit(state.copyWith(status: const MyDemandStateStatus.saveFail()));
    }

    unawaited(getCurrentDemand());
  }

  Future<void> updateDemand({
    required String demandId,
    GoogleGeocodingResult? geo,
    required List<String> categoryIds,
    required String notes,
    required String phoneNumber,
    required String? whatsappNumber,
  }) async {
    try {
      emit(state.copyWith(status: const MyDemandStateStatus.saving()));

      await _demandsRepository.updateDemand(
        demandId: demandId,
        categoryIds: categoryIds,
        geo: geo,
        notes: notes,
        phoneNumber: phoneNumber,
        whatsappNumber: whatsappNumber,
      );

      emit(state.copyWith(status: const MyDemandStateStatus.saveSuccess()));
    } catch (_) {
      emit(state.copyWith(status: const MyDemandStateStatus.saveFail()));
    }
  }

  Future<void> activateDemand({
    required String demandId,
    // required GoogleGeocodingResult geo,
    // required List<String> categoryIds,
    // required String notes,
    // required String phoneNumber,
    // required String whatsappNumber,
  }) async {
    try {
      emit(state.copyWith(status: const MyDemandStateStatus.saving()));

      await _demandsRepository.activateDemand(demandId: demandId);

      emit(state.copyWith(status: const MyDemandStateStatus.saveSuccess()));
      unawaited(getCurrentDemand());
    } catch (_) {
      emit(state.copyWith(status: const MyDemandStateStatus.saveFail()));
    }
  }

  Future<void> deactivateDemand({
    required String demandId,
    // required GoogleGeocodingResult geo,
    // required List<String> categoryIds,
    // required String notes,
    // required String phoneNumber,
    // required String whatsappNumber,
  }) async {
    try {
      emit(state.copyWith(status: const MyDemandStateStatus.saving()));

      await _demandsRepository.deactivateDemand(demandId: demandId);

      emit(state.copyWith(status: const MyDemandStateStatus.saveSuccess()));
      unawaited(getCurrentDemand());
    } catch (_) {
      emit(state.copyWith(status: const MyDemandStateStatus.saveFail()));
    }
  }
}
