import 'package:proyecto_grafos/matriz.dart';

import 'classes/modelo_arista.dart';
import 'classes/modelo_nodo.dart';
import 'data.dart';

// Define las clases ModeloNodo y ModeloArista aquí

Map<String, dynamic> generarEstructuraJson() {
  List vNodoJson = vNodo.map((nodo) => nodo.toJson()).toList();
  List vUnionesJson = vUniones.map((arista) => arista.toJson()).toList();

  Map<String, dynamic> estructuraJson = {
    'vNodo': vNodoJson,
    'vUniones': vUnionesJson,
    'values': values,
    'matrixTrueFalse': matrixTrueFalse,
    'matrixArists': matrixArists,
    'xinicial': xinicial,
    'xfinal': xfinal,
    'yinicial': yinicial,
    'yfinal': yfinal,
    'idInicial': idInicial,
    'joinModo': joinModo,
    'nodoInicial': nodoInicial.toJson(), // Convierte el nodoInicial a JSON
  };

  return estructuraJson;
}

