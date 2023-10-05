import 'package:flutter/material.dart';
import 'package:proyecto_grafos/algorithms/jhonson.dart';
import 'package:proyecto_grafos/algorithms/jhonson/jhonson2.dart';
import 'package:proyecto_grafos/algorithms/jhonson/jhonson_view.dart';
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
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(this.context).pop();
        },
      ),
      title: Text(
        'Graficador de Grafos - Los Iluminati',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w100,
          fontFamily: 'Roboto',
        ),
      ),
      backgroundColor: Colors.lightBlue.shade900,
      elevation: 5,
      actions: <Widget>[
        PopupMenuButton<String>(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Algoritmos',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          itemBuilder: (BuildContext context) {
            return {'Johnson', '2...', '3....'}.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
          onSelected: (String choice) {
            if (choice == 'Johnson') {
              // Llamar a la función calculoJhonson
              //calculoJhonson();
              List<int> sumas = johnsonAlgorithm(matrixArists);
              print(values);
              print(sumas);

              //lista de partidas:
              List<String> partidas = [];
              List<String> llegadas = [];
              for (int i = 0; i < matrixArists.length; i++) {
                for (int j = 0; j < matrixArists.length; j++) {
                  if (matrixArists[i][j] != 0) {
                    partidas.add(values[i]);
                  }
                }
              }

              for (int i = 0; i < matrixArists.length; i++) {
                for (int j = 0; j < matrixArists.length; j++) {
                  if (matrixArists[i][j] != 0) {
                    llegadas.add(values[j]);
                  }
                }
              }
              print(partidas);
              print(llegadas);

              //calculo de holguras:
              List<int> holguras = [];
              for (int i = 0; i < partidas.length; i++) {
                int pos = values.indexOf(partidas[i]);
                int pos2 = values.indexOf(llegadas[i]);
                int valor = sumas[pos2] - sumas[pos] - matrixArists[pos][pos2];
                if (valor > 0) {
                  holguras.add(valor);
                } else {
                  holguras.add(0);
                }
              }

              print(holguras);

              //creando matri de holguras:
              int cont = 0;
              //lista con el tamaño de matrixTrueFalse:
              matrizHolguras = [];
              for (int i = 0; i < matrixArists.length; i++) {
                List<int> list = [];
                for (int j = 0; j < matrixArists.length; j++) {
                  list.add(0);
                }
                matrizHolguras.add(list);
              }

              for (int i = 0; i < matrixArists.length; i++) {
                for (int j = 0; j < matrixArists.length; j++) {
                  if (matrixArists[i][j] != 0) {
                    matrizHolguras[i][j] = holguras[cont];
                    cont++;
                  } else {
                    matrizHolguras[i][j] = 0;
                  }
                }
              }

              print(matrixArists);
              String partida1 = "";
              for (int i = 0; i < partidas.length; i++) {
                if (!llegadas.contains(partidas[i])) {
                  partida1 = partidas[i];
                }
              }

              //buscar valor de llegadas que no esta en partidas:
              String llegada1 = "";
              for (int i = 0; i < llegadas.length; i++) {
                if (!partidas.contains(llegadas[i])) {
                  llegada1 = llegadas[i];
                }
              }

              longestPath =
      LongestPathAlgorithm.findLongestPath(matrixArists, values, partida1, llegada1);

              //redirigir:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => JhonsonView()));
            }
          },
        ),
      ],
    );
  }


}

class LongestPathAlgorithm {
  static List<String> findLongestPath(
      List<List<int>> adjMatrix, List<String> nodeNames, String startNode, String endNode) {
    int n = adjMatrix.length;
    int startIndex = nodeNames.indexOf(startNode);
    int endIndex = nodeNames.indexOf(endNode);

    if (startIndex == -1 || endIndex == -1) {
      // Verificar si los nodos iniciales y finales son válidos.
      return [];
    }

    // Inicializa la lista de distancias con valores mínimos (negativo infinito).
    List<double> dist = List.filled(n, double.negativeInfinity);
    List<int?> prev = List.filled(n, null);

    dist[startIndex] = 0;

    // Aplica el algoritmo de Bellman-Ford para encontrar las distancias más largas.
    for (int i = 0; i < n - 1; i++) {
      for (int u = 0; u < n; u++) {
        for (int v = 0; v < n; v++) {
          if (adjMatrix[u][v] > 0 && dist[u] + adjMatrix[u][v] > dist[v]) {
            dist[v] = dist[u] + adjMatrix[u][v];
            prev[v] = u;
          }
        }
      }
    }

    // Verifica si hay un ciclo de costo negativo.
    for (int u = 0; u < n; u++) {
      for (int v = 0; v < n; v++) {
        if (adjMatrix[u][v] > 0 && dist[u] + adjMatrix[u][v] > dist[v]) {
          // Hay un ciclo de costo negativo en el grafo, no podemos continuar.
          return [];
        }
      }
    }

    // Reconstruye el camino desde el nodo inicial al nodo final.
    List<String> longestPath = [];
    int? current = endIndex;

    while (current != null) {
      longestPath.add(nodeNames[current]);
      current = prev[current];
    }

    longestPath = longestPath.reversed.toList();

    if (longestPath[0] == startNode) {
      return longestPath;
    } else {
      // No se encontró un camino válido.
      return [];
    }
  }
}