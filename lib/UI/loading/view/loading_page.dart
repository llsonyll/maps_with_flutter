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

class LoadingView extends StatefulWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  _LoadingViewState createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      if (await Geolocator.isLocationServiceEnabled()) {
        await Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const MapaPage()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Loading Page')),
      body: FutureBuilder(
        future: checkGPS(context),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
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
    await Future.delayed(const Duration(seconds: 2));

    final permisoGPS = await Permission.location.isGranted;
    final gpsActivo = await Geolocator.isLocationServiceEnabled();

    if (permisoGPS && gpsActivo) {
      await Navigator.pushReplacement(
          context, navegarMapaFadeIn(context, const MapaPage()));
      return '';
    } else if (!permisoGPS && gpsActivo) {
      await Navigator.pushReplacement(
          context, navegarMapaFadeIn(context, const AccesoGpsPage()));
      return 'Es necesario el permiso de GPS';
    } else if (permisoGPS && !gpsActivo) {
      return 'Active el GPS';
    }
  }
}
