import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/moto_provider.dart';
import 'page_seleccionar_moto.dart';

class MotoListPage extends StatefulWidget {
  const MotoListPage({super.key});

  @override
  State<MotoListPage> createState() => _MotoListPageState();
}

class _MotoListPageState extends State<MotoListPage> {
  Moto? _seleccionada;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final provider = context.read<MotoProvider>();
    _seleccionada ??= provider.motoSeleccionada;
  }

  void _irADetalle(BuildContext context) {
    final moto = _seleccionada;
    if (moto == null) return;
    context.read<MotoProvider>().seleccionarMoto(moto);
    Navigator.pushNamed(context, SelectedMotosPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MotoProvider>();
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Selecciona un modelo',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            DropdownButton<Moto>(
              value: _seleccionada,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(color: Colors.indigo),
              underline: Container(height: 2, color: Colors.indigo),
              onChanged: (moto) => setState(() => _seleccionada = moto),
              items: provider.motos
                  .map(
                    (moto) => DropdownMenuItem<Moto>(
                      value: moto,
                      child: Text(moto.marcaModelo),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 12),
            Text(
              _seleccionada != null
                  ? 'Seleccionada: ${_seleccionada!.marcaModelo}'
                  : 'Selecciona una moto',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _irADetalle(context),
              child: const Text('Calcular'),
            ),
          ],
        ),
      ),
    );
  }
}
