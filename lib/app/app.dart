import 'package:counter/UI/loading/loading.dart';
import 'package:counter/UI/mapa/bloc/miubicacion_bloc.dart';
import 'package:counter/UI/mapa/mapa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:counter/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MiUbicacionBloc()),
        BlocProvider(create: (context) => MapaBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          accentColor: const Color(0xFF13B9FF),
          appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
        ),
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: const LoadingPage(),
      ),
    );
  }
}
