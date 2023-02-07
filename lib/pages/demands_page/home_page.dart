// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:ui' show ImageFilter;

import 'package:deprem_destek/pages/demands_page/widgets/home_demand_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isDialogOpen = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        elevation: 0,
        backgroundColor: const Color(0xffDC2626),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
        icon: const Icon(Icons.add),
        onPressed: () {},
        label: const Text('Talep Ekle'),
      ),
      appBar: appBar(),
      body: body(),
      bottomNavigationBar: bottomSheet(),
    );
  }

  GestureDetector bottomSheet() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 60,
        decoration: const BoxDecoration(
          color: Color(0xffDC2626),
          border: Border(top: BorderSide(color: Colors.white)),
        ),
        child: const Center(
          child: Text(
            'Talebim',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget body() {
    return Stack(
      children: [
        ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            addDemand(),
            //filterWidget(),
            HomeListCard(
              il: 'Kahramanmaraş',
              date: DateTime(
                2023,
                02,
                07,
                DateTime.now().hour,
                DateTime.now().minute,
                DateTime.now().second - 15,
              ),
              talepNotlari: [
                'Kitap',
                'Giyim',
              ],
            ),
            HomeListCard(
              il: 'Gaziantep',
              date: DateTime(
                2023,
                02,
                07,
                DateTime.now().hour,
                DateTime.now().minute - 29,
              ),
              talepNotlari: [
                'Malzeme',
                'Gıda',
              ],
            ),
            HomeListCard(
              il: 'Hatay',
              date: DateTime(2023, 02, 07),
              talepNotlari: [
                'Malzeme',
              ],
            ),
            HomeListCard(
              il: 'Malatya',
              date: DateTime(2023, 02, 02),
              talepNotlari: [
                'Kitap',
                'Giyim',
                'abc',
                'Kitap',
                'Giyim',
                'abc',
              ],
            ),
            HomeListCard(
              il: 'Adıyaman',
              date: DateTime(2023, 01, 02),
              talepNotlari: [
                'Kitap',
                'Giyim',
                'abc',
                'Kitap',
                'Giyim',
                'abc',
              ],
            ),
          ],
        ),
        if (isDialogOpen)
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Center(
              child: Card(
                elevation: 10,
                color: Colors.white.withOpacity(0.1),
                child: SizedBox(
                  child: dialog(context),
                ),
              ),
            ),
          )
        else
          const SizedBox(),
      ],
    );
  }

  Widget addDemand() {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: const Color(0xffDC2626),
        borderRadius: BorderRadius.circular(9),
      ),
      child: const Center(
        child: Text(
          'Talep Ekle',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      leading: Padding(
        padding: const EdgeInsets.all(6),
        child: SvgPicture.asset(
          'assets/svg/appbar_icon.svg',
        ),
      ),
      elevation: 0,
      shape: const Border(bottom: BorderSide(color: Color(0xffEAECF0))),
      foregroundColor: Colors.black,
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              isDialogOpen = !isDialogOpen;
            });
          },
          icon: const Icon(Icons.filter_list),
        )
      ],
    );
  }

  dynamic values = 0.0;
  Widget dialog(BuildContext context) {
    final datas = <String>[
      'Malzeme',
      'Barınma',
      'Gıda',
      'Refakatçi',
      'Ulaşım',
      'Diğer'
    ];

    return StatefulBuilder(
      builder: (context, setState) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 15),
          child: Padding(
            padding: const EdgeInsets.only(top: 50, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SfSliderTheme(
                  data: SfSliderThemeData(
                    tooltipBackgroundColor: const Color(0xffDC2626),
                  ),
                  child: SfSlider(
                    activeColor: const Color(
                      0xffDC2626,
                    ),
                    max: 500.0,
                    value: values,
                    enableTooltip: true,
                    labelPlacement: LabelPlacement.betweenTicks,
                    tooltipTextFormatterCallback: (actualValue, formattedText) {
                      // ignore: avoid_dynamic_calls
                      return '${actualValue.toStringAsFixed(0)} KM';
                    },
                    inactiveColor: const Color(0xffDC2626).withOpacity(0.2),
                    minorTicksPerInterval: 1,
                    onChanged: (value) {
                      setState(() {
                        values = (value as double).toInt();
                      });
                    },
                  ),
                ),
                Wrap(
                  children: datas
                      .map<Widget>(
                        (e) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Chip(
                            backgroundColor: Colors.white,
                            side: const BorderSide(
                              color: Color(0xffD0D5DD),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            onDeleted: () {},
                            // ignore: noop_primitive_operations
                            label: Text(e.toString()),
                          ),
                        ),
                      )
                      .toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffDC2626),
                      ),
                      onPressed: () {},
                      child: const Text('Filtrele'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xffD0D5DD),
                        side: const BorderSide(
                          color: Color(0xffD0D5DD),
                        ),
                      ),
                      onPressed: () {},
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Text('Filtreyi Kapat'),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
