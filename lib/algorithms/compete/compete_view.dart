import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proyecto_grafos/algorithms/compete/app_bar_compete.dart';
import 'package:proyecto_grafos/algorithms/compete/botton_app_bar_compete.dart';
import 'package:proyecto_grafos/algorithms/compete/nodo.dart';
import 'package:proyecto_grafos/classes/modelo_nodo.dart';
import 'package:proyecto_grafos/components/figures/union.dart';
import 'package:proyecto_grafos/components/my_alert_error_dialog.dart';
import 'package:proyecto_grafos/data.dart';
import 'package:proyecto_grafos/matriz.dart';

class CompeteView extends StatefulWidget {
  const CompeteView({super.key});
  @override
  State<CompeteView> createState() => _CompeteViewState();
}

class _CompeteViewState extends State<CompeteView> {
  int modo = -1;
  final _msgNodox = TextEditingController();
  final _msgNodoy = TextEditingController();
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
        appBar: CustomAppBarCompete(context: context),
        body: Stack(
          children: <Widget>[
            CustomPaint(painter: Union(vUniones)),
            CustomPaint(painter: Nodo(vNodo)),
            GestureDetector(
              onPanDown: (des) {
                setState(
                  () {
                    switch (modo) {
                      case 1: //agregar nodo
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(
                                'Ingrese los valores',
                                style: TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              content: Column(
                                //width cross:
                                mainAxisSize: MainAxisSize.min,

                                children: [
                                  TextField(
                                    controller: _msgNodox,
                                    decoration:
                                        InputDecoration(hintText: "Ingrese Xi"),
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            decimal: true),
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'^\d+\.?\d{0,2}')),
                                    ],
                                  ),
                                  SizedBox(height: 20.0, width: 20),
                                  TextField(
                                    controller: _msgNodoy,
                                    decoration:
                                        InputDecoration(hintText: "Ingrese Yi"),
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            decimal: true),
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'^\d+\.?\d{0,2}')),
                                    ],
                                  ),
                                ],
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.green,
                                    onPrimary: Colors.white,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 32.0,
                                      vertical: 12.0,
                                    ),
                                  ),
                                  child: Text(
                                    'Aceptar',
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                  onPressed: () {
                                    var listNodos = vNodo
                                        .where((element) =>
                                            element.mensaje == _msgNodox.text)
                                        .toList();
                                    if (listNodos.isNotEmpty) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return MyAlertErrorDialog(
                                            title:
                                                'Ya existe un nodo con esos valores',
                                            content:
                                                'Por favor ingrese otros valores',
                                          );
                                        },
                                      );
                                    } else {

                                      valoresx.add(double.parse(_msgNodox.text));
                                      valoresy.add(double.parse(_msgNodoy.text));
                                      if(primerX!=-1 && primerY!=-1){
                                        primerX = double.parse(_msgNodox.text);
                                        primerY = double.parse(_msgNodoy.text);
                                      }

                                      vNodo.add(ModeloNodo(
                                          (vNodo.length + 1).toString(),
                                          des.globalPosition.dx,
                                          des.globalPosition.dy,
                                          30,
                                          "${_msgNodox.text}; ${_msgNodoy.text}"));
                                      setState(() {
                                        values.add(_msgNodox.text);
                                        if (matrixTrueFalse.isEmpty)
                                          matrixTrueFalse.add([0]);
                                        else {
                                          for (int i = 0;
                                              i < matrixTrueFalse.length;
                                              i++) {
                                            matrixTrueFalse[i].add(0);
                                          }
                                          List<int> list = [];
                                          for (int i = 0;
                                              i < matrixTrueFalse.length + 1;
                                              i++) {
                                            list.add(0);
                                          }
                                          matrixTrueFalse.add(list);
                                        }
                                        if (matrixArists.isEmpty)
                                          matrixArists.add([0]);
                                        else {
                                          for (int i = 0;
                                              i < matrixArists.length;
                                              i++) {
                                            matrixArists[i].add(0);
                                          }
                                          List<int> list = [];
                                          for (int i = 0;
                                              i < matrixArists.length + 1;
                                              i++) {
                                            list.add(0);
                                          }
                                          matrixArists.add(list);
                                        }
                                      });
                                      _msgNodox.clear();
                                      _msgNodoy.clear();
                                      Navigator.of(context).pop();
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        );
                        break;
                    }
                  },
                );
              },
            ),
          ],
        ),
        bottomNavigationBar: MyBottomAppBar(
          modo: modo,
          joinModo: joinModo,
          onTap: (newMode) {
            setState(() {
              modo = newMode;
            });
          },
        ),
      ),
    );
  }

  int estaSobreNodo(double x1, double y2) {
    int pos = 0;
    for (var nodo in vNodo) {
      double dist = sqrt(pow(x1 - nodo.x, 2) + pow(y2 - nodo.y, 2));
      if (dist <= nodo.radio) pos = int.parse(nodo.id);
    }
    return pos;
  }
}
