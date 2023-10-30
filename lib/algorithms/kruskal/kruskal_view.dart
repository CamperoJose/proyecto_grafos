import 'package:flutter/material.dart';
import 'package:proyecto_grafos/algorithms/jhonson/Holguras_painter.dart';
import 'package:proyecto_grafos/components/figures/nodo.dart';
import 'package:proyecto_grafos/matriz.dart';

class KruskalView extends StatefulWidget {
  KruskalView({super.key});
  @override
  State<KruskalView> createState() => _KruskalViewState();
}

class _KruskalViewState extends State<KruskalView> {
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
        backgroundColor: Colors.white,

        appBar: AppBar(
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
        ),
        body: Stack(
          children: <Widget>[
            CustomPaint(painter: HolguraPainter(vUniones)),
            CustomPaint(painter: Nodo(vNodo)),
          ],
        ),
      ),
    );
  }
}


