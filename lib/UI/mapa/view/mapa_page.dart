import 'package:counter/UI/mapa/bloc/miubicacion_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      appBar: AppBar(
        title: const Text('Mapa'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Ubicacion',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
            BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
              builder: (context, state) => MapaContenido(state: state),
            ),
          ],
        ),
      ),
    );
  }
}

class MapaContenido extends StatelessWidget {
  const MapaContenido({Key? key, required this.state}) : super(key: key);

  final MiUbicacionState state;

  @override
  Widget build(BuildContext context) {
    if (state.existeUbicacion) {
      return Column(
        children: [
          Text('Latitud : ${state.ubicacion?.latitude}'),
          Text('Longitud : ${state.ubicacion?.longitude}'),
        ],
      );
    } else {
      return const Text('Ubicando...');
    }
  }
}
