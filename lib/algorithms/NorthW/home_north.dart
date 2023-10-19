import 'dart:math';
import 'package:flutter/material.dart';
import 'package:proyecto_grafos/algorithms/NorthW/Clases%20north/matriz.dart';
import 'package:proyecto_grafos/algorithms/NorthW/Clases%20north/modelo_aristaN.dart';
import 'package:proyecto_grafos/algorithms/NorthW/Clases%20north/modelo_nodoN.dart';
import 'package:proyecto_grafos/algorithms/NorthW/figures/nodo.dart';
import 'package:proyecto_grafos/algorithms/NorthW/figures/union.dart';
import 'package:proyecto_grafos/components/dropdown_component.dart';
import 'package:proyecto_grafos/components/my_alert_error_dialog.dart';
import 'package:proyecto_grafos/components/my_botton_app_bar.dart';

import 'Clases north/dataN.dart';
import 'Clases north/speedNorth.dart';
import 'app_bar_north.dart';


class HomeNorth extends StatefulWidget {
  const HomeNorth({super.key});
  @override
  State<HomeNorth> createState() => _HomeState();
}

class _HomeState extends State<HomeNorth> {
  int modo = -1;
  final _textFieldController = TextEditingController();
  final _textFieldController2 = TextEditingController();
  final _msgNodo = TextEditingController();
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
        appBar: CustomAppBar(context: context),
        floatingActionButton: MySpeedDial(context).build(context),
        body: Stack(
          children: <Widget>[
            CustomPaint(painter: Union(vUniones)),
            CustomPaint(painter: Nodo(vNodo)),
            GestureDetector(
              onPanDown: (des) {
                setState(() {
                  switch (modo) {
                    case 1: //agregar nodo
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Ingrese el valor', style: TextStyle(
                                fontSize: 22.0, fontWeight: FontWeight.bold),),
                            content: TextField(
                              controller: _msgNodo,
                              decoration: InputDecoration(
                                  hintText: "Ingrese el valor aquí"),
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
                                  'Aceptar', style: TextStyle(fontSize: 18.0),),
                                onPressed: () {
                                  var listNodos =
                                  vNodo.where((element) =>
                                  element.mensaje == _msgNodo.text).toList();
                                  if (listNodos.isNotEmpty) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return MyAlertErrorDialog(
                                          title: 'Ya existe un nodo con ese nombre',
                                          content: 'Por favor ingrese otro nombre',
                                        );
                                      },
                                    );
                                  } else {
                                    vNodo.add(ModeloNodoN(
                                        (vNodo.length + 1).toString(),
                                        des.globalPosition.dx,
                                        des.globalPosition.dy, 30,
                                        _msgNodo.text));
                                    setState(() {
                                      values.add(_msgNodo.text);
                                      if (matrixTrueFalse.isEmpty)
                                        matrixTrueFalse.add([0]);
                                      else {
                                        for (int i = 0; i <
                                            matrixTrueFalse.length; i++) {
                                          matrixTrueFalse[i].add(0);
                                        }
                                        List<int> list = [];
                                        for (int i = 0; i <
                                            matrixTrueFalse.length + 1; i++) {
                                          list.add(0);
                                        }
                                        matrixTrueFalse.add(list);
                                      }
                                      if (matrixArists.isEmpty)
                                        matrixArists.add([0]);
                                      else {
                                        for (int i = 0; i <
                                            matrixArists.length; i++) {
                                          matrixArists[i].add(0);
                                        }
                                        List<int> list = [];
                                        for (int i = 0; i <
                                            matrixArists.length + 1; i++) {
                                          list.add(0);
                                        }
                                        matrixArists.add(list);
                                      }
                                    });
                                    _msgNodo.clear();
                                    Navigator.of(context).pop();
                                  }
                                },
                              ),
                            ],
                          );
                        },
                      );
                      break;
                    case 2: //ELIMINAR NODO
                      int pos = estaSobreNodo(
                          des.globalPosition.dx, des.globalPosition.dy);
                      if (pos > 0) {
                        ModeloNodoN objD = vNodo
                            .where((element) => int.parse(element.id) == pos)
                            .first;
                        var listJoins = vUniones.where((element) =>
                        element.idNodoInicial == objD.id ||
                            element.idNodoFinal == objD.id).toList();
                        for (var union in listJoins) {
                          vUniones.remove(union);
                        }
                        vNodo.removeWhere((element) =>
                        int.parse(element.id) == pos);
                        int posList = values.indexOf(objD.mensaje);
                        values.remove(objD.mensaje);
                        matrixTrueFalse.removeAt(posList);
                        for (int i = 0; i < matrixTrueFalse.length; i++) {
                          matrixTrueFalse[i].removeAt(posList);
                        }
                        matrixArists.removeAt(posList);
                        for (int i = 0; i < matrixArists.length; i++) {
                          matrixArists[i].removeAt(posList);
                        }
                      }
                      break;
                    case 4: //AGREGANDO ARISTA
                      int pos = estaSobreNodo(
                          des.globalPosition.dx, des.globalPosition.dy);
                      ModeloNodoN objN = vNodo
                          .where((element) => int.parse(element.id) == pos)
                          .first;
                      if (joinModo == 1) {
                        xinicial = objN.x;
                        yinicial = objN.y;
                        idInicial = objN.id;
                        nodoInicial = objN;
                        joinModo++;
                      } else if (joinModo == 2) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Ingrese el peso'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(controller: _textFieldController,
                                    decoration: const InputDecoration(
                                        hintText: "Ingrese el peso aquí"),),
                                  const SizedBox(height: 10),
                                  GraphTypeDropdown(
                                    initialValue: isDirected,
                                    onChanged: (newValue) {
                                      isDirected = newValue;
                                    },
                                  ),
                                ],
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  child: const Text('Aceptar'),
                                  onPressed: () {
                                    var listJoins = vUniones.where((element) =>
                                    element.idNodoFinal == objN.id &&
                                        element.idNodoInicial == idInicial)
                                        .toList();
                                    var listJoins2 = vUniones.where((element) =>
                                    element.idNodoFinal == idInicial &&
                                        element.idNodoInicial == objN.id)
                                        .toList();
                                    if (listJoins.isEmpty &&
                                        listJoins2.isEmpty &&
                                        idInicial != objN.id) {
                                      setState(() {
                                        xfinal = objN.x;
                                        yfinal = objN.y;
                                        if (joinModo == 2 &&
                                            xinicial != -1 &&
                                            yinicial != -1 &&
                                            xfinal != -1 &&
                                            yfinal != -1) {
                                          vUniones.add(ModeloAristaN(
                                              idInicial,
                                              objN.id,
                                              xinicial,
                                              yinicial,
                                              xfinal,
                                              yfinal,
                                              _textFieldController.text,
                                              true,
                                              isDirected));
                                          int posInicial = values.indexOf(
                                              nodoInicial.mensaje);
                                          int posFinal = values.indexOf(
                                              objN.mensaje);
                                          matrixTrueFalse[posInicial][posFinal] =
                                          1;
                                          matrixArists[posInicial][posFinal] =
                                              int.parse(
                                                  _textFieldController.text);
                                          _textFieldController.text = "";
                                        }
                                        joinModo = 1;
                                        xinicial = -1;
                                        yinicial = -1;
                                        xfinal = -1;
                                        yfinal = -1;
                                      });
                                    }
                                    if (listJoins.isEmpty &&
                                        listJoins2.isNotEmpty ||
                                        (listJoins.isEmpty &&
                                            listJoins2.isEmpty &&
                                            idInicial == objN.id)) {
                                      setState(() {
                                        xfinal = objN.x;
                                        yfinal = objN.y;
                                        bool a = false;
                                        if (xinicial == xfinal &&
                                            yinicial == yfinal) a = true;
                                        if (joinModo == 2 && xinicial != -1 &&
                                            yinicial != -1 && xfinal != -1 &&
                                            yfinal != -1) {
                                          vUniones.add(ModeloAristaN(
                                              idInicial,
                                              objN.id,
                                              xinicial,
                                              yinicial,
                                              xfinal,
                                              yfinal,
                                              _textFieldController.text,
                                              a,
                                              isDirected));
                                          int posInicial = values.indexOf(
                                              nodoInicial.mensaje);
                                          int posFinal = values.indexOf(
                                              objN.mensaje);
                                          matrixTrueFalse[posInicial][posFinal] =
                                          1;
                                          matrixArists[posInicial][posFinal] =
                                              int.parse(
                                                  _textFieldController.text);
                                          _textFieldController.text = "";
                                        }
                                        joinModo = 1;
                                        xinicial = -1;
                                        yinicial = -1;
                                        xfinal = -1;
                                        yfinal = -1;
                                      });
                                    }
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                      break;
                    case 5: //EDITAR NODO
                      int pos = estaSobreNodo(
                          des.globalPosition.dx, des.globalPosition.dy);
                      if (pos > 0) {
                        ModeloNodoN objE = vNodo
                            .where((element) => int.parse(element.id) == pos)
                            .first;
                        _textFieldController2.text = objE.mensaje;
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Ingrese el nuevo valor'),
                              content: TextField(
                                controller: _textFieldController2,
                                decoration: const InputDecoration(
                                    hintText: "Ingrese el valor aquí"),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  child: Text('Aceptar'),
                                  onPressed: () {
                                    setState(() {
                                      int pos = values.indexWhere((
                                          element) => element == objE.mensaje);
                                      values[pos] = _textFieldController2.text;
                                      objE.mensaje = _textFieldController2.text;
                                    });
                                    _textFieldController2.text = "";
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                      break;
                    case 6: //limpiar todo:
                      setState(() {
                        vNodo = [];
                        vUniones = [];
                        matrixTrueFalse = [];
                        matrixArists = [];
                        values = [];
                      });
                      break;
                  }
                },
                );
              },
              onPanUpdate: (des) {
                setState(() {
                  switch (modo) {
                    case 3: //mover objetos
                      int pos = estaSobreNodo(
                          des.globalPosition.dx, des.globalPosition.dy);
                      if (pos > 0) {
                        ModeloNodoN objS = vNodo
                            .where((element) => int.parse(element.id) == pos)
                            .first;
                        var listJoins = vUniones.where((element) =>
                        element.idNodoInicial == objS.id).toList();
                        var listJoins2 = vUniones.where((element) =>
                        element.idNodoFinal == objS.id).toList();
                        for (var union in listJoins) {
                          union.xinicio = des.globalPosition.dx;
                          union.yinicio = des.globalPosition.dy;
                        }
                        for (var union in listJoins2) {
                          union.xfinal = des.globalPosition.dx;
                          union.yfinal = des.globalPosition.dy;
                        }
                        objS.x = des.globalPosition.dx;
                        objS.y = des.globalPosition.dy;
                      }
                      break;
                  }
                });
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
