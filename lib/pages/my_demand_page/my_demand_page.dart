import 'package:deprem_destek/data/repository/demands_repository.dart';
import 'package:deprem_destek/pages/my_demand_page/state/my_demands_cubit.dart';
import 'package:deprem_destek/pages/my_demand_page/state/my_demands_state.dart';
import 'package:deprem_destek/pages/my_demand_page/widgets/demand_category_selector.dart';
import 'package:deprem_destek/pages/my_demand_page/widgets/geo_value_accessor.dart';
import 'package:deprem_destek/pages/my_demand_page/widgets/loader.dart';
import 'package:deprem_destek/shared/extensions/reactive_forms_extensions.dart';
import 'package:deprem_destek/shared/state/app_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_geocoding_api/google_geocoding_api.dart';
import 'package:reactive_forms/reactive_forms.dart';

class MyDemandPage extends StatefulWidget {
  const MyDemandPage({super.key});

  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(
        builder: (context) {
          return const MyDemandPage();
        },
      ),
    );
  }

  @override
  State<MyDemandPage> createState() => _MyDemandPageState();
}

class _MyDemandPageState extends State<MyDemandPage> {
  final FormGroup _myDemandPageFormGroup = FormGroup({
    _MyDemandPageFormFields.geoLocation.name:
        FormControl<GoogleGeocodingResult>(),
    _MyDemandPageFormFields.categories.name:
        FormControl<List<String>>(validators: [Validators.required], value: []),
    _MyDemandPageFormFields.notes.name:
        FormControl<String>(validators: [Validators.required]),
    _MyDemandPageFormFields.phoneNumber.name: FormControl<String>(
      validators: [Validators.required, Validators.minLength(10)],
    ),
    _MyDemandPageFormFields.wpPhoneNumber.name: FormControl<String>(),
  });

  @override
  void initState() {
    super.initState();
    final location = context.read<AppCubit>().state.whenOrNull(
          loaded: (currentLocation, demandCategories) => currentLocation,
        );

    _myDemandPageFormGroup
        .control(_MyDemandPageFormFields.geoLocation.name)
        .value = location;

    _myDemandPageFormGroup
        .control(_MyDemandPageFormFields.phoneNumber.name)
        .value = FirebaseAuth.instance.currentUser!.phoneNumber;

    _myDemandPageFormGroup
        .control(_MyDemandPageFormFields.wpPhoneNumber.name)
        .value = FirebaseAuth.instance.currentUser!.phoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.read<AppCubit>().state.mapOrNull(
          loaded: (loadedAppState) => loadedAppState,
        );

    if (appState == null) {
      return const Scaffold(body: Loader());
    }

    return BlocProvider<MyDemandsCubit>(
      create: (context) => MyDemandsCubit(
        demandsRepository: context.read<DemandsRepository>(),
      ),
      child: BlocConsumer<MyDemandsCubit, MyDemandState>(
        listener: (context, state) {
          if (state.status.whenOrNull(loadedCurrentDemand: () => true) ??
              false) {
            final existingDemand = state.demand;

            if (existingDemand != null) {
              _myDemandPageFormGroup
                  .control(_MyDemandPageFormFields.categories.name)
                  .value = existingDemand.categoryIds;
              _myDemandPageFormGroup
                  .control(_MyDemandPageFormFields.notes.name)
                  .value = existingDemand.notes;
            }
          }

          if (state.status.whenOrNull(loadFailed: () => true) ?? false) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Sayfa yüklenemedi'),
              ),
            );
          } else if (state.status.whenOrNull(
                saveFail: () => true,
              ) ??
              false) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('kaydetme başarısız'),
              ),
            );
          }

          if (state.status.whenOrNull(
                saveSuccess: () => true,
              ) ??
              false) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('kaydetme başarılı'),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.status.whenOrNull(
                loadingCurrentDemand: () => true,
              ) ??
              false) {
            return const Scaffold(body: Loader());
          }

          final deactivateButtons = state.status.whenOrNull(
                saving: () => true,
              ) ??
              false;

          return Scaffold(
            appBar: AppBar(
              title: const Text('Talep Ekle/Düzenle'),
            ),
            body: SingleChildScrollView(
              child: ReactiveForm(
                onWillPop: () async => false,
                formGroup: _myDemandPageFormGroup,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReactiveTextField<GoogleGeocodingResult>(
                        formControlName:
                            _MyDemandPageFormFields.geoLocation.name,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(
                            Icons.location_on,
                          ),
                        ),
                        valueAccessor: GeoValueAccessor(),
                      ),
                      DemandCategorySelector(
                        formControl: _myDemandPageFormGroup.control(
                          _MyDemandPageFormFields.categories.name,
                        ) as FormControl<List<String>>,
                      ),
                      ReactiveTextField<String>(
                        decoration: const InputDecoration(
                          hintText: 'Neye İhtiyacın Var?',
                        ),
                        formControlName: _MyDemandPageFormFields.notes.name,
                      ),
                      ReactiveTextField<String>(
                        decoration: const InputDecoration(
                          prefixIcon: Text('+90'),
                          // isDense: true,
                          prefixIconConstraints: BoxConstraints(),
                        ),
                        formControlName:
                            _MyDemandPageFormFields.phoneNumber.name,
                        inputFormatters: [LengthLimitingTextInputFormatter(10)],
                      ),
                      ReactiveFormConsumer(
                        builder: (context, form, _) {
                          return Row(
                            children: [
                              SizedBox(
                                height: 24,
                                width: 24,
                                child: CheckboxListTile(
                                  onChanged: (value) => value != true
                                      ? form
                                          .control(
                                            _MyDemandPageFormFields
                                                .wpPhoneNumber.name,
                                          )
                                          .markAsDisabled()
                                      : form
                                          .control(
                                            _MyDemandPageFormFields
                                                .wpPhoneNumber.name,
                                          )
                                          .markAsEnabled(),
                                  value: form
                                      .control(
                                        _MyDemandPageFormFields
                                            .wpPhoneNumber.name,
                                      )
                                      .enabled,
                                ),
                              ),
                              const Icon(FontAwesomeIcons.whatsapp),
                              const Text('Whatsapp ile ulaşılsın'),
                            ],
                          );
                        },
                      ),
                      ReactiveTextField<String>(
                        formControlName:
                            _MyDemandPageFormFields.wpPhoneNumber.name,
                        decoration: const InputDecoration(
                          prefixIcon: Text('+90'),
                          prefixIconConstraints: BoxConstraints(),
                        ),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                        ),
                        child: ReactiveFormConsumer(
                          builder: (context, formGroup, child) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                  onPressed: formGroup.valid &&
                                          !deactivateButtons
                                      ? () {
                                          final categories =
                                              _myDemandPageFormGroup
                                                  .readByControlName<
                                                      List<String>>(
                                            _MyDemandPageFormFields
                                                .categories.name,
                                          );
                                          final geo = _myDemandPageFormGroup
                                              .readByControlName<
                                                  GoogleGeocodingResult>(
                                            _MyDemandPageFormFields
                                                .geoLocation.name,
                                          );

                                          final notes = _myDemandPageFormGroup
                                              .readByControlName<String>(
                                            _MyDemandPageFormFields.notes.name,
                                          );

                                          final phoneNumber =
                                              _myDemandPageFormGroup
                                                  .readByControlName<String>(
                                            _MyDemandPageFormFields
                                                .phoneNumber.name,
                                          );

                                          final whatsappNumber =
                                              _myDemandPageFormGroup
                                                      .control(
                                                        _MyDemandPageFormFields
                                                            .wpPhoneNumber.name,
                                                      )
                                                      .enabled
                                                  ? _myDemandPageFormGroup
                                                      .readByControlName<
                                                          String>(
                                                      _MyDemandPageFormFields
                                                          .wpPhoneNumber.name,
                                                    )
                                                  : null;

                                          if (state.demand == null) {
                                            context
                                                .read<MyDemandsCubit>()
                                                .addDemand(
                                                  categoryIds: categories,
                                                  geo: geo,
                                                  notes: notes,
                                                  phoneNumber: phoneNumber,
                                                  whatsappNumber:
                                                      whatsappNumber,
                                                );
                                          } else {
                                            context
                                                .read<MyDemandsCubit>()
                                                .updateDemand(
                                                  demandId: state.demand!.id,
                                                  categoryIds: categories,
                                                  geo: geo,
                                                  notes: notes,
                                                  phoneNumber: phoneNumber,
                                                  whatsappNumber:
                                                      whatsappNumber,
                                                );
                                          }
                                        }
                                      : null,
                                  child: const Text(
                                    'Kaydet',
                                  ),
                                ),
                                if (state.demand != null) ...[
                                  ElevatedButton(
                                    onPressed:
                                        !deactivateButtons ? () {} : null,
                                    child: Text(
                                      state.demand!.isActive
                                          ? 'Talebi durdur'
                                          : 'Talebi sürdür',
                                    ),
                                  ),
                                ],
                              ],
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
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
