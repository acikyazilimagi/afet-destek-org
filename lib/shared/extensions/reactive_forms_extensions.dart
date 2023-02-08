import 'package:reactive_forms/reactive_forms.dart';

extension ReactiveFormsValueExtractorX on FormGroup {
  T readByControlName<T>(String formControlName) {
    if (!controls.keys.contains(formControlName)) {
      throw ReactiveFieldValueReadError(
        'FormControl $formControlName is not in the FormGroup $this',
      );
    }
    if (control(formControlName).invalid) {
      throw ReactiveFieldValueReadError(
        'FormControl with name $formControlName is not valid',
      );
    }
    return control(formControlName).value as T;
  }

  T? readNullableByControlName<T>(String formControlName) {
    try {
      if (controls.keys.contains(formControlName) &&
          control(formControlName).value != null) {
        return control(formControlName).value as T;
      }
      return null;
    } catch (_) {
      return null;
    }
  }
}

class ReactiveFieldValueReadError extends Error {
  ReactiveFieldValueReadError(this.message);

  final String message;
}
