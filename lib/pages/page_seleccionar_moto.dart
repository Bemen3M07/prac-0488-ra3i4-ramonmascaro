import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/moto_provider.dart';

class SelectedMotosPage extends StatefulWidget {
  const SelectedMotosPage({super.key});

  static const routeName = '/detalle';

  @override
  State<SelectedMotosPage> createState() => _SelectedMotosPageState();
}

class _SelectedMotosPageState extends State<SelectedMotosPage> {
  final _kmLlenadoCtrl = TextEditingController();
  final _kmActualCtrl = TextEditingController();
  int? _restantes;
  String? _error;

  @override
  void dispose() {
    _kmLlenadoCtrl.dispose();
    _kmActualCtrl.dispose();
    super.dispose();
  }

  void _calcular(Moto moto) {
    final kmLlenado = int.tryParse(_kmLlenadoCtrl.text.trim());
    final kmActual = int.tryParse(_kmActualCtrl.text.trim());
    if (kmLlenado == null || kmActual == null) {
      setState(() {
        _error = 'Numeros no validos';
        _restantes = null;
      });
      return;
    }
    final consumidos = kmActual - kmLlenado;
    if (consumidos < 0) {
      setState(() {
        _error = 'Los km actuales no pueden ser menores a los anteriores.';
        _restantes = null;
      });
      return;
    }

    final autonomiaEstim = (moto.fuelTankLiters / moto.consumptionL100) * 100;
    final restantes = autonomiaEstim - consumidos;
    setState(() {
      _error = null;
      _restantes = restantes < 0 ? 0 : restantes.floor();
    });
  }

  @override
  Widget build(BuildContext context) {
    final moto = context.watch<MotoProvider>().motoSeleccionada;

    if (moto == null) {
      return const Scaffold(
        body: Center(child: Text('Selecciona una moto en la pantalla anterior')),
      );
    }

    final imagePath = 'assets/img/${moto.marcaModelo}.png';

    return Scaffold(
      appBar: AppBar(title: const Text('Info moto')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        moto.marcaModelo,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text('Deposito: ${moto.fuelTankLiters.toStringAsFixed(1)} L'),
                      Text('Consumo: ${moto.consumptionL100.toStringAsFixed(1)} L/100km'),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        imagePath,
                        height: 170,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Km al llenar deposito:'),
                const SizedBox(width: 8),
                SizedBox(
                  width: 140,
                  child: TextField(
                    controller: _kmLlenadoCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (_) => _calcular(moto),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Km actuales:'),
                const SizedBox(width: 8),
                SizedBox(
                  width: 140,
                  child: TextField(
                    controller: _kmActualCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (_) => _calcular(moto),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (_error != null) Text(_error!),
            if (_restantes != null)
              Text(
                'Te quedan $_restantes km.',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
          ],
        ),
      ),
    );
  }
}
