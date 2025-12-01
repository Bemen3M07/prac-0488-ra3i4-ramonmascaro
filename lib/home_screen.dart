import 'package:flutter/material.dart';

import 'pages/page_lista_moto.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Motos App')),
      body: const MotoListPage(),
    );
  }
}
