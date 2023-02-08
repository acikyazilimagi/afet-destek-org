// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:ui' show ImageFilter;

import 'package:deprem_destek/data/models/demand.dart';
import 'package:deprem_destek/pages/demands_page/state/demands_cubit.dart';
import 'package:deprem_destek/pages/demands_page/state/dialog_cubit.dart';
import 'package:deprem_destek/pages/demands_page/widgets/home_demand_card.dart';
import 'package:deprem_destek/pages/demands_page/widgets/slider_dialog_page.dart';
import 'package:deprem_destek/pages/my_demand_page/my_demand_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: flaoatbutton(context),
      appBar: appBar(context),
      body: const HomeView(),
      bottomNavigationBar: bottomSheet(),
    );
  }

  Widget bottomSheet() {
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

  FloatingActionButton flaoatbutton(BuildContext context) {
    return FloatingActionButton.extended(
      elevation: 0,
      backgroundColor: const Color(0xffDC2626),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
      icon: const Icon(Icons.add),
      onPressed: () {
        MyDemandPage.show(context);
      },
      label: const Text('Talep Ekle'),
    );
  }

  AppBar appBar(BuildContext context) {
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
            context.read<DialogCubit>().changeDialog();
          },
          icon: const Icon(Icons.filter_list),
        )
      ],
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<DemandsCubit>().initData();
  }

  @override
  Widget build(BuildContext context) {
    return body(context);
  }

  Widget body(BuildContext context) {
    return BlocBuilder<DemandsCubit, DemandsState>(
      builder: (context, state) {
        return Scaffold(
          body: state.when(
            initial: () {
              return const Center(
                child: Text('Bekleniyor'),
              );
            },
            loading: (isLoading) {
              return Center(
                child: Column(
                  children: [
                    const CircularProgressIndicator(
                      backgroundColor: Colors.red,
                      color: Colors.white,
                    ),
                    const dialogWidget()
                  ],
                ),
              );
            },
            completed: (demands) {
              return Stack(
                children: [
                  Column(
                    children: [
                      addDemand(context),
                      Expanded(
                        child: demands.length < 5
                            ? ListView(
                                children: [
                                  HomeListCard(
                                    talepNotlari: 'Deneme',
                                    date: DateTime(2023),
                                    il: 'Kahramanmaraş',
                                    categories: ['Malzeme', 'Gıda'],
                                  ),
                                  HomeListCard(
                                    talepNotlari: 'Deneme',
                                    date: DateTime(2023),
                                    il: 'Kahramamaraş',
                                    categories: ['Malzeme', 'Gıda'],
                                  ),
                                  HomeListCard(
                                    talepNotlari: 'Deneme',
                                    date: DateTime(2023),
                                    il: 'Kahramanmaraş',
                                    categories: ['Malzeme', 'Gıda'],
                                  )
                                ],
                              )
                            : ListView.builder(
                                itemBuilder: (context, index) {
                                  final model = demands[index] as Demand;
                                  return HomeListCard(
                                    categories: [],
                                    talepNotlari: model.notes,
                                    date: DateTime(2023),
                                    il: 'Kahramanmaraş',
                                  );
                                },
                                itemCount: demands.length,
                              ),
                      ),
                    ],
                  ),
                  const dialogWidget()
                ],
              );
            },
            error: (message) {
              return Center(
                child: Column(
                  children: [const Text('hata'), const dialogWidget()],
                ),
              );
              //SnackBar(content: Text(message));
            },
          ),
        );
      },
    );
  }

  Widget addDemand(BuildContext context) {
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
}

class dialogWidget extends StatelessWidget {
  const dialogWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DialogCubit, DialogState>(
      builder: (context, state) {
        return context.watch<DialogCubit>().isDialog
            ? Container(
                decoration: const BoxDecoration(),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Center(
                    child: Card(
                      elevation: 10,
                      color: Colors.white.withOpacity(0.1),
                      child: const SizedBox(
                        child: SliderDialogPage(),
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox();
      },
    );
  }
}
