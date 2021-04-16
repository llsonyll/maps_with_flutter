import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../mapa.dart';

class MapaPage extends StatelessWidget {
  const MapaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MapaCubit(),
      child: const MapaView(),
    );
  }
}

class MapaView extends StatelessWidget {
  const MapaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa'),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
