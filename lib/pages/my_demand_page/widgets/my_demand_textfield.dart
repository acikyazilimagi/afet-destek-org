import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';

class MyDemandsTextField<T> extends StatelessWidget {
  const MyDemandsTextField({
    super.key,
    required this.labelText,
    required this.formControlName,
    this.isLongBody = false,
    this.inputFormatters,
    // required this.onChanged,
  });
  final String labelText;
  final String formControlName;
  final List<TextInputFormatter>? inputFormatters;
  final bool isLongBody;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: ReactiveTextField<T>(
        // valueAccessor: GeoValueAccessor(),
        inputFormatters: inputFormatters,
        formControlName: formControlName,
        // onChanged: onChanged,
        maxLines: isLongBody ? 4 : 1,
        decoration: InputDecoration(
          labelText: labelText,
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
