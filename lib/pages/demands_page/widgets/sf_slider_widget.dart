import 'package:deprem_destek/pages/demands_page/state/dialog_cubit.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../state/demands_cubit.dart';

class SfSilderWidget extends StatelessWidget {
  const SfSilderWidget({
    super.key,
    required this.contextWatch,
    required this.redColor,
    required this.contextRead,
  });

  final DialogCubit contextWatch;
  final Color redColor;
  final DialogCubit contextRead;

  @override
  Widget build(BuildContext context) {
    const color = Color(
          0xffDC2626);
    return SfSlider(
      activeColor:  color, //Theme.of(context).primaryColor,
      min: 0.0,
      max: 500.0,
      interval: 50.0,
      shouldAlwaysShowTooltip: true,
      tooltipTextFormatterCallback:
          (actualValue, formattedText) {
        return "${(actualValue as double).toInt()} KM";
      },

      value: contextWatch.sliderValue.toInt(),

      dividerShape: const SfDividerShape(),
      //showTicks: true,
      //showLabels: true,
      enableTooltip: true,
      labelPlacement: LabelPlacement.betweenTicks,

      //  numberFormat: NumberFormat(),
      inactiveColor: redColor.withOpacity(0.2),

      minorTicksPerInterval: 1,
      onChanged: (value) {
        contextRead.setSliderValue(value as double,null);
      },
    );
  }
}

