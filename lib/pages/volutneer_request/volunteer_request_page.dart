import 'package:afet_destek/data/repository/auth_repository.dart';
import 'package:afet_destek/gen/translations/locale_keys.g.dart';
import 'package:afet_destek/pages/volutneer_request/state/volunteer_request_cubit.dart';
import 'package:afet_destek/pages/volutneer_request/state/volunteer_request_state.dart';
import 'package:afet_destek/pages/volutneer_request/widgets/volunteer_request_category_selector.dart';
import 'package:afet_destek/shared/extensions/district_address_extension.dart';
import 'package:afet_destek/shared/extensions/reactive_forms_extensions.dart';
import 'package:afet_destek/shared/extensions/translation_extension.dart';
import 'package:afet_destek/shared/state/app_cubit.dart';
import 'package:afet_destek/shared/theme/color_extensions.dart';
import 'package:afet_destek/shared/widgets/app_form_field_title.dart';
import 'package:afet_destek/shared/widgets/loader.dart';
import 'package:afet_destek/shared/widgets/responsive_app_bar.dart';
import 'package:afet_destek/shared/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_geocoding_api/google_geocoding_api.dart';
import 'package:reactive_forms/reactive_forms.dart';

class VolunteerRequestPage extends StatefulWidget {
  const VolunteerRequestPage._({
    required this.userId,
  });

  final String? userId;

  static Future<void> show(
    BuildContext context, {
    required VoidCallback onClose,
  }) async {
    await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(
        builder: (context) {
          return StreamBuilder(
            stream: context.read<AuthRepository>().userStream,
            builder: (context, snapshot) {
              return BlocProvider<VolunteerRequestCubit>(
                create: (context) => VolunteerRequestCubit(),
                child: VolunteerRequestPage._(
                  userId: snapshot.data?.uid,
                ),
              );
            },
          );
        },
      ),
    );

    onClose();
  }

  @override
  State<VolunteerRequestPage> createState() => _VolunteerRequestPageState();
}

class _VolunteerRequestPageState extends State<VolunteerRequestPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final FormGroup _volunteerRequestPageFormGroup = FormGroup(
    {
      _VolunteerRequestPageFormFields.geoPositionLat.name: FormControl<double>(
        disabled: true,
      ),
      _VolunteerRequestPageFormFields.geoPositionLng.name: FormControl<double>(
        disabled: true,
      ),
      _VolunteerRequestPageFormFields.geoLocation.name:
          FormControl<GoogleGeocodingResult>(
        disabled: true,
      ),
      _VolunteerRequestPageFormFields.categories.name:
          FormControl<List<String>>(
        validators: [
          Validators.minLength(1),
        ],
        value: [],
      ),
      _VolunteerRequestPageFormFields.distanceMeter.name: FormControl<double>(
        value: 0,
      ),
    },
  );

  // ignore: use_setters_to_change_properties
  void _updateAddressToCurrent({
    required Position currentPos,
    required GoogleGeocodingResult currentGeo,
  }) {
    _volunteerRequestPageFormGroup
        .control(
          _VolunteerRequestPageFormFields.geoPositionLat.name,
        )
        .value = currentPos.latitude;

    _volunteerRequestPageFormGroup
        .control(
          _VolunteerRequestPageFormFields.geoPositionLng.name,
        )
        .value = currentPos.longitude;

    _volunteerRequestPageFormGroup
        .control(_VolunteerRequestPageFormFields.geoLocation.name)
        .value = currentGeo;
  }

  void _onSave() {
    final categories =
        _volunteerRequestPageFormGroup.readByControlName<List<String>>(
      _VolunteerRequestPageFormFields.categories.name,
    );
    final positionLat =
        _volunteerRequestPageFormGroup.readByControlName<double>(
      _VolunteerRequestPageFormFields.geoPositionLat.name,
    );
    final positionLng =
        _volunteerRequestPageFormGroup.readByControlName<double>(
      _VolunteerRequestPageFormFields.geoPositionLng.name,
    );
    final distMeter = _volunteerRequestPageFormGroup.readByControlName<double>(
      _VolunteerRequestPageFormFields.distanceMeter.name,
    );
    final addressText = _volunteerRequestPageFormGroup
        .readByControlName<GoogleGeocodingResult>(
          _VolunteerRequestPageFormFields.geoLocation.name,
        )
        .formattedAddress;

    context.read<VolunteerRequestCubit>().setRequest(
          request: VolunteerRequest(
            categoryIds: categories,
            lat: positionLat,
            lng: positionLng,
            distanceMeter: distMeter,
            addressText: addressText,
            modifiedTimeUtc: DateTime.now().toUtc(),
            userId: widget.userId,
          ),
        );

    context.read<VolunteerRequestCubit>().addRequest(
          userId: widget.userId,
        );
  }

  void _populateWithExistingData({required VolunteerRequest? existingRequest}) {
    if (existingRequest != null) {
      // Update demand case
      _volunteerRequestPageFormGroup
          .control(
            _VolunteerRequestPageFormFields.categories.name,
          )
          .value = existingRequest.categoryIds ?? <String>[];

      final address = existingRequest.addressText;
      _volunteerRequestPageFormGroup
              .control(_VolunteerRequestPageFormFields.geoLocation.name)
              .value =
          address == null ? null : _fakeGeoWithAddress(addressText: address);

      _volunteerRequestPageFormGroup
          .control(_VolunteerRequestPageFormFields.geoPositionLat.name)
          .value = existingRequest.lat ?? 0.0;

      _volunteerRequestPageFormGroup
          .control(_VolunteerRequestPageFormFields.geoPositionLng.name)
          .value = existingRequest.lng ?? 0.0;

      final distance = existingRequest.distanceMeter;
      _volunteerRequestPageFormGroup
          .control(
            _VolunteerRequestPageFormFields.distanceMeter.name,
          )
          .value = distance ?? 0.0;
    } else {
      final currentLocation = context.read<AppCubit>().state.whenOrNull(
            loaded: (currentLocation, _, __) => currentLocation,
          );

      _volunteerRequestPageFormGroup
          .control(
            _VolunteerRequestPageFormFields.geoLocation.name,
          )
          .value = currentLocation;

      _volunteerRequestPageFormGroup
          .control(
            _VolunteerRequestPageFormFields.geoPositionLat.name,
          )
          .value = 0.0;

      _volunteerRequestPageFormGroup
          .control(
            _VolunteerRequestPageFormFields.geoPositionLng.name,
          )
          .value = 0.0;
    }
  }

  void _listener(BuildContext context, VolunteerRequestState state) {
    state.status.whenOrNull(
      loadedCurrentRequest: () {
        _populateWithExistingData(existingRequest: state.request);
      },
      loadFailed: () {
        AppSnackbars.failure(LocaleKeys.error_ocured_when_page_loading.getStr())
            .show(context);
      },
      saveFail: () {
        AppSnackbars.failure(LocaleKeys.save_failed.getStr()).show(context);
      },
      saveSuccess: () {
        AppSnackbars.success(LocaleKeys.save_successed.getStr()).show(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.read<AppCubit>().state;

    final currentLocation = appState.whenOrNull(
      loaded: (currentLocation, _, __) => currentLocation,
    );

    final currentPosition = appState.whenOrNull(
      loaded: (_, position, __) => position,
    );

    final loadedState = context.read<AppCubit>().state.mapOrNull(
          loaded: (loadedAppState) => loadedAppState,
        );

    if (loadedState == null ||
        currentLocation == null ||
        currentPosition == null) {
      return const Scaffold(body: Loader());
    }

    return BlocConsumer<VolunteerRequestCubit, VolunteerRequestState>(
      listener: _listener,
      builder: (context, state) {
        final deactivateButtons = state.status.maybeWhen(
          saving: () => true,
          orElse: () => false,
        );

        return state.status.maybeWhen(
          loadingCurrentRequest: () => const Scaffold(body: Loader()),
          orElse: () => Scaffold(
            appBar: ResponsiveAppBar(
              title: LocaleKeys.become_volunteer_page_title.getStr(),
            ),
            body: Center(
              child: Form(
                key: _formKey,
                child: ReactiveForm(
                  formGroup: _volunteerRequestPageFormGroup,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (MediaQuery.of(context).size.width >= 1000)
                          Column(
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () => Navigator.pop(context),
                                    icon: const Icon(Icons.arrow_back),
                                  ),
                                  Text(
                                    LocaleKeys.become_volunteer_submit_btn
                                        .getStr(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 24,
                                        ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        const SizedBox(height: 8),
                        ReactiveSlider(
                          formControlName: _VolunteerRequestPageFormFields
                              .distanceMeter.name,
                          inactiveColor: Colors.grey[200],
                          max: 500,
                          // min: 0,
                        ),
                        const SizedBox(height: 8),
                        ReactiveFormConsumer(
                          builder: (context, formGroup, child) {
                            final distanceMeter = formGroup
                                .control(
                                  _VolunteerRequestPageFormFields
                                      .distanceMeter.name,
                                )
                                .value as double;
                            return Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: LocaleKeys.distance.getStr(),
                                    style: const TextStyle(
                                      color: Color(0xff475467),
                                    ),
                                  ),
                                  TextSpan(
                                    text: distanceMeter == 0.0
                                        ? LocaleKeys.everywhere.getStr()
                                        : LocaleKeys.distance_km.getStrArgs(
                                            args: ['${distanceMeter.toInt()}'],
                                          ),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: context.appColors.mainRed,
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppFormFieldTitle(
                                    title: LocaleKeys.current_address.getStr(),
                                  ),
                                  Text(
                                    currentLocation.districtAddress,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            TextButton(
                              child: Text(
                                LocaleKeys.update.getStr(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              onPressed: () => _updateAddressToCurrent(
                                currentPos: currentPosition,
                                currentGeo: currentLocation,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ReactiveFormConsumer(
                          builder: (context, formGroup, child) {
                            return VolunteerCategorySelector(
                              formControl: formGroup.control(
                                _VolunteerRequestPageFormFields.categories.name,
                              ) as FormControl<List<String>>,
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        ReactiveFormConsumer(
                          builder: (context, formGroup, child) {
                            return SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: context.appColors.mainRed,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: formGroup.valid && !deactivateButtons
                                    ? () {
                                        final currentPhoneFormValidate =
                                            _formKey.currentState!.validate();

                                        if (currentPhoneFormValidate) {
                                          _onSave();
                                        }
                                      }
                                    : null,
                                child: Text(
                                  LocaleKeys.become_volunteer_submit_btn
                                      .getStr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

enum _VolunteerRequestPageFormFields {
  geoPositionLat,
  geoPositionLng,
  geoLocation,
  categories,
  distanceMeter,
}

// To not break the existing code, we need to supply
// GoogleGeocodingResult object to the reactive form field.
// Form field only uses the address name so other
// fields can be ignored here. Also, this is just
// for populating the UI, this data won't make it
// to the BE. (place id is used as an indicator between
// fake and real geo object)
GoogleGeocodingResult _fakeGeoWithAddress({required String addressText}) =>
    GoogleGeocodingResult.fromJson(
      {
        'place_id': '-1',
        'address_components': [
          {
            'long_name': addressText,
            'types': ['administrative_area_level_4']
          }
        ]
      },
    );
