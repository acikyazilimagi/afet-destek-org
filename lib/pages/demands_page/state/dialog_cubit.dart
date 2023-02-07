import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dialog_state.dart';
part 'dialog_cubit.freezed.dart';

class DialogCubit extends Cubit<DialogState> {
  DialogCubit()
      : super(DialogState.onDialog(
            dialogStatus: MyDialogStatus.onDialogControl,
            isDialog: false,
            material: [],
            value: 0.0));
  var sliderValue = 0.0;
  var isDialog = false;
  List<String> demandsCatagory = [];
  List<String> datas = [
    "Malzeme",
    'Barınma',
    "Gıda",
    "Refakatçi",
    "Ulaşım",
    "Diğer"
  ];

  void setSliderValue(double value, String? values) {
    sliderValue = value;
    tickButton(values);

    emit(DialogState.onDialog(
        material: demandsCatagory,
        dialogStatus: MyDialogStatus.onChipControl,
        isDialog: isDialog,
        value: sliderValue));
  }

  void changeDialog() {
    isDialog = !isDialog;
    emit(DialogState.onDialog(
        material: demandsCatagory,
        dialogStatus: MyDialogStatus.onDialogControl,
        isDialog: isDialog,
        value: sliderValue));
  }

  void tickButton(String? value) {
    if (demandsCatagory.contains(value)) {
      demandsCatagory.remove(value);
    } else if(value!=null){
      demandsCatagory.add(value);
    }
    print(demandsCatagory);

    emit(DialogState.onDialog(
        material: demandsCatagory,
        dialogStatus: MyDialogStatus.onDialogControl,
        isDialog: isDialog,
        value: sliderValue));
  }

  void onDeleted(String e) {
    var isExist = demandsCatagory.contains(e);
    if (isExist)
      tickButton(e.toString());
    else {
      tickButton(e);
    }

    emit(DialogState.onDialog(
        material: demandsCatagory,
        dialogStatus: MyDialogStatus.onDialogControl,
        isDialog: isDialog,
        value: sliderValue));
  }
}
