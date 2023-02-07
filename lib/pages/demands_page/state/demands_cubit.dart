import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deprem_destek/data/models/demand_category.dart';
import 'package:deprem_destek/data/repository/auth_repository.dart';
import 'package:deprem_destek/data/repository/location_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_geocoding_api/google_geocoding_api.dart';

import '../../../data/models/demand.dart';
import '../../../data/repository/demands_repository.dart';

part 'demands_state.dart';
part 'demands_cubit.freezed.dart';

class DemandsCubit extends Cubit<DemandsState> {
  DemandsCubit(
      {required this.demandsRepository,
      required this.locationRepository,
      required this.authRepository})
      : super(DemandsState.initial());

  DemandsRepository demandsRepository;
  LocationRepository locationRepository;
  AuthRepository authRepository;

  bool isLoading = false;
  bool isBlure = false;
  dynamic model;
  List<String> categoryUid = [];
  late List<Demand> demands;

  var isDialogOpen = false;
  


  void changeLoading() {
    isLoading = !isLoading;

    emit(DemandsState.loading(isLoading));
  }

  Future<void> initData() async {
    try {
      changeLoading();
      
      //   await Future.delayed(Duration(seconds: 3));

      //TODO: Service code in here

      var googleGeocodingResult = await locationRepository.getLocation();

      var categories = await demandsRepository.getDemandCategories();

      for (final element in categories) {
        categoryUid.add(element.id);
        print(categoryUid);
      }

      var currentLocation = googleGeocodingResult.geometry?.location;
      if (currentLocation == null) {
        emit(const DemandsState.error("Konum bulunamamktadır"));
      }

      demands = await demandsRepository.getDemands(
          page: 1,
          radius: 1,
          categoryIds: categoryUid,
          geo: googleGeocodingResult.geometry?.location );

      changeLoading();

      print(demands);
      emit(DemandsState.completed(demands));
    } catch (e) {
      emit(DemandsState.error(e.toString()));
    }
  }

  void changeBlure() {
    isBlure = !isBlure;
  }
}
