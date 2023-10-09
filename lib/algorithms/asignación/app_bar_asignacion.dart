import 'package:flutter/material.dart';
import 'package:proyecto_grafos/algorithms/asignaci%C3%B3n/algoritmo_asignacion.dart';
import 'package:proyecto_grafos/algorithms/asignaci%C3%B3n/algoritmo_asignacion_min.dart';
import 'package:proyecto_grafos/matriz.dart';

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
          onSelected: (String choice) {
            if (choice == 'Maximizar') {
              List<dynamic> ans = calcularAsignacionOptima2();
              List<List<bool>> calculos = [];
              for (int i = 0; i < matrixArists.length; i++) {
                List<bool> fila = [];
                for (int j = 0; j < matrixArists[i].length; j++) {
                  fila.add(false);
                }
                calculos.add(fila);
              }
              //recorriendo la lista ans:
              for (int i = 0; i < ans[1].length; i++) {
                //recorriendo la lista ans:
                String origen = ans[1][i][0];
                String llegada = ans[1][i][1];
                int pos1 = values.indexOf(origen);
                int pos2 = values.indexOf(llegada);
                calculos[pos1][pos2] = true;
              }

              //calcular sumatoria:
              int sumatoria = 0;
              for (int i = 0; i < matrixArists.length; i++) {
                for (int j = 0; j < matrixArists[i].length; j++) {
                  if (calculos[i][j] == true) {
                    sumatoria += matrixArists[i][j];
                  }
                }
              }

              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Resultado de Asignación para MAXIMIZAR'),
                    content: Container(
                      width: double.minPositive,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Asignaciones:',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: calculos.length,
                              itemBuilder: (context, i) {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: calculos[i].length,
                                  itemBuilder: (context, j) {
                                    if (calculos[i][j]) {
                                      return Card(
                                        elevation: 3,
                                        color: const Color.fromARGB(
                                            255, 239, 252, 239),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Ruta: ${values[i]} - > ${values[j]}',
                                                style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 33, 97, 35),
                                                  fontSize: 16,
                                                ),
                                              ),

                                              Text(
                                                'Costo: ${matrixArists[i][j]}',
                                                style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 33, 97, 35),
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    } else {
                                      return const SizedBox();
                                    }
                                  },
                                );
                              },
                            ),
                            const SizedBox(height: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Sumatoria: $sumatoria',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cerrar'),
                      ),
                    ],
                  );
                },
              );

            }
            if (choice == 'Minimizar') {
              List<dynamic> ans = calcularAsignacionOptima();
              List<List<bool>> calculos = [];
              for (int i = 0; i < matrixArists.length; i++) {
                List<bool> fila = [];
                for (int j = 0; j < matrixArists[i].length; j++) {
                  fila.add(false);
                }
                calculos.add(fila);
              }
              //recorriendo la lista ans:
              for (int i = 0; i < ans[1].length; i++) {
                //recorriendo la lista ans:
                String origen = ans[1][i][0];
                String llegada = ans[1][i][1];
                int pos1 = values.indexOf(origen);
                int pos2 = values.indexOf(llegada);
                calculos[pos1][pos2] = true;
              }

              //calcular sumatoria:
              int sumatoria = 0;
              for (int i = 0; i < matrixArists.length; i++) {
                for (int j = 0; j < matrixArists[i].length; j++) {
                  if (calculos[i][j] == true) {
                    sumatoria += matrixArists[i][j];
                  }
                }
              }

              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Resultado de Asignación para MINIMIZAR'),
                    content: Container(
                      width: double.minPositive,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Asignaciones:',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: calculos.length,
                              itemBuilder: (context, i) {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: calculos[i].length,
                                  itemBuilder: (context, j) {
                                    if (calculos[i][j]) {
                                      return Card(
                                        elevation: 3,
                                        color: Color.fromARGB(255, 239, 239, 252),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Ruta: ${values[i]} - > ${values[j]}',
                                                style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 33, 97, 35),
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text(
                                                'Costo: ${matrixArists[i][j]}',
                                                style: const TextStyle(
                                                    color: Color.fromARGB(255, 33, 63, 97),
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    } else {
                                      return const SizedBox();
                                    }
                                  },
                                );
                              },
                            ),
                            const SizedBox(height: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Sumatoria: $sumatoria',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cerrar'),
                      ),
                    ],
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

List<int> hungarianAlgorithm(List<List<int>> matrix) {
  print(matrix);
  List<int> result = [];
  for (int i = 0; i < matrix.length; i++) {
    if (todoCero(matrix[i])) {
      result.add(-1);
    } else {
      result.add(posMenor(matrix[i]));
    }
  }

  return result;
}

bool todoCero(List<int> fila) {
  for (int i = 0; i < fila.length; i++) {
    if (fila[i] != 0) {
      return false;
    }
  }
  return true;
}

int posMenor(List<int> fila) {
  int m = 100000000000000;
  for (int i = 0; i < fila.length; i++) {
    if (fila[i] < m && fila[i] != 0) {
      m = fila[i];
    }
  }
  return fila.indexOf(m);
}
