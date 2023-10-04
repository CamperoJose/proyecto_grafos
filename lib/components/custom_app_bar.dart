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

              print(matrizHolguras);
              //redirigir:
              Navigator.push(context,
                      MaterialPageRoute(builder: (context) => JhonsonView()));
            }
          },
        ),
      ],
    );
  }

  calculoJhonson() {
    print("llegajhonson1");
    String sumaAlgor = "";
    List<List<String>> matrizAdyacencia = [];
    //matrizAdyacencia = generaMatriz(matrizAdyacencia);
    //teniendo matriz arists se crea una nueva matrixz de adyacencia pero con string:

    print("llegajhonson2");

    //agregando values a la primera fila:
    List<String> values2 = [
      " ",
    ];
    for (int i = 0; i < values.length; i++) {
      values2.add(values[i]);
    }

    matrizAdyacencia.add(values2);

    for (int i = 0; i < matrixArists.length; i++) {
      List<String> list = [values[i]];
      for (int j = 0; j < matrixArists.length; j++) {
        if (matrixArists[i][j] == 0) {
          list.add("0");
        } else {
          list.add(matrixArists[i][j].toString());
        }
      }

      matrizAdyacencia.add(list);
    }

    print(matrizAdyacencia);

    Johnson jon = Johnson();
    print("llegajhonson4");
    var jonson = jon.calcJon(matrizAdyacencia);
    print("llegajhonson5");
    sumaAlgor = "Suma: ${jonson[1]}";
    print("llegajhonson6");
    List<String> aux = jonson[0];
    print("llegajhonson7");

    List<int> vals = jon.mays(matrizAdyacencia);
    print("llegajhonson8");

    List<int> valsn = jon.mins(matrizAdyacencia, jonson[1]);
    print("llegajhonson9");

    var holgs = jon.sacaHolg(matrizAdyacencia, aux, jonson[1], vals, valsn);
    print("llegajhonson10");

    //mostrar por terminal:
    print(jonson); // muestra valores de la ruta y la sumatoria
    print(holgs); //valores de H en forma de matriz
  }
}
