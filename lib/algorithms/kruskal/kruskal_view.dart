import 'package:flutter/material.dart';
import 'package:proyecto_grafos/algorithms/kruskal/kruskal_appbar.dart';
import 'package:proyecto_grafos/algorithms/kruskal/kruskal_holguas_painter.dart';
import 'package:proyecto_grafos/matriz.dart';

import '../../components/figures/nodo.dart';

class KruskalView extends StatefulWidget {
  const KruskalView({super.key});
  @override
  State<KruskalView> createState() => _HomeState();
}

class _HomeState extends State<KruskalView> {
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
        opKruskal==1 ? 'Minimización Algoritmo de Kruskal : Suma = $sumaKruskal' : 'Maximización Algoritmo de Kruskal : Suma = $sumaKruskal',
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
