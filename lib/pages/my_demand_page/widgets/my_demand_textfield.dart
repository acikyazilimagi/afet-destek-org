import 'package:deprem_destek/pages/my_demand_page/widgets/geo_value_accessor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';

class MyDemandsTextField<T> extends StatelessWidget {
  const MyDemandsTextField({
    super.key,
    required this.hintText,
    required this.formControlName,
    this.inputFormatters,
    // required this.onChanged,
  });
  final String hintText;
  final String formControlName;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: ReactiveTextField<T>(
        // valueAccessor: GeoValueAccessor(),
        inputFormatters: inputFormatters,
        formControlName: formControlName,
        // onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 2, color: Colors.red),
          ),
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 2, color: Colors.grey.shade200),
          ),
          hintStyle: TextStyle(color: Colors.grey.shade500),
        ),
      ),
    );
  }
}
