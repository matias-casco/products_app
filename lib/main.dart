import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:products_app/core/blocs/check_ethernet/check_ethernet_bloc.dart';
import 'package:products_app/core/injector/injector.dart' as injector;
import 'package:products_app/core/router/app_router.dart';

void main() {
  injector.init();

  runApp(
    BlocProvider(
      create: (context) => CheckEthernetBloc(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.amber[800]!,
        primary: Colors.amber,
        secondary: Colors.purple,
        tertiary: Colors.green,
      )),
    );
  }
}
