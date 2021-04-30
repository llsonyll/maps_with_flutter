import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../acceso_gps/view/acceso_gps_page.dart';
import '../../helpers.dart';
import '../../mapa/mapa.dart';
import '../cubit/loading_cubit.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoadingCubit(),
      child: const LoadingView(),
    );
  }
}

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkGPS(context),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Center(child: Text(snapshot.data));
          } else {
            return const Center(
              child: CircularProgressIndicator(strokeWidth: 2.0),
            );
          }
        },
      ),
    );
  }

  Future checkGPS(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 1000));

    final permisoGPS = await Permission.location.isGranted;
    final gpsActivo = await Geolocator.isLocationServiceEnabled();

    if (permisoGPS && gpsActivo) {
      await Navigator.pushReplacement(
          context, navegarMapaFadeIn(context, const MapaPage()));
      return '';
    } else if (!permisoGPS) {
      await Navigator.pushReplacement(
          context, navegarMapaFadeIn(context, const AccesoGpsPage()));
      return 'Es necesario el permiso de GPS';
    } else if (!gpsActivo) {
      return 'Active el GPS';
    }
  }
}
