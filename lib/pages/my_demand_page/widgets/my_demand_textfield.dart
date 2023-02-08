import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';

class MyDemandsTextField<T> extends StatelessWidget {
  const MyDemandsTextField({
    super.key,
    this.labelText,
    this.hintText,
    required this.formControlName,
    this.isLongBody = false,
    this.inputFormatters,
    this.validationMessages,
  }) : assert(
          labelText != null || hintText != null,
          'Either labelText or hintText must be provided',
        );
  final String? labelText;
  final String? hintText;
  final String formControlName;
  final List<TextInputFormatter>? inputFormatters;
  final bool isLongBody;
  final Map<String, String Function(Object)>? validationMessages;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: ReactiveTextField<T>(
        showErrors: (control) =>
            control.invalid && control.touched && control.dirty,
        validationMessages: validationMessages,
        // valueAccessor: GeoValueAccessor(),
        inputFormatters: inputFormatters,
        formControlName: formControlName,
        // onChanged: onChanged,
        maxLines: isLongBody ? 4 : 1,
        maxLength: isLongBody ? 1000 : null,
        decoration: InputDecoration(
          labelText: labelText,
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
