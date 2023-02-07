import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  const MyDemandPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final location = context.read<AppCubit>().state;

    return location.when(failed: () {
      return const SizedBox();
    }, loaded: (
      GoogleGeocodingResult currentLocation,
      List<DemandCategory> demandCategories,
    ) {
      return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: ReactiveForm(
            onWillPop: () async => false,
            formGroup: FormGroup({
              _MyFormFields.geoLocation.name: FormControl<String>(
                value: currentLocation.formattedAddress,
              ),
              _MyFormFields.demands.name: FormControl<DemandCategory>(),
              _MyFormFields.needText.name: FormControl<String?>(),
              _MyFormFields.phoneNumber.name: FormControl<String?>(
                validators: [
                  Validators.required,
                  Validators.number,
                  Validators.max(10)
                ],
              ),
              _MyFormFields.wpPhoneNumber.name: FormControl<String?>(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReactiveTextField(
                    formControlName: _MyFormFields.geoLocation.name,
                    decoration: const InputDecoration(
                      suffixIcon: Icon(
                        Icons.location_on,
                      ),
                    ),
                  ),
                  ReactiveDropdownField<DemandCategory>(
                    formControlName: _MyFormFields.demands.name,
                    decoration: InputDecoration(labelText: "İhtiyaç Türü"),
                    items: demandCategories
                        .map(
                          (e) => DropdownMenuItem<DemandCategory>(
                            value: e,
                            child: Text(e.name),
                          ),
                        )
                        .toList(),
                  ),
                  Wrap(
                    alignment: WrapAlignment.spaceEvenly,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    runAlignment: WrapAlignment.spaceEvenly,
                    spacing: 12,
                    children: List.generate(
                      5,
                      (index) => RawChip(
                        label: Text("barınma"),
                        onDeleted: () {},
                      ),
                    ),
                  ),
                  ReactiveTextField(
                    decoration:
                        InputDecoration(hintText: "Neye İhtiyacın Var?"),
                    formControlName: _MyFormFields.needText.name,
                  ),
                  ReactiveTextField(
                    decoration: InputDecoration(prefixText: "+90"),
                    formControlName: _MyFormFields.phoneNumber.name,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                  Row(
                    children: const [
                      Icon(FontAwesomeIcons.whatsapp),
                      Text("Whatsapp ile ulaşılsın"),
                    ],
                  ),
                  ReactiveTextField(
                    decoration: InputDecoration(prefixText: "+90"),
                    formControlName: _MyFormFields.wpPhoneNumber.name,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                  ReactiveFormConsumer(
                    builder: (context, formState, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              onPressed: formState.valid ? () {} : null,
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
        ),
      );
    }, loading: () {
      return Loader();
    });
  }
}

enum _MyFormFields {
  geoLocation,
  demands,
  needText,
  phoneNumber,
  wpPhoneNumber,
}
