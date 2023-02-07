part of 'dialog_cubit.dart';

@freezed
class DialogState with _$DialogState {
  const factory DialogState.onDialog(
      {required double value,
      required List<String> material,
      required bool isDialog,
      required MyDialogStatus dialogStatus}) = _OnDialog;
}

enum MyDialogStatus { onDialogControl, onChipControl }
