import 'package:deprem_destek/gen/assets.gen.dart';
import 'package:deprem_destek/shared/state/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                Assets.logoSvg,
                height: 75,
                width: 75,
              ),
              const SizedBox(height: 16),
              Text(
                'Bu platform lokasyon verinizi kullanarak çalışmaktadır. \n'
                'Lütfen cihazınızdaki konum servisini \n'
                'aktif ettiğinizden emin olunuz.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontSize: 20,
                    ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(double.maxFinite - 40, 50),
                ),
                onPressed: () => context.read<AppCubit>().startApp(),
                child: const Text('Konum izni ver'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
