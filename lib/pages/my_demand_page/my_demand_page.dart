import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_geocoding_api/google_geocoding_api.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../data/models/demand_category.dart';
import '../../shared/state/app_cubit.dart';
import '../../shared/state/app_state.dart';
import '../app_load_failure_page/app_load_failure_page.dart';
import 'widgets/loader.dart';

class MyDemandPage extends StatelessWidget {
  const MyDemandPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return state.when(
            failed: () => const AppLoadFailurePage(),
            loading: () => const Scaffold(body: Loader()),
            loaded: (location, demandsList) {
              return SingleChildScrollView(
                child: ReactiveForm(
                  onWillPop: () async => false,
                  formGroup: FormGroup({
                    MyFormFields.geoLocation.name: FormControl<String>(
                      value: location.formattedAddress,
                    ),
                    MyFormFields.demands.name: FormControl<DemandCategory>(),
                    MyFormFields.needText.name: FormControl<String?>(),
                    MyFormFields.phoneNumber.name: FormControl<String?>(
                      validators: [
                        Validators.required,
                        Validators.number,
                        Validators.max(10)
                      ],
                    ),
                    MyFormFields.wpPhoneNumber.name: FormControl<String?>(
                      validators: [
                        Validators.required,
                        Validators.number,
                        Validators.max(10)
                      ],
                    ),
                  }),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        ReactiveTextField(
                          formControlName: MyFormFields.geoLocation.name,
                          decoration: const InputDecoration(
                            suffixIcon: Icon(
                              Icons.location_on,
                            ),
                          ),
                        ),
                        ReactiveDropdownField<DemandCategory>(
                          formControlName: MyFormFields.demands.name,
                          items: demandsList
                              .map(
                                (e) => DropdownMenuItem<DemandCategory>(
                                  value: e,
                                  child: Text(e.name),
                                ),
                              )
                              .toList(),
                        ),
                        Wrap(
                          runAlignment: WrapAlignment.start,
                          crossAxisAlignment: WrapCrossAlignment.start,
                          children: List.generate(
                            5,
                            (index) => RawChip(
                              label: Text("barınma"),
                              onDeleted: () {},
                            ),
                          ),
                        ),
                        ReactiveTextField(
                          formControlName: MyFormFields.needText.name,
                        ),
                        ReactiveTextField(
                          formControlName: MyFormFields.phoneNumber.name,
                        ),
                        Row(
                          children: const [
                            Icon(FontAwesomeIcons.whatsapp),
                            Text("Whatsapp ile ulaşılsın"),
                          ],
                        ),
                        ReactiveTextField(
                          formControlName: MyFormFields.wpPhoneNumber.name,
                        ),
                        ReactiveFormConsumer(
                          builder: (context, _, child) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                    onPressed: () {},
                                    child: const Text("Kaydet")),
                                ElevatedButton(
                                    onPressed: () {},
                                    child: const Text("Talebi durdur")),
                              ],
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

enum MyFormFields {
  geoLocation,
  demands,
  needText,
  phoneNumber,
  wpPhoneNumber,
}
