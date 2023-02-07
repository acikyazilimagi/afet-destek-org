import 'package:deprem_destek/data/repository/auth_repository.dart';
import 'package:deprem_destek/data/repository/demands_repository.dart';
import 'package:deprem_destek/pages/auth_page/auth_page.dart';
import 'package:deprem_destek/pages/demands_page/state/demands_cubit.dart';
import 'package:deprem_destek/pages/demands_page/widgets/demand_card.dart';
import 'package:deprem_destek/pages/my_demand_page/my_demand_page.dart';
import 'package:deprem_destek/shared/state/app_cubit.dart';
import 'package:deprem_destek/shared/widgets/loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DemandsPage extends StatelessWidget {
  const DemandsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLocation = context.read<AppCubit>().state.whenOrNull(
          loaded: (currentLocation, demandCategories) => currentLocation,
        );

    if (currentLocation == null) {
      return const Scaffold(body: Loader());
    }

    return BlocProvider<DemandsCubit>(
      create: (context) => DemandsCubit(
        demandsRepository: context.read<DemandsRepository>(),
        currentLocation: currentLocation.geometry!.location,
      ),
      child: StreamBuilder<User?>(
        stream: context.read<AuthRepository>().userStream,
        builder: (context, snapshot) {
          final authorized = snapshot.data != null;
          return _DemandsPageView(isAuthorized: authorized);
        },
      ),
    );
  }
}

class _DemandsPageView extends StatelessWidget {
  const _DemandsPageView({required this.isAuthorized});
  final bool isAuthorized;
  @override
  Widget build(BuildContext context) {
    final state = context.watch<DemandsCubit>().state;

    return state.status.when(
      loading: () => const Scaffold(body: Loader()),
      failure: () => const Text('todo failure page'),
      loaded: () {
        final demands = state.demands!;
        return Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              ListView.builder(
                itemCount: demands.length,
                itemBuilder: (context, index) {
                  final demand = demands[index];
                  return DemandCard(demand: demand);
                },
              ),
              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: ElevatedButton(
                  onPressed: !isAuthorized
                      ? () => AuthPage.show(context)
                      : () => MyDemandPage.show(context),
                  child: const Text(
                    'Destek Taleplerim',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

// class HomeView extends StatefulWidget {
//   const HomeView({super.key});

//   @override
//   State<HomeView> createState() => _HomeViewState();
// }

// class _HomeViewState extends State<HomeView> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<DemandsCubit>().initData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return body(context);
//   }

//   Widget body(BuildContext context) {
//     return BlocBuilder<DemandsCubit, DemandsState>(
//       builder: (context, state) {
//         return Scaffold(
//           body: state.when(
//             initial: () {
//               return Center(
//                 child: Text('Bekleniyor'),
//               );
//             },
//             loading: (isLoading) {
//               return Center(
//                 child: Column(
//                   children: [
//                     CircularProgressIndicator(
//                       backgroundColor: Colors.red,
//                       color: Colors.white,
//                     ),
//                     dialogWidget()
//                   ],
//                 ),
//               );
//             },
//             completed: (demands) {
//               return Stack(
//                 children: [
//                   Column(
//                     children: [
//                       addDemand(context),
//                       Expanded(
//                         child: demands.length < 5
//                             ? ListView(
//                                 children: [
//                                   HomeListCard(
//                                     talepNotlari: 'Deneme',
//                                     date: DateTime(2023),
//                                     il: 'Kahramanmaraş',
//                                     categories: ['Malzeme', 'Gıda'],
//                                   ),
//                                   HomeListCard(
//                                     talepNotlari: 'Deneme',
//                                     date: DateTime(2023),
//                                     il: 'Kahramamaraş',
//                                     categories: ['Malzeme', 'Gıda'],
//                                   ),
//                                   HomeListCard(
//                                     talepNotlari: 'Deneme',
//                                     date: DateTime(2023),
//                                     il: 'Kahramanmaraş',
//                                     categories: ['Malzeme', 'Gıda'],
//                                   )
//                                 ],
//                               )
//                             : ListView.builder(
//                                 itemBuilder: (context, index) {
//                                   var model = (demands[index] as Demand);
//                                   return HomeListCard(
//                                     categories: [],
//                                     talepNotlari: model.notes,
//                                     date: DateTime(2023),
//                                     il: 'Kahramanmaraş',
//                                   );
//                                 },
//                                 itemCount: demands.length,
//                               ),
//                       ),
//                     ],
//                   ),
//                   dialogWidget()
//                 ],
//               );
//             },
//             error: (message) {
//               return Center(
//                 child: Column(
//                   children: [Text('hata'), dialogWidget()],
//                 ),
//               );
//               //SnackBar(content: Text(message));
//             },
//           ),
//         );
//       },
//     );
//   }

//   Widget addDemand(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.all(15),
//       padding: const EdgeInsets.all(10),
//       width: MediaQuery.of(context).size.width,
//       decoration: BoxDecoration(
//         color: Color(0xffDC2626),
//         borderRadius: BorderRadius.circular(9),
//       ),
//       child: const Center(
//         child: Text(
//           'Talep Ekle',
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.w600,
//             color: Colors.white,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class dialogWidget extends StatelessWidget {
//   const dialogWidget({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<DialogCubit, DialogState>(
//       builder: (context, state) {
//         return context.watch<DialogCubit>().isDialog
//             ? Container(
//                 decoration: const BoxDecoration(),
//                 child: BackdropFilter(
//                   filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
//                   child: Center(
//                     child: Card(
//                       elevation: 10,
//                       color: Colors.white.withOpacity(0.1),
//                       child: SizedBox(
//                         child: SliderDialogPage(),
//                       ),
//                     ),
//                   ),
//                 ),
//               )
//             : const SizedBox();
//       },
//     );
//   }
// }
