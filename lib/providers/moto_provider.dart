import 'package:flutter/foundation.dart';

class Moto {
  final String marcaModelo;
  final double fuelTankLiters;
  final double consumptionL100;

  Moto({
    required this.marcaModelo,
    required this.fuelTankLiters,
    required this.consumptionL100,
  });
}

class MotoProvider extends ChangeNotifier {
  final List<Moto> listaMotos = [
    Moto(marcaModelo: 'Honda PCX 125', fuelTankLiters: 8.0, consumptionL100: 2.1),
    Moto(marcaModelo: 'Yamaha NMAX 125', fuelTankLiters: 7.1, consumptionL100: 2.2),
    Moto(marcaModelo: 'Kymco Agility City 125', fuelTankLiters: 7.0, consumptionL100: 2.5),
    Moto(marcaModelo: 'Piaggio Liberty 125', fuelTankLiters: 6.0, consumptionL100: 2.3),
    Moto(marcaModelo: 'Sym Symphony 125', fuelTankLiters: 5.5, consumptionL100: 2.4),
    Moto(marcaModelo: 'Vespa Primavera 125', fuelTankLiters: 8.0, consumptionL100: 2.8),
    Moto(marcaModelo: 'Kawasaki J125', fuelTankLiters: 11.0, consumptionL100: 3.5),
    Moto(marcaModelo: 'Peugeot Pulsion 125', fuelTankLiters: 12.0, consumptionL100: 3.0),
  ];

  Moto? _motoSeleccionada;

  List<Moto> get motos => List.unmodifiable(listaMotos);
  Moto? get motoSeleccionada =>
      _motoSeleccionada ?? (listaMotos.isNotEmpty ? listaMotos.first : null);

  void seleccionarMoto(Moto moto) {
    _motoSeleccionada = moto;
    notifyListeners();
  }
}


