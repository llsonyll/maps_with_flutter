import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:meta/meta.dart';

part 'miubicacion_event.dart';
part 'miubicacion_state.dart';

class MiUbicacionBloc extends Bloc<MiUbicacionEvent, MiUbicacionState> {
  MiUbicacionBloc() : super(const MiUbicacionState());

  StreamSubscription<Position>? positionSubscription;

  void iniciarSeguimiento() {
    // final geoLocatorOptions = const LocationOptions(
    //   accuracy: LocationAccuracy.high,
    //   distanceFilter: 10,
    // );
    positionSubscription = Geolocator.getPositionStream(
      desiredAccuracy: LocationAccuracy.high,
      distanceFilter: 10,
    ).listen((position) async {
      final nuevaUbicacion = LatLng(position.latitude, position.longitude);
      add(OnUbicationChange(ubicacion: nuevaUbicacion));
    });
  }

  void detenerSeguimiento() {
    positionSubscription?.cancel();
  }

  @override
  Stream<MiUbicacionState> mapEventToState(
    MiUbicacionEvent event,
  ) async* {
    if (event is OnUbicationChange) {
      yield state.copyWith(
        existeUbicacion: true,
        ubicacion: event.ubicacion,
      );
    }
  }
}
