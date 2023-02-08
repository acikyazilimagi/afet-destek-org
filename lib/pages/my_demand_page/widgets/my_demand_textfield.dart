import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';

class MyDemandsTextField<T> extends StatelessWidget {
  const MyDemandsTextField({
    super.key,
    required this.hintText,
    required this.formControlName,
    this.inputFormatters,
    this.icon,
    this.validationMessages,
  });
  final String hintText;
  final String formControlName;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? icon;
  final Map<String, ValidationMessageFunction>? validationMessages;
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
        decoration: InputDecoration(
          prefixIcon: Align(
            widthFactor: 2.5,
            child: icon ?? const SizedBox(),
          ),
          prefixIconConstraints: const BoxConstraints(
            minHeight: 20,
            minWidth: 20,
          ),
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
