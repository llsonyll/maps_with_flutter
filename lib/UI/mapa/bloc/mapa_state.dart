part of 'mapa_bloc.dart';

@immutable
class MapaState {
  MapaState({this.mapaListo = false});

  final bool mapaListo;

  MapaState copyWith({bool? mapaListo}) =>
      MapaState(mapaListo: mapaListo ?? this.mapaListo);
}
