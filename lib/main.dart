import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';
import 'pages/page_seleccionar_moto.dart';
import 'providers/moto_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => MotoProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Motos',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const HomeScreen(),
      routes: {
        SelectedMotosPage.routeName: (_) => const SelectedMotosPage(),
      },
    );
  }
}
