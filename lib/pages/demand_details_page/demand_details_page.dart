import 'package:afet_destek/data/models/demand.dart';
import 'package:afet_destek/data/repository/auth_repository.dart';
import 'package:afet_destek/gen/translations/locale_keys.g.dart';
import 'package:afet_destek/pages/demands_page/widgets/demand_card.dart';
import 'package:afet_destek/shared/extensions/translation_extension.dart';
import 'package:afet_destek/shared/state/app_cubit.dart';
import 'package:afet_destek/shared/widgets/loader.dart';
import 'package:afet_destek/shared/widgets/responsive_app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DemandDetailsPage extends StatelessWidget {
  const DemandDetailsPage._({required this.demand});
  final Demand demand;

  static Future<void> show(
    BuildContext context, {
    required Demand demand,
  }) async {
    await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(
        builder: (context) {
          return DemandDetailsPage._(demand: demand);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentLocation = context.read<AppCubit>().state.whenOrNull(
          loaded: (currentLocation, demandCategories) => currentLocation,
        );

    if (currentLocation == null) {
      return const Scaffold(body: Loader());
    }

    return StreamBuilder<User?>(
      stream: context.read<AuthRepository>().userStream,
      builder: (context, snapshot) {
        final authorized = snapshot.data != null;
        return _DemandDetailsPageView(
          isAuthorized: authorized,
          demand: demand,
        );
      },
    );
  }
}

class _DemandDetailsPageView extends StatelessWidget {
  const _DemandDetailsPageView({
    required this.isAuthorized,
    required this.demand,
  });
  final Demand demand;
  final bool isAuthorized;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const ResponsiveAppBar(),
      body: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: 800,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      if (size.width >= 1000)
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back),
                        ),
                      Text(
                        LocaleKeys.help_demands.getStr(),
                        maxLines: 1,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                          color: Color(0xff101828),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  DemandCard(
                    demand: demand,
                    isDetailed: true,
                  ),
                  const SizedBox(height: 32),
                  Center(
                    child: Text(
                      LocaleKeys.please_prefer_sms_or_whatsapp.getStr(),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
