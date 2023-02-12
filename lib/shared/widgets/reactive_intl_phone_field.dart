import 'package:afet_destek/gen/translations/locale_keys.g.dart';
import 'package:afet_destek/shared/extensions/translation_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactiveIntlPhoneField extends StatelessWidget {
  const ReactiveIntlPhoneField({
    required this.formControl,
    this.invalidNumberMessage,
    super.key,
  });
  final FormControl<String> formControl;
  final String? invalidNumberMessage;
  @override
  Widget build(BuildContext context) {
    return ReactiveFormConsumer(
      builder: (context, form, _) {
        return IntlPhoneField(
          pickerDialogStyle: PickerDialogStyle(
            width: MediaQuery.of(context).size.width.clamp(0, 500),
            searchFieldInputDecoration: InputDecoration(
              labelText: LocaleKeys.search_country.getStr(),
            ),
          ),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          invalidNumberMessage: invalidNumberMessage,
          initialValue: formControl.value,
          onChanged: (value) => formControl.value = value.completeNumber,
        );
      },
    );
  }
}
