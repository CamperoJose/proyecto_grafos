import 'package:flutter/material.dart';
import 'package:proyecto_grafos/algorithms/kruskal/kruskal_minimo.dart';
import 'package:proyecto_grafos/algorithms/kruskal/kruskal_view.dart';
import 'package:proyecto_grafos/algorithms/kruskal/logica_kruskal.dart';
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
        'Algoritmo de Kruskal',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w100,
          fontFamily: 'Roboto',
        ),
      ),
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
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
            return {'Minimizar Kruskal', 'Maximizar Kruskal'}
                .map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
          onSelected: (String choice) {
            if (choice == 'Minimizar Kruskal') {
              //creaKruskal(2);
              opKruskal = 1;
              List<List<dynamic>> edges = [];

              for (int i = 0; i < matrixArists.length; i++) {
                for (int j = 0; j < matrixArists.length; j++) {
                  if (matrixArists[i][j] != 0) {
                    edges.add([values[i], values[j], matrixArists[i][j]]);
                  }
                }
              }
              print(edges);

              aux = runKruskalAlgorithm(edges, values);

              Navigator.push(context,
                   MaterialPageRoute(builder: (context) => KruskalView()));
            }
            if (choice == 'Maximizar Kruskal') {
              opKruskal = 2;
              creaKruskal(1);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => KruskalView()));
            }
          },
        ),
      ],
    );
  }

  creaKruskal(int mxmn) {
    String sumaAlgor = "";
    sumaKruskal = 0;

    int n = values.length + 1;
    List<List<String>> matrizAdyacencia =
        List.generate(n, (i) => List<String>.filled(n, '-1'));

    matrizAdyacencia[0][0] = " ";

    print(matrizAdyacencia);

    for (int i = 1; i <= values.length; i++) {
      matrizAdyacencia[0][i] = values[i - 1];
      matrizAdyacencia[i][0] = values[i - 1];
    }

    print(matrizAdyacencia);

    for (int i = 1; i <= values.length; i++) {
      for (int j = 1; j <= values.length; j++) {
        matrizAdyacencia[i][j] = matrixArists[i - 1][j - 1].toString();
      }
    }

    print(matrizAdyacencia);

    List<CaminoKrus> puentes = matrizToLista(matrizAdyacencia);
    List<String> vertices = matrizAdyacencia[0].sublist(1);
    Kruskal grafo = Kruskal(vertices, puentes);
    List<CaminoKrus> kruskal = grafo.kruskalMax();
    if (mxmn != 1) {
      kruskal = grafo.kruskalMin();
    }
    aux = []; // Lista de puentes a pintar
    for (var puente in kruskal) {
      aux.add([puente.inicio, puente.destino]);
      sumaKruskal += puente.peso;
    }
    sumaAlgor = "Suma: $sumaKruskal";
    print(aux);
  }
}
