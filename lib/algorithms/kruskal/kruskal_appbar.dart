import 'package:flutter/material.dart';
import 'package:proyecto_grafos/algorithms/kruskal/kruskal_maximizar.dart';
import 'package:proyecto_grafos/algorithms/kruskal/kruskal_minimo.dart';
import 'package:proyecto_grafos/algorithms/kruskal/kruskal_view.dart';
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

              //calculo de sumatoria con aux:
              sumaKruskal = 0;
              for (int i = 0; i < aux.length; i++) {
                //posicion de values:
                int pos1 = values.indexOf(aux[i][0]);
                int pos2 = values.indexOf(aux[i][1]);
                sumaKruskal =sumaKruskal+ matrixArists[pos1][pos2];
              }

              Navigator.push(context,
                   MaterialPageRoute(builder: (context) => KruskalView()));
            }
            if (choice == 'Maximizar Kruskal') {
              opKruskal = 2;

              List<List<dynamic>> edges = [];

              for (int i = 0; i < matrixArists.length; i++) {
                for (int j = 0; j < matrixArists.length; j++) {
                  if (matrixArists[i][j] != 0) {
                    edges.add([values[i], values[j], matrixArists[i][j]]);
                  }
                }
              }
              print(edges);

              aux = runKruskalAlgorithmMax(edges, values);

              //calculo de sumatoria con aux:
              sumaKruskal = 0;
              for (int i = 0; i < aux.length; i++) {
                //posicion de values:
                int pos1 = values.indexOf(aux[i][0]);
                int pos2 = values.indexOf(aux[i][1]);
                sumaKruskal =sumaKruskal+ matrixArists[pos1][pos2];
              }
              


              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => KruskalView()));
            }
          },
        ),
      ],
    );
  }


}
