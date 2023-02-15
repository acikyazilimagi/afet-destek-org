import 'package:afet_destek/data/api/demands_api_client.dart';
import 'package:afet_destek/data/repository/auth_repository.dart';
import 'package:afet_destek/data/repository/demands_repository.dart';
import 'package:afet_destek/data/repository/location_repository.dart';
import 'package:afet_destek/pages/app_load_failure_page/app_load_failure_page.dart';
import 'package:afet_destek/pages/demand_details_page/demand_details_page.dart';
import 'package:afet_destek/pages/demands_page/demands_page.dart';
import 'package:afet_destek/pages/introduction_page/introduction_page.dart';
import 'package:afet_destek/shared/state/app_cubit.dart';
import 'package:afet_destek/shared/state/app_state.dart';
import 'package:afet_destek/shared/theme/theme.dart';
import 'package:afet_destek/shared/widgets/loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DepremDestekApp extends StatefulWidget {
  const DepremDestekApp({super.key});

  @override
  State<DepremDestekApp> createState() => _DepremDestekAppState();
}

class _DepremDestekAppState extends State<DepremDestekApp> {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider<DemandsRepository>(
          create: (context) => DemandsRepository(
            demandsApiClient: DemandsApiClient(),
          ),
        ),
        RepositoryProvider<LocationRepository>(
          create: (context) => LocationRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AppCubit>(
            create: (context) => AppCubit(
              demandsRepository: context.read<DemandsRepository>(),
              locationRepository: context.read<LocationRepository>(),
            ),
          ),
        ],
        child: MaterialApp.router(
          routerConfig: _router,
          theme: AppTheme.light(context),
          darkTheme: AppTheme.dark(context),
          themeMode: ThemeMode.light,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          builder: (context, child) {
            return ScrollConfiguration(
              behavior: ScrollConfiguration.of(context)
                  .copyWith(physics: const ClampingScrollPhysics()),
              child: child!,
            );
          },
        ),
      ),
    );
  }
}

final _router = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: kDebugMode,
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        child: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            return state.when(
              initializing: () => const Scaffold(body: Loader()),
              introduction: () => const IntroductionPage(),
              loaded: (_, __) => const DemandsPage(),
              failed: () => const AppLoadFailurePage(),
              loading: () => const Scaffold(body: Loader()),
            );
          },
        ),
      ),
      routes: [
        GoRoute(
          path: 'demand/:demandId',
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: DemandDetailsPage(
              demandId: state.params['demandId']!,
            ),
          ),
        ),
      ],
    ),
  ],
  errorPageBuilder: (context, state) => NoTransitionPage(
    key: state.pageKey,
    child: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Sayfa bulunamadı',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text('Anasayfaya Git'),
              onPressed: () => context.go('/'),
            ),
          ],
        ),
      ),
    ),
  ),
);
