import 'dart:async';

import 'package:afet_destek/data/repository/demands_repository.dart';
import 'package:afet_destek/pages/volunteer_page/state/volunteer_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_geocoding_api/google_geocoding_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

// const String _volunteerRequestLocalKey = 'volunteerRequest';

class VolunteerCubit extends Cubit<VolunteerState> {
  VolunteerCubit({required DemandsRepository demandsRepository})
      : _demandsRepository = demandsRepository,
        super(
          const VolunteerState(
            request: null,
            status: VolunteerStateStatus.initial(),
          ),
        );
  final DemandsRepository _demandsRepository;
  SharedPreferences? _prefs;
  FutureOr<SharedPreferences> get prefs async =>
      _prefs ??= await SharedPreferences.getInstance();

  // Future<void> getCurrentRequest() async {
  //   try {
  //     emit(
  //       state.copyWith(
  //         status: const VolunteerStateStatus.loadingCurrentRequest(),
  //       ),
  //     );

  //     final requestStr = (await prefs).getString(_volunteerRequestLocalKey);

  //     final requestJson = jsonDecode(requestStr!);

  //     final request = VolunteerRequest.fromJson(
  //       requestJson as Map<String, dynamic>,
  //     );
  //     emit(
  //       state.copyWith(
  //         request: request,
  //         status: const VolunteerStateStatus.loadedCurrentRequest(),
  //       ),
  //     );
  //   } catch (_) {
  //     emit(
  //       state.copyWith(
  //         status: const VolunteerStateStatus.loadFailed(),
  //       ),
  //     );
  //   }
  // }

  Future<void> addRequest({
    required GoogleGeocodingResult geo,
    required List<String> categoryIds,
    required double radiusKm,
  }) async {
    try {
      emit(state.copyWith(status: const VolunteerStateStatus.saving()));
      await _demandsRepository.subscribeToDemands(
        geo: geo,
        categoryIds: categoryIds,
        radiusKm: radiusKm,
      );

      emit(
        state.copyWith(
          status: const VolunteerStateStatus.saveSuccess(),
        ),
      );

      // final pref = await prefs;

      // await pref.setString(
      //   _volunteerRequestLocalKey,
      //   jsonEncode(
      //     VolunteerRequest(
      //       addressText: geo.districtAddress,
      //       categoryIds: categoryIds,
      //       radiusKm: radiusKm,
      //     ).toJson(),
      //   ),
      // );
    } catch (_) {
      emit(
        state.copyWith(
          status: const VolunteerStateStatus.saveFail(),
        ),
      );
    }
  }
}
