import 'package:freezed_annotation/freezed_annotation.dart';

part 'volunteer_request_state.g.dart';
part 'volunteer_request_state.freezed.dart';

@freezed
class VolunteerRequestState with _$VolunteerRequestState {
  const factory VolunteerRequestState({
    required VolunteerRequestStateStatus status,
    required VolunteerRequest? request,
  }) = _VolunteerRequestState;
}

@freezed
class VolunteerRequest with _$VolunteerRequest {
  const factory VolunteerRequest({
    required String? userId,
    required List<String>? categoryIds,
    required String? addressText,
    required DateTime? modifiedTimeUtc,
    required double? distanceMeter,
    required double? lat,
    required double? lng,
  }) = _VolunteerRequest;

  const VolunteerRequest._();

  factory VolunteerRequest.empty() => const VolunteerRequest(
        userId: null,
        categoryIds: null,
        addressText: null,
        modifiedTimeUtc: null,
        distanceMeter: null,
        lat: null,
        lng: null,
      );

  factory VolunteerRequest.fromJson(Map<String, dynamic> json) =>
      _$VolunteerRequestFromJson(json);
}

@freezed
class VolunteerRequestStateStatus with _$VolunteerRequestStateStatus {
  const factory VolunteerRequestStateStatus.loadingCurrentRequest() =
      _loadingCurrentDemand;
  const factory VolunteerRequestStateStatus.loadFailed() = _loadFailed;

  const factory VolunteerRequestStateStatus.loadedCurrentRequest() =
      _loadedCurrentDemand;
  const factory VolunteerRequestStateStatus.saving() = _saving;
  const factory VolunteerRequestStateStatus.saveSuccess() = _saveSuccess;
  const factory VolunteerRequestStateStatus.saveFail() = _saveFail;
}
