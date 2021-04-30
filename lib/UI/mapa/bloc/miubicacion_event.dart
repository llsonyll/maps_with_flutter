part of 'miubicacion_bloc.dart';

@immutable
abstract class MiUbicacionEvent {}

class OnUbicationChange extends MiUbicacionEvent {
  OnUbicationChange({required this.ubicacion});

  final LatLng ubicacion;
}
