import 'package:deprem_destek/pages/demands_page/widgets/home_chip_chip.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class HomeListCard extends StatelessWidget {
  HomeListCard({
    super.key,
    this.talepNotlari,
    required this.date,
    required this.il,
  });
  List<String>? talepNotlari;
  DateTime date;
  String il;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Container(
            height: 10,
            decoration: const BoxDecoration(
              color: Color(0xffDC2626),
              borderRadius: BorderRadius.vertical(top: Radius.circular(9)),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            // height: 202,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xffF0F0F0), width: 1.0),
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(9),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      flex: 2,
                      child: Text(
                        il, //"Kahramanmaraş",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                          color: Color(0xff101828),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      flex: 1,
                      child: Text(
                        dateFormatter(
                          date,
                        ), //"${DateFormat('dd/MM/yyyy').format(DateTime.now())}",
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Color(0xff101828),
                        ),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Talep Notları",
                    style: TextStyle(color: Color(0xff475467)),
                  ),
                ),
                Wrap(
                  children: [
                    for (var i in talepNotlari!) HomeCardChip(label: i),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffDC2626),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: Colors.red),
                    ),
                  ),
                  child: const Text(
                    "Detay",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String dateFormatter(DateTime date) {
    // DateFormat('dd/MM/yyyy').format(DateTime.now())
    var _d = DateTime.now().difference(date); //.inMinutes;
    //print(_d);
    if (_d.inMinutes < 1) {
      return "${_d.inSeconds} Saniye Önce";
    }
    if (_d.inHours < 1) {
      return "${_d.inMinutes} Dakika Önce";
    }
    if (_d.inDays < 1) {
      return "${_d.inHours} Saat Önce";
    }
    if (_d.inDays < 30) {
      return "${_d.inDays} Gün Önce";
    } else {
      return DateFormat('dd/MM/yyyy').format(date);
    }
  }
}
