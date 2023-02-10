import 'package:afet_destek/data/models/demand.dart';
import 'package:afet_destek/data/repository/auth_repository.dart';
import 'package:afet_destek/data/repository/demands_repository.dart';
import 'package:afet_destek/pages/my_demand_page/state/my_demands_cubit.dart';
import 'package:afet_destek/pages/my_demand_page/state/my_demands_state.dart';
import 'package:afet_destek/pages/my_demand_page/widgets/demand_category_selector.dart';
import 'package:afet_destek/pages/my_demand_page/widgets/geo_value_accessor.dart';
import 'package:afet_destek/shared/extensions/district_address_extension.dart';
import 'package:afet_destek/shared/extensions/reactive_forms_extensions.dart';
import 'package:afet_destek/shared/state/app_cubit.dart';
import 'package:afet_destek/shared/theme/color_extensions.dart';
import 'package:afet_destek/shared/widgets/loader.dart';
import 'package:afet_destek/shared/widgets/reactive_intl_phone_field.dart';
import 'package:afet_destek/shared/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_geocoding_api/google_geocoding_api.dart';
import 'package:reactive_forms/reactive_forms.dart';

class MyDemandPage extends StatefulWidget {
  const MyDemandPage._();

  static Future<void> show(
    BuildContext context, {
    required VoidCallback onClose,
  }) async {
    await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(
        builder: (context) {
          return BlocProvider<MyDemandsCubit>(
            create: (context) => MyDemandsCubit(
              demandsRepository: context.read<DemandsRepository>(),
            ),
            child: const MyDemandPage._(),
          );
        },
      ),
    );

    onClose();
  }

  @override
  State<MyDemandPage> createState() => _MyDemandPageState();
}

class _MyDemandPageState extends State<MyDemandPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final FormGroup _myDemandPageFormGroup = FormGroup({
    _MyDemandPageFormFields.geoLocation.name:
        FormControl<GoogleGeocodingResult>(
      disabled: true,
    ),
    _MyDemandPageFormFields.categories.name: FormControl<List<String>>(
      validators: [
        Validators.minLength(1),
      ],
      value: [],
    ),
    _MyDemandPageFormFields.notes.name: FormControl<String>(
      validators: [Validators.required],
    ),
    _MyDemandPageFormFields.notes.name:
        FormControl<String>(validators: [Validators.required]),
    _MyDemandPageFormFields.phoneNumber.name: FormControl<String>(
      validators: [
        Validators.required,
      ],
    ),
    _MyDemandPageFormFields.wpPhoneNumber.name: FormControl<String>(
      disabled: true,
    ),
  });

  // ignore: use_setters_to_change_properties
  void _updateAddressToCurrent({required GoogleGeocodingResult currentGeo}) {
    _myDemandPageFormGroup
        .control(_MyDemandPageFormFields.geoLocation.name)
        .value = currentGeo;
  }

  void _onToggleActivation({required Demand demand}) {
    if (demand.isActive) {
      context.read<MyDemandsCubit>().deactivateDemand(
            demandId: demand.id,
          );
    } else {
      context.read<MyDemandsCubit>().activateDemand(
            demandId: demand.id,
          );
    }
  }

  void _onSave({required String? demandId}) {
    final categories = _myDemandPageFormGroup.readByControlName<List<String>>(
      _MyDemandPageFormFields.categories.name,
    );
    final geo = _myDemandPageFormGroup.readByControlName<GoogleGeocodingResult>(
      _MyDemandPageFormFields.geoLocation.name,
    );

    final notes = _myDemandPageFormGroup.readByControlName<String>(
      _MyDemandPageFormFields.notes.name,
    );

    final phoneNumber = _myDemandPageFormGroup.readByControlName<String>(
      _MyDemandPageFormFields.phoneNumber.name,
    );

    final whatsappNumber = _isWpActive
        ? _myDemandPageFormGroup.readByControlName<String>(
            _MyDemandPageFormFields.wpPhoneNumber.name,
          )
        : null;

    if (demandId == null) {
      context.read<MyDemandsCubit>().addDemand(
            categoryIds: categories,
            geo: geo,
            notes: notes,
            phoneNumber: phoneNumber,
            whatsappNumber: whatsappNumber,
          );
    } else {
      context.read<MyDemandsCubit>().updateDemand(
            demandId: demandId,
            categoryIds: categories,
            geo: geo.placeId == '-1' ? null : geo,
            notes: notes,
            phoneNumber: phoneNumber,
            whatsappNumber: whatsappNumber,
          );
    }
  }

  bool get _isWpActive => _myDemandPageFormGroup
      .control(
        _MyDemandPageFormFields.wpPhoneNumber.name,
      )
      .enabled;

  void _populateWithExistingData({required Demand? existingDemand}) {
    if (existingDemand != null) {
      // Update demand case
      _myDemandPageFormGroup
          .control(_MyDemandPageFormFields.categories.name)
          .value = existingDemand.categoryIds;
      _myDemandPageFormGroup.control(_MyDemandPageFormFields.notes.name).value =
          existingDemand.notes;

      _myDemandPageFormGroup
          .control(_MyDemandPageFormFields.phoneNumber.name)
          .value = existingDemand.phoneNumber;

      _myDemandPageFormGroup
          .control(_MyDemandPageFormFields.wpPhoneNumber.name)
          .value = existingDemand.whatsappNumber;

      _myDemandPageFormGroup
          .control(_MyDemandPageFormFields.geoLocation.name)
          .value = _fakeGeoWithAddress(addressText: existingDemand.addressText);

      if (existingDemand.whatsappNumber != null) {
        _myDemandPageFormGroup
            .control(_MyDemandPageFormFields.wpPhoneNumber.name)
            .markAsEnabled();
      }
    } else {
      // Create demand case
      _myDemandPageFormGroup
          .control(_MyDemandPageFormFields.phoneNumber.name)
          .value = FirebaseAuth.instance.currentUser?.phoneNumber;

      _myDemandPageFormGroup
          .control(_MyDemandPageFormFields.wpPhoneNumber.name)
          .value = FirebaseAuth.instance.currentUser?.phoneNumber;

      final currentLocation = context.read<AppCubit>().state.whenOrNull(
            loaded: (currentLocation, demandCategories) => currentLocation,
          );

      _myDemandPageFormGroup
          .control(_MyDemandPageFormFields.geoLocation.name)
          .value = currentLocation;
    }
  }

  void _listener(BuildContext context, MyDemandState state) {
    state.status.whenOrNull(
      loadedCurrentDemand: () {
        _populateWithExistingData(existingDemand: state.demand);
      },
      loadFailed: () {
        const AppSnackbars.failure('Sayfa yüklemesi başarısız.').show(context);
      },
      saveFail: () {
        const AppSnackbars.failure('Kaydetme başarısız.').show(context);
      },
      saveSuccess: () {
        const AppSnackbars.success('Değişiklikler kaydedildi.').show(context);
      },
    );
  }

  void _onWpActivateToggle(bool? value) {
    if (value != true) {
      _myDemandPageFormGroup
          .control(
            _MyDemandPageFormFields.wpPhoneNumber.name,
          )
          .markAsDisabled();
      _myDemandPageFormGroup
          .control(_MyDemandPageFormFields.wpPhoneNumber.name)
          .value = null;
    } else {
      _myDemandPageFormGroup
          .control(
            _MyDemandPageFormFields.wpPhoneNumber.name,
          )
          .markAsEnabled();

      _myDemandPageFormGroup
              .control(_MyDemandPageFormFields.wpPhoneNumber.name)
              .value =
          _myDemandPageFormGroup
              .control(_MyDemandPageFormFields.phoneNumber.name)
              .value;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentLocation = context.read<AppCubit>().state.whenOrNull(
          loaded: (currentLocation, demandCategories) => currentLocation,
        );
    final appState = context.read<AppCubit>().state.mapOrNull(
          loaded: (loadedAppState) => loadedAppState,
        );

    if (appState == null || currentLocation == null) {
      return const Scaffold(body: Loader());
    }

    return BlocConsumer<MyDemandsCubit, MyDemandState>(
      listener: _listener,
      builder: (context, state) {
        final deactivateButtons = state.status.maybeWhen(
          saving: () => true,
          orElse: () => false,
        );

        return state.status.maybeWhen(
          loadingCurrentDemand: () => const Scaffold(body: Loader()),
          orElse: () => Scaffold(
            appBar: AppBar(
              title: Text(
                state.demand == null
                    ? 'Destek Talebi Oluştur'
                    : 'Destek Talebini Düzenle',
              ),
            ),
            body: Center(
              child: SizedBox(
                width: 700,
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: ReactiveForm(
                      formGroup: _myDemandPageFormGroup,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const AppFormFieldTitle(title: 'Adres'),
                            ReactiveTextField<GoogleGeocodingResult>(
                              formControlName:
                                  _MyDemandPageFormFields.geoLocation.name,
                              readOnly: true,
                              valueAccessor: GeoValueAccessor(),
                            ),
                            const SizedBox(height: 8),
                            if (state.demand != null) ...[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text('Mevcut Adres'),
                                        const SizedBox(height: 4),
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
                                    child: const Text(
                                      'Güncelle',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    onPressed: () => _updateAddressToCurrent(
                                      currentGeo: currentLocation,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                            const SizedBox(height: 16),
                            DemandCategorySelector(
                              formControl: _myDemandPageFormGroup.control(
                                _MyDemandPageFormFields.categories.name,
                              ) as FormControl<List<String>>,
                            ),
                            const SizedBox(height: 16),
                            const AppFormFieldTitle(title: 'Diğer İhtiyaçlar'),
                            ReactiveTextField<String>(
                              formControlName:
                                  _MyDemandPageFormFields.notes.name,
                              minLines: 3,
                              maxLines: 10,
                              maxLength: 1000,
                              validationMessages: {
                                ValidationMessage.required: (_) =>
                                    'Neye ihtiyacınız olduğunu yazar mısınız?.',
                                ValidationMessage.maxLength: (_) =>
                                    'En fazla 1000 karakter girebilirsiniz.',
                              },
                            ),
                            const AppFormFieldTitle(title: 'Telefon Numarası'),
                            ReactiveIntlPhoneField(
                              invalidNumberMessage: 'Geçersiz telefon numarası',
                              formControl: _myDemandPageFormGroup.control(
                                _MyDemandPageFormFields.phoneNumber.name,
                              ) as FormControl<String>,
                            ),
                            ReactiveFormConsumer(
                              builder: (context, form, _) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CheckboxListTile(
                                      contentPadding: EdgeInsets.zero,
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      value: _isWpActive,
                                      onChanged: _onWpActivateToggle,
                                      title: Row(
                                        children: [
                                          const Text('WhatsApp ile ulaşılsın'),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Icon(
                                            FontAwesomeIcons.whatsapp,
                                            color: context.appColors.whatsApp,
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (_isWpActive) ...[
                                      const AppFormFieldTitle(
                                        title: 'WhatsApp Numarası',
                                      ),
                                      ReactiveIntlPhoneField(
                                        invalidNumberMessage:
                                            'Geçersiz telefon numarası',
                                        formControl:
                                            _myDemandPageFormGroup.control(
                                          _MyDemandPageFormFields
                                              .wpPhoneNumber.name,
                                        ) as FormControl<String>,
                                      ),
                                    ]
                                  ],
                                );
                              },
                            ),
                            const SizedBox(height: 16),
                            ReactiveFormConsumer(
                              builder: (context, formGroup, child) {
                                return Row(
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            context.appColors.mainRed,
                                      ),
                                      onPressed: formGroup.valid &&
                                              !deactivateButtons
                                          ? () {
                                              final currentPhoneFormValidate =
                                                  _formKey.currentState!
                                                      .validate();

                                              if (currentPhoneFormValidate) {
                                                _onSave(
                                                  demandId: state.demand?.id,
                                                );
                                              }
                                            }
                                          : null,
                                      child: Text(
                                        state.demand == null
                                            ? 'Talep Oluştur'
                                            : 'Talebi Güncelle',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.copyWith(
                                              color: context.appColors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ),
                                    const Spacer(),
                                    if (state.demand != null) ...[
                                      const SizedBox(width: 16),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              context.appColors.mainRed,
                                        ),
                                        onPressed: !deactivateButtons
                                            ? () => _onToggleActivation(
                                                  demand: state.demand!,
                                                )
                                            : null,
                                        child: Text(
                                          state.demand!.isActive
                                              ? 'Talebi durdur'
                                              : 'Talebi sürdür',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(
                                                color: context.appColors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ],
                                );
                              },
                            ),
                            const SizedBox(height: 32),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: OutlinedButton(
                                onPressed: () {
                                  context.read<AuthRepository>().logout();
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Çıkış yap',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        color: context.appColors.mainRed,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
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

enum _MyDemandPageFormFields {
  geoLocation,
  categories,
  notes,
  phoneNumber,
  wpPhoneNumber,
}

// To not break the existing code, we need to supply
// GoogleGeocodingResult object to the reactive form field.
// Form field only uses the address name so other
// fields can be ignored here. Also, this is just
// for populating the UI, this data won't make it
// to the BE. (place id is used as an indicator between
// fake and real geo object)
GoogleGeocodingResult _fakeGeoWithAddress({required String addressText}) =>
    GoogleGeocodingResult.fromJson({
      'place_id': '-1',
      'address_components': [
        {
          'long_name': addressText,
          'types': ['administrative_area_level_4']
        }
      ]
    });
