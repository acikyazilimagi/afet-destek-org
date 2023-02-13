import 'dart:async';
import 'dart:convert';

import 'package:afet_destek/pages/volutneer_request/state/volunteer_request_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VolunteerRequestCubit extends Cubit<VolunteerRequestState> {
  VolunteerRequestCubit()
      : super(
          const VolunteerRequestState(
            request: null,
            status: VolunteerRequestStateStatus.loadingCurrentRequest(),
          ),
        ) {
    getCurrentRequest();
  }

  SharedPreferences? _prefs;
  FutureOr<SharedPreferences> get prefs async =>
      _prefs ??= await SharedPreferences.getInstance();

  static const String _volunteerRequestLocalKey = 'volunteerRequest';

  Future<void> getCurrentRequest() async {
    try {
      emit(
        state.copyWith(
          status: const VolunteerRequestStateStatus.loadingCurrentRequest(),
        ),
      );

      final requestStr = (await prefs).getString(_volunteerRequestLocalKey);
      final requestJson = requestStr == null ? null : jsonDecode(requestStr);
      if (requestStr == null ||
          requestStr.isEmpty ||
          requestJson is! Map<String, dynamic>) {
        final request = VolunteerRequest.empty();

        emit(
          state.copyWith(
            request: request,
            status: const VolunteerRequestStateStatus.loadedCurrentRequest(),
          ),
        );

        unawaited(
          _addRequestLocally(),
        );

        return;
      }

      final request = VolunteerRequest.fromJson(requestJson);

      emit(
        state.copyWith(
          request: request,
          status: const VolunteerRequestStateStatus.loadedCurrentRequest(),
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: const VolunteerRequestStateStatus.loadFailed(),
        ),
      );
    }
  }

  void setRequest({
    required VolunteerRequest request,
  }) {
    emit(
      state.copyWith(
        request: request,
      ),
    );
  }

  Future<void> addRequest({
    required String? userId,
  }) =>
      _addRequest(
        onlyLocal: false,
        userId: userId,
      );

  Future<void> _addRequestLocally() => _addRequest(
        onlyLocal: true,
      );

  Future<void> _addRequest({
    required bool onlyLocal,
    String? userId,
  }) async {
    try {
      emit(state.copyWith(status: const VolunteerRequestStateStatus.saving()));

      final pref = await prefs;

      final req = state.request;
      final reqJson = req == null ? null : jsonEncode(req);

      await pref.setString(
        _volunteerRequestLocalKey,
        reqJson.toString(),
      );

      if (!onlyLocal) {
        if (req == null) {
          assert(false, 'state.request cannot be null');
          return;
        }

        emit(
          state.copyWith(
            request: req.copyWith(
              userId: userId,
            ),
          ),
        );
        // TODO(adnanjpg): Add request to server
      }

      emit(
        state.copyWith(
          status: const VolunteerRequestStateStatus.saveSuccess(),
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: const VolunteerRequestStateStatus.saveFail(),
        ),
      );
    }
  }
}
