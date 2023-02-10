// ignore_for_file: avoid_escaping_inner_quotes

import 'package:afet_destek/gen/assets.gen.dart';
import 'package:afet_destek/pages/kvkk_page/kvkk_page.dart';
import 'package:afet_destek/shared/state/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 700,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(height: height * 0.2),
                buildLogo(height),
                SizedBox(height: height * 0.05),
                buildTitle(context),
                SizedBox(height: height * 0.05),
                buildContent(context),
                SizedBox(height: height * 0.05),
                SizedBox(
                  width: width * .8,
                  child: buildRequestButton(context, width, height),
                ),
                SizedBox(height: height * 0.05),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: buildKvkkTextButton(context),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //DO NOT USE FUNCTION FOR WIDGET
  TextButton buildKvkkTextButton(BuildContext context) {
    return TextButton(
      onPressed: () => KVKKPage.show(context),
      style: TextButton.styleFrom(
        foregroundColor: Theme.of(context).textTheme.titleSmall?.color,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text('KVKK Açık Rıza Metni\'ni oku '),
          Icon(Icons.arrow_forward),
        ],
      ),
    );
  }

  ElevatedButton buildRequestButton(
    BuildContext context,
    double width,
    double height,
  ) {
    return ElevatedButton(
      onPressed: () => context.read<AppCubit>().startApp(),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(width * .8, 50),
        maximumSize: Size(width * .8, 70),
      ),
      child: const Text('Konum izni ver'),
    );
  }

  Text buildContent(BuildContext context) {
    return Text(
      '''
      Bu platform lokasyon verinizi kullanarak çalışmaktadır.
      Lütfen cihazınızdaki konum servisini aktif ettiğinizden emin olunuz.
      ''',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.titleSmall,
    );
  }

  Text buildTitle(BuildContext context) {
    return Text(
      'Afet Destek Platformu',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }

  SvgPicture buildLogo(double height) {
    return SvgPicture.asset(
      Assets.logoSvg,
      height: height * .15,
    );
  }
}
