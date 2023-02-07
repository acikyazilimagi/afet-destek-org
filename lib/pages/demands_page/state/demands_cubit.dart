import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deprem_destek/data/models/demand.dart';
import 'package:deprem_destek/data/repository/demands_repository.dart';
import 'package:deprem_destek/data/repository/location_repository.dart';
import 'package:meta/meta.dart';

part 'demands_state.dart';

class DemandsCubit extends Cubit<DemandsState> {
  DemandsCubit(this.locationRepository, this.demandsRepository)
      : super(const DemandsState());

  final LocationRepository locationRepository;
  final DemandsRepository demandsRepository;

  Future<void> getDemands() async {
    final position = await locationRepository.getLocation();
    final location = position.geometry?.location;
    if (location != null) {
      final demands = await demandsRepository.getDemands(
        geo: GeoPoint(location.lat, location.lng),
        radius: 1,
        categoryUUIDs: [],
        page: 1,
      );
      emit(state.copyWith(demands: demands));
    }
  }
}
