part of 'miubicacion_bloc.dart';

@immutable
class MiUbicacionState {
  const MiUbicacionState({
    this.siguiendo = false,
    this.existeUbicacion = true,
    this.ubicacion,
  });

// Siguiendo al usuario
  final bool siguiendo;
  // Existe ultima ubicacion?
  final bool existeUbicacion;
  // Coordenadas de ubicacion
  final LatLng? ubicacion;

  MiUbicacionState copyWith({
    bool? siguiendo,
    bool? existeUbicacion,
    LatLng? ubicacion,
  }) =>
      MiUbicacionState(
        siguiendo: siguiendo ?? this.siguiendo,
        existeUbicacion: existeUbicacion ?? this.existeUbicacion,
        ubicacion: ubicacion ?? this.ubicacion,
      );
}
