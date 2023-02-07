import 'package:deprem_destek/data/repository/demands_repository.dart';
import 'package:deprem_destek/pages/auth_page/state/auth_cubit.dart';
import 'package:deprem_destek/pages/my_demand_page/state/my_demands_cubit.dart';
import 'package:deprem_destek/pages/my_demand_page/state/my_demands_state.dart';
import 'package:deprem_destek/pages/my_demand_page/widgets/demand_category_selector.dart';
import 'package:deprem_destek/pages/my_demand_page/widgets/geo_value_accessor.dart';
import 'package:deprem_destek/pages/my_demand_page/widgets/loader.dart';
import 'package:deprem_destek/pages/my_demand_page/widgets/my_demand_textfield.dart';
import 'package:deprem_destek/shared/extensions/reactive_forms_extensions.dart';
import 'package:deprem_destek/shared/state/app_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_geocoding_api/google_geocoding_api.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../data/repository/auth_repository.dart';

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
                        decoration: InputDecoration(
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(width: 2, color: Colors.red),
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.grey.shade200,
                            ),
                          ),
                          hintStyle: TextStyle(color: Colors.grey.shade500),
                        ),
                        valueAccessor: GeoValueAccessor(),
                      ),
                      DemandCategorySelector(
                        formControl: _myDemandPageFormGroup.control(
                          _MyDemandPageFormFields.categories.name,
                        ) as FormControl<List<String>>,
                      ),
                      MyDemandsTextField<String>(
                        hintText: 'Neye İhtiyacın Var?',
                        formControlName: _MyDemandPageFormFields.notes.name,
                      ),
                      MyDemandsTextField<String>(
                        hintText: '',
                        formControlName:
                            _MyDemandPageFormFields.phoneNumber.name,
                        inputFormatters: [LengthLimitingTextInputFormatter(10)],
                      ),
                      MyDemandsTextField<String>(
                        hintText: '',
                        formControlName:
                            _MyDemandPageFormFields.wpPhoneNumber.name,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                      ReactiveFormConsumer(
                        builder: (context, form, _) {
                          return CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            value: form
                                .control(
                                  _MyDemandPageFormFields.wpPhoneNumber.name,
                                )
                                .enabled,
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
                            title: Row(
                              children: const [
                                Text('Whatsapp ile ulaşılsın'),
                                SizedBox(
                                  width: 8,
                                ),
                                Icon(
                                  FontAwesomeIcons.whatsapp,
                                  color: Colors.green,
                                ),
                              ],
                            ),
                          );

                          // return Row(
                          //   children: [
                          //     const Spacer(),
                          //     Checkbox(
                          //       onChanged: (value) => value != true
                          //           ? form
                          //               .control(
                          //                 _MyDemandPageFormFields
                          //                     .wpPhoneNumber.name,
                          //               )
                          //               .markAsDisabled()
                          //           : form
                          //               .control(
                          //                 _MyDemandPageFormFields
                          //                     .wpPhoneNumber.name,
                          //               )
                          //               .markAsEnabled(),
                          //       value: form
                          //           .control(
                          //             _MyDemandPageFormFields
                          //                 .wpPhoneNumber.name,
                          //           )
                          //           .enabled,
                          //     ),
                          //     const Text('Whatsapp ile ulaşılsın'),
                          //     const SizedBox(
                          //       width: 8,
                          //     ),
                          //     const Icon(
                          //       FontAwesomeIcons.whatsapp,
                          //       color: Colors.green,
                          //     ),
                          //   ],
                          // );
                        },
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
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                    ),
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
                                              _MyDemandPageFormFields
                                                  .notes.name,
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
                                                              .wpPhoneNumber
                                                              .name,
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
                                    child: Padding(
                                      padding: const EdgeInsets.all(14),
                                      child: Text(
                                        'Kaydet',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                                if (state.demand != null) ...[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                      ),
                                      onPressed: !deactivateButtons
                                          ? () {
                                              final demand = state.demand!;

                                              if (state.demand!.isActive) {
                                                context
                                                    .read<MyDemandsCubit>()
                                                    .deactivateDemand(
                                                      demandId: demand.id,
                                                    );
                                              } else {
                                                context
                                                    .read<MyDemandsCubit>()
                                                    .activateDemand(
                                                      demandId: demand.id,
                                                    );
                                              }
                                            }
                                          : null,
                                      child: Padding(
                                        padding: const EdgeInsets.all(14),
                                        child: Text(
                                          state.demand!.isActive
                                              ? 'Talebi durdur'
                                              : 'Talebi sürdür',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            );
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: OutlinedButton(
                          onPressed: () {
                            context.read<AuthRepository>().logout();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              'Çıkış yap',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
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
