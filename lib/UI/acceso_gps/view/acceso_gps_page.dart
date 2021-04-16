import 'package:counter/UI/mapa/mapa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../UI/acceso_gps/cubit/acceso_gps_cubit.dart';
import '../../helpers.dart';

class AccesoGpsPage extends StatelessWidget {
  const AccesoGpsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AccesoGpsCubit(),
      child: AccesoGpsView(),
    );
  }
}

class AccesoGpsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Geolocalizacion',
            style: TextStyle(fontSize: 21.0, color: Colors.black),
          ),
          centerTitle: true),
      body: const Center(child: MainContent()),
    );
  }
}

class MainContent extends StatelessWidget {
  const MainContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Se requiere permisos de geolocalizacion'),
        const SizedBox(height: 10.0),
        ElevatedButton(
          onPressed: () async {
            final status = await Permission.location.request();
            accessGpsHandle(status, context);
          },
          child: const Text('Solicitar Acceso'),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
          ),
        ),
      ],
    );
  }

  void accessGpsHandle(PermissionStatus state, BuildContext context) {
    switch (state) {
      case PermissionStatus.granted:
        Navigator.of(context)
            // ignore: lines_longer_than_80_chars
            .push(navegarMapaFadeIn(context, const MapaPage()));
        break;
      case PermissionStatus.denied:
        break;
      case PermissionStatus.restricted:
        break;
      case PermissionStatus.permanentlyDenied:
        break;
      default:
    }
  }
}
