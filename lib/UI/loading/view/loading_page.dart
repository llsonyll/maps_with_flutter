import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../acceso_gps/view/acceso_gps_page.dart';
import '../../helpers.dart';
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
        builder: (_, AsyncSnapshot snapshot) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Future checkGPS(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));
    // ignore: lines_longer_than_80_chars
    await Navigator.pushReplacement(
        context, navegarMapaFadeIn(context, const AccesoGpsPage()));
  }
}
