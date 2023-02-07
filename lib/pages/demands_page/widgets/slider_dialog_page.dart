import 'package:deprem_destek/pages/demands_page/widgets/sf_slider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../state/dialog_cubit.dart';
import 'chip_button.dart';

class SliderDialogPage extends StatelessWidget {
  const SliderDialogPage({
    super.key,
    
  });


  @override
  Widget build(BuildContext context) {
    final redColor = Color(0xffDC2626);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 15),
      child: BlocConsumer<DialogCubit, DialogState>(
        listener: (context, state) {},
        builder: (context, state) {
          final contextRead = context.read<DialogCubit>();
          final contextWatch = context.watch<DialogCubit>();
          return state.when(
             
              onDialog: (value, material, isDialog, states) => Padding(
                    padding: const EdgeInsets.only(top: 50.0, bottom: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SfSliderTheme(
                            data: SfSliderThemeData(
                              tooltipBackgroundColor: redColor,
                            ),
                            child: SfSilderWidget(
                                contextWatch: contextWatch,
                                redColor: redColor,
                                contextRead: contextRead)),
                        Wrap(
                          children: context
                              .watch<DialogCubit>()
                              .datas
                              .map<Widget>((e) {
                            var isSelect =
                                contextWatch.demandsCatagory.contains(e);
                            return ChipButton(
                              color: isSelect ? Colors.white : Colors.black,
                              onDeleted: isSelect
                                  ? () {
                                      //TODO:Emit problem
                                      contextRead.setSliderValue(value, e);
                                      //  print(e +"deneme");
                                    }
                                  : null,
                              onTap: () =>
                                  context.read<DialogCubit>().tickButton(e),
                              text: e,
                              textColor: isSelect ? Colors.white : Colors.black,
                              backgroundColor:
                                  contextWatch.demandsCatagory.contains(e)
                                      ? const Color(0xff1F2937)
                                      : Colors.white,
                              borderColor:
                                  contextWatch.demandsCatagory.contains(e)
                                      ? const Color(0xff1F2937)
                                      : const Color(0xffD0D5DD),
                            );
                          }).toList(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xffDC2626)),
                                onPressed: () {},
                                child: Text("Filtrele")),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Color(0xffD0D5DD),
                                  side: const BorderSide(
                                    color: Color(0xffD0D5DD),
                                    width: 1,
                                  ),
                                ),
                                onPressed: () {
                                  context.read<DialogCubit>().changeDialog();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0),
                                  child: Text("Filtreyi Kapat"),
                                )),
                          ],
                        )
                      ],
                    ),
                  ));
        },
      ),
    );
  }
}
