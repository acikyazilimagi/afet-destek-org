// ignore_for_file: use_decorated_box

import 'package:deprem_destek/config/palette.dart';
import 'package:deprem_destek/config/theme.dart';
import 'package:deprem_destek/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';

class DemandsDetail extends StatelessWidget {
  const DemandsDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Palette.backgroundColor,
          leading: SvgPicture.asset("Vector.svg"),
        ),
        endDrawer: Drawer(
          child: ListView.builder(itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: const Icon(Icons.list),
              title: Text("item $index"),
              trailing: const Icon(Icons.done),
            );
          }),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  Text("Talep Detay", style: CustomTheme.headline6(context, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.fromBorderSide(BorderSide(color: Colors.grey.shade300, width: 0.5)),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 10,
                      decoration: BoxDecoration(
                        color: Palette.primaryColor,
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Gaziantep",
                                style: CustomTheme.headline6(context, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "1 saat önce",
                                style: CustomTheme.subtitle(context),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Talep notları",
                            style: CustomTheme.subtitle(context, color: Colors.blueGrey),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Wrap(
                            children: [
                              itemBox(context, "Talep türü 1"),
                              itemBox(context, "Talep türü 1"),
                              itemBox(context, "Talep türü 1"),
                              itemBox(context, "Talep türü 1"),
                              itemBox(context, "Talep türü 1"),
                              itemBox(context, "Talep türü 1"),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade200),
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                ),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(stops: [0.015, 0.015], colors: [Palette.primaryColor, Colors.white]),
                      borderRadius: const BorderRadius.all(Radius.circular(5.0))),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "Bu kişinin kimliği tarafımızca doğrulanmamıştır. Lütfen dikkatli olunuz.",
                      style: CustomTheme.headline6(
                        context,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(text: "Whatsapp ile Ulaş", customButtonType: CustomButtonType.whatsapp, onPressed: () {}),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(text: "SMS ile Ulaş", customButtonType: CustomButtonType.sms, onPressed: () {}),
            ),
            Spacer(),
            Text(
              "Lütfen aramayı tercih etmeyiniz",
                       style: CustomTheme.subtitle(context, color: Colors.blueGrey),
            ),
            Spacer(),
          ],
        ));
  }

  Widget itemBox(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: CustomTheme.subtitle(context),
          ),
        ),
      ),
    );
  }
}
