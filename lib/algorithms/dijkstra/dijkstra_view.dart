import 'package:flutter/material.dart';
import 'package:proyecto_grafos/algorithms/dijkstra/dijkstra_holguas_painter.dart';
import 'package:proyecto_grafos/matriz.dart';

import '../../components/figures/nodo.dart';

class DijkstraView extends StatefulWidget {
  const DijkstraView({super.key});
  @override
  State<DijkstraView> createState() => _HomeState();
}

class _HomeState extends State<DijkstraView> {
  int modo = -1;

  int idNode = 1;
  bool isDirected = false;

  void cambioEstado(int n) {
    setState(() {
      modo = n;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Color.fromARGB(255, 245, 246, 218),
        appBar: AppBar(
          leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(this.context).pop();
        },
      ),
      title: Text(
        opKruskal==1 ? 'Minimización Algoritmo de Dijkstra : Suma = $sumaDijkstra' : 'Maximización Algoritmo de Dijkstra : Suma = $sumaDijkstra',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w100,
          fontFamily: 'Roboto',
        ),
      ),
      backgroundColor: opKruskal==1 ? Colors.green.shade900 : const Color.fromARGB(255, 86, 2, 47),
      elevation: 5,
    
        ),
        body: Stack(
          children: <Widget>[
            CustomPaint(painter: Union(vUniones)),
            CustomPaint(painter: Nodo(vNodo)),
          ],
        ),
      ),
    );
  }


}
