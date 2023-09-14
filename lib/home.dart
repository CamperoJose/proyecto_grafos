import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:proyecto_grafos/components/dropdown_component.dart';
import 'package:proyecto_grafos/components/my_speed_dial.dart';
import 'package:proyecto_grafos/generar_estructura_json.dart';
import 'package:proyecto_grafos/save_json.dart';
import 'package:proyecto_grafos/subir_archivo.dart';
import 'package:proyecto_grafos/views/matrix_view.dart';
import 'components/figures/nodo.dart';
import 'data.dart';
import 'components/figures/formas.dart';
import '../classes/modelo_arista.dart';
import '../classes/modelo_nodo.dart';
import 'matriz.dart';
import 'package:url_launcher/url_launcher.dart';


class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int modo = -1;
  final _textFieldController = TextEditingController();
  final _textFieldController2 = TextEditingController();
  final _msgNodo = TextEditingController();
  int idNode = 1;
  bool isDirected = false;

  void cambioEstado(int n) {
    modo = n;
    setState(() {
      print("Nuevo estado");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,

        //floating usando speedial:
        floatingActionButton: MySpeedDial(context).build(context),
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
                              title: const Text('Ingrese el valor'),
                              content: TextField(
                                controller: _msgNodo,
                                decoration: const InputDecoration(
                                    hintText: "Ingrese el valor aquí"),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  child: const Text('Aceptar'),
                                  onPressed: () {
                                    //verificar si ya existe nodo con ese nombre:
                                    var listNodos = vNodo
                                        .where((element) =>
                                            element.mensaje == _msgNodo.text)
                                        .toList();

                                    if (listNodos.isNotEmpty) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text(
                                                'Ya existe un nodo con ese nombre'),
                                            content: const Text(
                                                'Por favor ingrese otro nombre'),
                                            actions: <Widget>[
                                              ElevatedButton(
                                                child: const Text('Aceptar'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    } else {
                                      vNodo.add(ModeloNodo(
                                          (vNodo.length + 1).toString(),
                                          des.globalPosition.dx,
                                          des.globalPosition.dy,
                                          30,
                                          _msgNodo.text));
                                      setState(() {
                                        values.add(_msgNodo.text);

                                        if (matrixTrueFalse.isEmpty) {
                                          matrixTrueFalse.add([0]);
                                        } else {
                                          for (int i = 0;
                                              i < matrixTrueFalse.length;
                                              i++) {
                                            matrixTrueFalse[i].add(0);
                                          }
                                          List<int> list = [];
                                          for (int i = 0;
                                              i < matrixTrueFalse.length+1;
                                              i++) {
                                            list.add(0);
                                          }
                                          matrixTrueFalse.add(list);
                                        }
                                        if (matrixArists.isEmpty) {
                                          matrixArists.add([0]);
                                        } else {
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

                                      Navigator.of(context).pop();
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        );

                        break;
                      case 2:
                        int pos = estaSobreNodo(
                            des.globalPosition.dx, des.globalPosition.dy);
                        if (pos > 0) {
                          ModeloNodo objD = vNodo
                              .where((element) => int.parse(element.id) == pos)
                              .first;

                          var listJoins = vUniones
                              .where((element) =>
                                  element.idNodoInicial == objD.id ||
                                  element.idNodoFinal == objD.id)
                              .toList();

                          for (var union in listJoins) {
                            vUniones.remove(union);
                          }

                          vNodo.removeWhere(
                              (element) => int.parse(element.id) == pos);

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
                      case 4:
                        int pos = estaSobreNodo(
                            des.globalPosition.dx, des.globalPosition.dy);
                        ModeloNodo objN = vNodo
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
                                    TextField(
                                      controller: _textFieldController,
                                      decoration: InputDecoration(
                                          hintText: "Ingrese el peso aquí"),
                                    ),

                                    SizedBox(
                                      height: 10,
                                    ),

                                    //combo box para elegir si es dirigido o no

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
                                      var listJoins = vUniones
                                          .where((element) =>
                                              element.idNodoFinal == objN.id &&
                                              element.idNodoInicial ==
                                                  idInicial)
                                          .toList();

                                      var listJoins2 = vUniones
                                          .where((element) =>
                                              element.idNodoFinal ==
                                                  idInicial &&
                                              element.idNodoInicial == objN.id)
                                          .toList();

                                      if (listJoins.isEmpty &&
                                          listJoins2.isEmpty) {
                                        setState(() {
                                          xfinal = objN.x;
                                          yfinal = objN.y;

                                          if (joinModo == 2 &&
                                              xinicial != -1 &&
                                              yinicial != -1 &&
                                              xfinal != -1 &&
                                              yfinal != -1) {
                                            vUniones.add(ModeloArista(
                                                idInicial,
                                                objN.id,
                                                xinicial,
                                                yinicial,
                                                xfinal,
                                                yfinal,
                                                _textFieldController.text,
                                                true,
                                                isDirected));

                                            int posInicial = values
                                                .indexOf(nodoInicial.mensaje);
                                            int posFinal =
                                                values.indexOf(objN.mensaje);
                                            matrixTrueFalse[posInicial]
                                                [posFinal] = 1;

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
                                          listJoins2.isNotEmpty) {
                                        setState(() {
                                          xfinal = objN.x;
                                          yfinal = objN.y;

                                          if (joinModo == 2 &&
                                              xinicial != -1 &&
                                              yinicial != -1 &&
                                              xfinal != -1 &&
                                              yfinal != -1) {
                                            vUniones.add(ModeloArista(
                                                idInicial,
                                                objN.id,
                                                xinicial,
                                                yinicial,
                                                xfinal,
                                                yfinal,
                                                _textFieldController.text,
                                                false,
                                                isDirected));

                                            int posInicial = values
                                                .indexOf(nodoInicial.mensaje);
                                            int posFinal =
                                                values.indexOf(objN.mensaje);
                                            matrixTrueFalse[posInicial]
                                                [posFinal] = 1;

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

                      case 5:
                        int pos = estaSobreNodo(
                            des.globalPosition.dx, des.globalPosition.dy);
                        ModeloNodo objE = vNodo
                            .where((element) => int.parse(element.id) == pos)
                            .first;
                        if (pos > 1) {
                          ModeloNodo objE = vNodo
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
                                        objE.mensaje =
                                            _textFieldController2.text;
                                      });

                                      _textFieldController2.text = "";
                                      Navigator.of(context).pop();
                                    },

                                    // Aquí puedes hacer algo con el texto ingresado por el usuario
                                  ),
                                ],
                              );
                            },
                          );
                        }

                        break;
                      case 6:
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
                    case 3:
                      int pos = estaSobreNodo(
                          des.globalPosition.dx, des.globalPosition.dy);

                      if (pos > 0) {
                        ModeloNodo objS = vNodo
                            .where((element) => int.parse(element.id) == pos)
                            .first;

                        var listJoins = vUniones
                            .where(
                                (element) => element.idNodoInicial == objS.id)
                            .toList();
                        var listJoins2 = vUniones
                            .where((element) => element.idNodoFinal == objS.id)
                            .toList();

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
        bottomNavigationBar: BottomAppBar(
          color: Colors.lightBlue.shade900,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      modo = 1;
                    });
                  },
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: modo == 2 ? Colors.white : Colors.transparent,
                    ),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: modo == 2
                            ? const BorderRadius.only(
                                topRight: Radius.circular(30),
                              )
                            : const BorderRadius.only(
                                bottomRight: Radius.circular(30),
                                bottomLeft: Radius.circular(30),
                              ),
                        color: modo == 1
                            ? Colors.white
                            : Colors.lightBlue.shade900,
                      ),
                      child: Icon(
                        Icons.add_sharp,
                        size: modo == 1 ? 40 : 30,
                        color: modo == 1 ? Colors.green : Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      modo = 2;
                    });
                  },
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: modo == 3 || modo == 1
                          ? Colors.white
                          : Colors.transparent,
                    ),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: modo == 1
                            ? const BorderRadius.only(
                                topLeft: Radius.circular(30),
                              )
                            : modo == 3
                                ? const BorderRadius.only(
                                    topRight: Radius.circular(30),
                                  )
                                : const BorderRadius.only(
                                    bottomRight: Radius.circular(30),
                                    bottomLeft: Radius.circular(30),
                                  ),
                        color: modo == 2
                            ? Colors.white
                            : Colors.lightBlue.shade900,
                      ),
                      child: Icon(
                        Icons.delete,
                        size: modo == 2 ? 40 : 30,
                        color: modo == 2 ? Colors.green : Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      modo = 3;
                    });
                  },
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: modo == 4 || modo == 2
                          ? Colors.white
                          : Colors.transparent,
                    ),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        //sombra para esquinas inferiores con box shadow
                        borderRadius: modo == 2
                            ? const BorderRadius.only(
                                topLeft: Radius.circular(30),
                              )
                            : modo == 4
                                ? const BorderRadius.only(
                                    topRight: Radius.circular(30),
                                  )
                                : const BorderRadius.only(
                                    bottomRight: Radius.circular(30),
                                    bottomLeft: Radius.circular(30),
                                  ),
                        color: modo == 3
                            ? Colors.white
                            : Colors.lightBlue.shade900,
                      ),
                      child: Icon(
                        Icons.move_up,
                        size: modo == 3 ? 40 : 30,
                        color: modo == 3 ? Colors.green : Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      modo = 4;
                    });
                  },
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: modo == 5 || modo == 3
                          ? Colors.white
                          : Colors.transparent,
                    ),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: modo == 3
                            ? const BorderRadius.only(
                                topLeft: Radius.circular(30),
                              )
                            : modo == 5
                                ? const BorderRadius.only(
                                    topRight: Radius.circular(30),
                                  )
                                : const BorderRadius.only(
                                    bottomRight: Radius.circular(30),
                                    bottomLeft: Radius.circular(30),
                                  ),
                        color: modo == 4
                            ? Colors.white
                            : Colors.lightBlue.shade900,
                      ),
                      child: Icon(
                        Icons.linear_scale,
                        size: modo == 4 ? 40 : 30,
                        color: modo == 4 && joinModo == 1
                            ? Colors.green
                            : modo == 4 && joinModo == 2
                                ? Colors.orange
                                : Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      modo = 5;
                    });
                  },
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: modo == 4 || modo == 6
                          ? Colors.white
                          : Colors.transparent,
                    ),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: modo == 4
                            ? const BorderRadius.only(
                                topLeft: Radius.circular(30),
                              )
                            : modo == 6
                                ? const BorderRadius.only(
                                    topRight: Radius.circular(30),
                                  )
                                : const BorderRadius.only(
                                    bottomRight: Radius.circular(30),
                                    bottomLeft: Radius.circular(30),
                                  ),
                        color: modo == 5
                            ? Colors.white
                            : Colors.lightBlue.shade900,
                      ),
                      child: Icon(
                        Icons.edit,
                        size: modo == 5 ? 40 : 30,
                        color: modo == 5 && joinModo == 1
                            ? Colors.green
                            : modo == 5 && joinModo == 2
                                ? Colors.orange
                                : Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      modo = 6;
                    });
                  },
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: modo == 5 ? Colors.white : Colors.transparent,
                    ),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: modo == 5
                            ? const BorderRadius.only(
                                topLeft: Radius.circular(30),
                              )
                            : const BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                              ),
                        color: modo == 6
                            ? Colors.white
                            : Colors.lightBlue.shade900,
                      ),
                      child: Icon(
                        Icons.wind_power,
                        size: modo == 6 ? 40 : 30,
                        color: modo == 6 ? Colors.green : Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int estaSobreNodo(double x1, double y2) {
    int pos = 0;
    for (var nodo in vNodo) {
      double dist = sqrt(pow(x1 - nodo.x, 2) + pow(y2 - nodo.y, 2));
      if (dist <= nodo.radio) {
        pos = int.parse(nodo.id);
      }
    }
    return pos;
  }
}
