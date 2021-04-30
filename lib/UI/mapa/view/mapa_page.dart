import 'package:counter/UI/mapa/bloc/miubicacion_bloc.dart';
import 'package:counter/UI/mapa/mapa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaPage extends StatefulWidget {
  const MapaPage({Key? key}) : super(key: key);

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  @override
  void initState() {
    context.read<MiUbicacionBloc>().iniciarSeguimiento();
    super.initState();
  }

  @override
  void dispose() {
    context.read<MiUbicacionBloc>().detenerSeguimiento();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
        builder: (context, state) => MapaContenido(state: state),
      ),
    );
  }
}

class MapaContenido extends StatelessWidget {
  const MapaContenido({Key? key, required this.state}) : super(key: key);

  final MiUbicacionState state;

  @override
  Widget build(BuildContext context) {
    var cusco = const LatLng(-13.526462, -71.949989);
    final blocMapa = context.read<MapaBloc>();
    if (state.existeUbicacion) {
      return GoogleMap(
        initialCameraPosition: CameraPosition(
          target: state.ubicacion ?? cusco,
          zoom: 15.0,
        ),
        // mapType: MapType.hybrid,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        onMapCreated: blocMapa.inicializarMapa,
      );
    } else {
      return const Center(child: Text('Ubicando...'));
    }
  }
}
