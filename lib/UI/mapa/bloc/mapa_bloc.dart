import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:counter/themes/uber_map_theme.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'mapa_event.dart';
part 'mapa_state.dart';

class MapaBloc extends Bloc<MapaEvent, MapaState> {
  MapaBloc() : super(MapaState());

  GoogleMapController? _mapController;

  void inicializarMapa(GoogleMapController controller) {
    if (state.mapaListo) {
      _mapController = controller;
      _mapController?.setMapStyle(jsonEncode(uberMapTheme));

      add(OnMapaLoaded());
    }
  }

  @override
  Stream<MapaState> mapEventToState(
    MapaEvent event,
  ) async* {
    if (event is OnMapaLoaded) {
      print('mapa listo');
      yield state.copyWith(mapaListo: true);
    }
  }
}
