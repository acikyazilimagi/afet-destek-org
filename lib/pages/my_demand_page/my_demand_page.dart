import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_geocoding_api/google_geocoding_api.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../data/models/demand_category.dart';
import '../../shared/state/app_cubit.dart';
import '../../shared/state/app_state.dart';

class MyDemandPage extends StatefulWidget {
  const MyDemandPage({
    super.key,
  });

  @override
  State<MyDemandPage> createState() => _MyDemandPageState();
}

class _MyDemandPageState extends State<MyDemandPage> {
  late final GoogleGeocodingResult location;
  late final List<DemandCategory> demansCategories;

  @override
  void initState() {
    super.initState();
    context.read<AppCubit>().state.mapOrNull(
      loaded: (state) {
        location = state.currentLocation;
        demansCategories = state.demandCategories;
      },
    );

    formGroup = FormGroup({
      _MyFormFields.geoLocation.name: FormControl<String>(
        value: location.formattedAddress,
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
      _MyFormFields.wpPhoneNumber.name: FormControl<String?>(),
    });
  }

  late final FormGroup formGroup;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: ReactiveForm(
          onWillPop: () async => false,
          formGroup: formGroup,
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
                  decoration: const InputDecoration(labelText: "İhtiyaç Türü"),
                  items: demansCategories
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
                      label: Text('barınma'),
                      onDeleted: () {},
                    ),
                  ),
                ),
                ReactiveTextField(
                  decoration: InputDecoration(hintText: 'Neye İhtiyacın Var?'),
                  formControlName: _MyFormFields.needText.name,
                ),
                ReactiveTextField(
                  decoration: InputDecoration(
                    prefixIcon: Text('+90'),
                    // isDense: true,
                    prefixIconConstraints:
                        BoxConstraints(minWidth: 0, minHeight: 0),
                  ),
                  formControlName: _MyFormFields.phoneNumber.name,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
                Row(
                  children: const [
                    Icon(FontAwesomeIcons.whatsapp),
                    Text('Whatsapp ile ulaşılsın'),
                  ],
                ),
                ReactiveTextField(
                  formControlName: _MyFormFields.wpPhoneNumber.name,
                  decoration: const InputDecoration(
                    prefixIcon: Text('+90'),
                    // isDense: true,
                    prefixIconConstraints:
                        BoxConstraints(minWidth: 0, minHeight: 0),
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
                ReactiveFormConsumer(
                  builder: (context, formGroup, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: formGroup.valid ? () {} : null,
                          child: const Text(
                            'Kaydet',
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Talebi durdur'),
                        ),
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
  }
}

enum _MyFormFields {
  geoLocation,
  demands,
  needText,
  phoneNumber,
  wpPhoneNumber,
}
