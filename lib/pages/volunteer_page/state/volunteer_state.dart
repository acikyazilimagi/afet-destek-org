import 'package:freezed_annotation/freezed_annotation.dart';

part 'volunteer_state.freezed.dart';
part 'volunteer_state.g.dart';

@freezed
class VolunteerState with _$VolunteerState {
  const factory VolunteerState({
    required VolunteerStateStatus status,
    required VolunteerRequest? request,
  }) = _VolunteerState;
}

@freezed
class VolunteerRequest with _$VolunteerRequest {
  const factory VolunteerRequest({
    required List<String> categoryIds,
    required String addressText,
    required double radiusKm,
  }) = _VolunteerRequest;

  const VolunteerRequest._();

  factory VolunteerRequest.fromJson(Map<String, dynamic> json) =>
      _$VolunteerRequestFromJson(json);
}

@freezed
class VolunteerStateStatus with _$VolunteerStateStatus {
  const factory VolunteerStateStatus.initial() = _loadingCurrentDemand;

  const factory VolunteerStateStatus.saving() = _saving;
  const factory VolunteerStateStatus.saveSuccess() = _saveSuccess;
  const factory VolunteerStateStatus.saveFail() = _saveFail;
}
