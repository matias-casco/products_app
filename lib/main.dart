import 'package:flutter/material.dart';
import 'package:products_app/core/injector/injector.dart' as injector;
import 'package:products_app/core/router/app_router.dart';

void main() {

  injector.init();

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
