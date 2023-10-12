import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:proyecto_grafos/algorithms/asignaci%C3%B3n/algoritmo_asignacion.dart';
import 'package:proyecto_grafos/algorithms/asignaci%C3%B3n/algoritmo_asignacion_min.dart';
import 'package:proyecto_grafos/matriz.dart';
import 'package:http/http.dart' as http;

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext context;

  CustomAppBar({required this.context});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(this.context).pop();
        },
      ),
      title: const Text(
        'Graficador de Grafos - Algoritmo de Asignación',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w100,
          fontFamily: 'Roboto',
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 7, 91, 22),
      elevation: 5,
      actions: <Widget>[
        PopupMenuButton<String>(
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Calcular Asignacion',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          itemBuilder: (BuildContext context) {
            return {'Maximizar', 'Minimizar'}.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
          onSelected: (String choice) async {
            if (choice == 'Maximizar') {
              print(matrixArists);
              print(values);

              List<String> origenes = [];
              List<String> llegadas = [];

              for (int i = 0; i < matrixArists[0].length; i++) {
                if (i < matrixArists[0].length / 2) {
                  origenes.add(values[i]);
                } else {
                  llegadas.add(values[i]);
                }
              }

              print("orgienes: $origenes");
              print("llegadas: $llegadas");

              List<List<String>> asignaciones = [];

              void generarAsignaciones(List<String> asignacionParcial) {
                if (asignacionParcial.length == origenes.length) {
                  asignaciones.add(List.from(asignacionParcial));
                  return;
                }

                for (int i = 0; i < llegadas.length; i++) {
                  if (!asignacionParcial.contains(llegadas[i])) {
                    asignacionParcial.add(llegadas[i]);
                    generarAsignaciones(asignacionParcial);
                    asignacionParcial.removeLast();
                  }
                }
              }

              generarAsignaciones([]);
              print(asignaciones); //matriz de llegadas

              int suma = -1;
              int opcion_maxima = -1;

              for (int i = 0; i < asignaciones.length; i++) {
                int suma_parcial = 0;
                for (int j = 0; j < asignaciones[i].length; j++) {
                  int pos1 = values.indexOf(origenes[j]);
                  int pos2 = values.indexOf(asignaciones[i][j]);
                  print("pos1: $pos1");
                  print("pos1: $pos2");
                  suma_parcial = suma_parcial + matrixArists[pos1][pos2];
                  print("suma_p: $suma_parcial");
                }
                if (suma_parcial > suma) {
                  suma = suma_parcial;
                  opcion_maxima = i;
                }
              }

              print("suma: $suma");
              print("opcion minima: ${asignaciones[opcion_maxima]}");

              //mostrando resultado en un pop up:
              showDialog(
  context: context,
  builder: (BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Asignación Óptima Maxima',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green
                  ),
                ),
                SizedBox(height: 16),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: origenes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text('Origen: ${origenes[index]}'),
                      subtitle: Text('Destino: ${asignaciones[opcion_maxima][index]}'),
                    );
                  },
                ),
                SizedBox(height: 16),
                Text(
                  'Sumatoria máxima: $suma',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Center(
                  child: TextButton(
                    child: Text(
                      'Cerrar',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  },
);


            }

            if (choice == 'Minimizar') {
              print(matrixArists);
              print(values);

              List<String> origenes = [];
              List<String> llegadas = [];

              for (int i = 0; i < matrixArists[0].length; i++) {
                if (i < matrixArists[0].length / 2) {
                  origenes.add(values[i]);
                } else {
                  llegadas.add(values[i]);
                }
              }

              print("orgienes: $origenes");
              print("llegadas: $llegadas");

              List<List<String>> asignaciones = [];

              void generarAsignaciones(List<String> asignacionParcial) {
                if (asignacionParcial.length == origenes.length) {
                  asignaciones.add(List.from(asignacionParcial));
                  return;
                }

                for (int i = 0; i < llegadas.length; i++) {
                  if (!asignacionParcial.contains(llegadas[i])) {
                    asignacionParcial.add(llegadas[i]);
                    generarAsignaciones(asignacionParcial);
                    asignacionParcial.removeLast();
                  }
                }
              }

              generarAsignaciones([]);
              print(asignaciones); //matriz de llegadas

              int suma = 99999999;
              int opcion_minima = -1;

              for (int i = 0; i < asignaciones.length; i++) {
                int suma_parcial = 0;
                for (int j = 0; j < asignaciones[i].length; j++) {
                  int pos1 = values.indexOf(origenes[j]);
                  int pos2 = values.indexOf(asignaciones[i][j]);
                  print("pos1: $pos1");
                  print("pos1: $pos2");
                  suma_parcial = suma_parcial + matrixArists[pos1][pos2];
                  print("suma_p: $suma_parcial");
                }
                if (suma_parcial < suma) {
                  suma = suma_parcial;
                  opcion_minima = i;
                }
              }

              print("suma: $suma");
              print("opcion minima: ${asignaciones[opcion_minima]}");

              //mostrando resultado en un pop up:
              showDialog(
  context: context,
  builder: (BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              
              children: [
                Text(
                  'Asignación Óptima',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green
                  ),
                ),
                SizedBox(height: 16),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: origenes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text('Origen: ${origenes[index]}'),
                      subtitle: Text('Destino: ${asignaciones[opcion_minima][index]}'),
                    );
                  },
                ),
                SizedBox(height: 16),
                Text(
                  'Sumatoria mínima: $suma',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Center(
                  child: TextButton(
                    child: Text(
                      'Cerrar',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  },
);


            }
          },
        ),
      ],
    );
  }
}

List<dynamic> calcularAsignacionOptima2() {
  List<List<String>> matrizAdyacencia = [];
  List<List<int>> matrizAdyacenciaInt = matrixArists;
  List<int> asignacion = hungarianAlgorithm2(matrixArists);

  List<String> fila = [' '];
  for (int i = 0; i < values.length; i++) {
    fila.add(values[i]);
  }

  matrizAdyacencia.add(fila);

  for (int i = 0; i < matrixArists.length; i++) {
    List<String> fila2 = [values[i]];
    for (int j = 0; j < matrixArists[i].length; j++) {
      fila2.add(matrixArists[i][j].toString());
    }
    matrizAdyacencia.add(fila2);
  }

  List<List<String>> noms = [];
  int sumatoria = 0;
  List<int> destinosAsignados = List.filled(matrixArists[0].length, -1);

  for (int i = 1; i < matrizAdyacencia.length; i++) {
    int origenIndex = i - 1;
    int destinoIndex = asignacion[origenIndex];

    if (destinoIndex != -1) {
      // Verificar si el destino ya está asignado a otro origen óptimo
      if (destinosAsignados[destinoIndex] != -1) {
        int suboptimo = encontrarSuboptimo(
            matrixArists, destinoIndex, destinosAsignados[destinoIndex]);
        if (suboptimo != -1) {
          noms.add([
            matrizAdyacencia[0][destinosAsignados[destinoIndex] + 1],
            matrizAdyacencia[0][destinoIndex + 1]
          ]);
          sumatoria += matrizAdyacenciaInt[destinosAsignados[destinoIndex]]
              [destinoIndex];
          destinosAsignados[destinoIndex] =
              -1; // Liberar el destino para asignación subóptima
          destinoIndex = suboptimo;
        }
      }

      noms.add([
        matrizAdyacencia[0][origenIndex + 1],
        matrizAdyacencia[0][destinoIndex + 1]
      ]);
      sumatoria += matrizAdyacenciaInt[origenIndex][destinoIndex];
      destinosAsignados[destinoIndex] = origenIndex;
    }
  }

  return [sumatoria, noms];
}

int encontrarSuboptimo(List<List<int>> matrix, int destino, int origenOptimo) {
  int suboptimo = -1;
  int minDiferencia = 99999999;

  for (int i = 0; i < matrix.length; i++) {
    if (i != origenOptimo && matrix[i][destino] < minDiferencia) {
      suboptimo = i;
      minDiferencia = matrix[i][destino];
    }
  }
  return suboptimo;
}

//MINIMIZACION:

List<dynamic> calcularAsignacionOptima() {
  List<List<String>> matrizAdyacencia = [];
  List<List<int>> matrizAdyacenciaInt = matrixArists;
  List<int> asignacion = hungarianAlgorithm(matrixArists);

  List<String> fila = [' '];
  for (int i = 0; i < values.length; i++) {
    fila.add(values[i]);
  }

  matrizAdyacencia.add(fila);

  for (int i = 0; i < matrixArists.length; i++) {
    List<String> fila2 = [values[i]];
    for (int j = 0; j < matrixArists[i].length; j++) {
      fila2.add(matrixArists[i][j].toString());
    }
    matrizAdyacencia.add(fila2);
  }

  List<List<String>> noms = [];
  int sumatoria = 0;
  List<int> destinosAsignados = List.filled(matrixArists[0].length, -1);

  for (int i = 1; i < matrizAdyacencia.length; i++) {
    int origenIndex = i - 1;
    int destinoIndex = asignacion[origenIndex];

    if (destinoIndex != -1) {
      // Verificar si el destino ya está asignado a otro origen óptimo
      if (destinosAsignados[destinoIndex] != -1) {
        int suboptimo = encontrarSuboptimo2(
            matrixArists, destinoIndex, destinosAsignados[destinoIndex]);
        if (suboptimo != -1) {
          noms.add([
            matrizAdyacencia[0][destinosAsignados[destinoIndex] + 1],
            matrizAdyacencia[0][destinoIndex + 1]
          ]);
          sumatoria += matrizAdyacenciaInt[destinosAsignados[destinoIndex]]
              [destinoIndex];
          destinosAsignados[destinoIndex] =
              -1; // Liberar el destino para asignación subóptima
          destinoIndex = suboptimo;
        }
      }

      noms.add([
        matrizAdyacencia[0][origenIndex + 1],
        matrizAdyacencia[0][destinoIndex + 1]
      ]);
      sumatoria += matrizAdyacenciaInt[origenIndex][destinoIndex];
      destinosAsignados[destinoIndex] = origenIndex;
    }
  }

  return [sumatoria, noms];
}

int encontrarSuboptimo2(List<List<int>> matrix, int destino, int origenOptimo) {
  int suboptimo = -1;
  int minDiferencia = -1;

  for (int i = 0; i < matrix.length; i++) {
    if (i != origenOptimo && matrix[i][destino] < minDiferencia) {
      suboptimo = i;
      minDiferencia = matrix[i][destino];
    }
  }
  return suboptimo;
}

//import 'dart:math';
