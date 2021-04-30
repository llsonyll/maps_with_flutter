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

class AccesoGpsView extends StatefulWidget {
  @override
  _AccesoGpsViewState createState() => _AccesoGpsViewState();
}

// ignore: lines_longer_than_80_chars
class _AccesoGpsViewState extends State<AccesoGpsView>
    with WidgetsBindingObserver {
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
    print(state);
    if (state == AppLifecycleState.resumed) {
      if (await Permission.location.isGranted) {
        await Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const MapaPage()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Geolocalizacion',
            style: TextStyle(fontSize: 21.0, color: Colors.black),
          ),
          centerTitle: true),
      body: Center(
        child: Column(
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
        ),
      ),
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
        openAppSettings();
        break;
      default:
    }
  }
}
