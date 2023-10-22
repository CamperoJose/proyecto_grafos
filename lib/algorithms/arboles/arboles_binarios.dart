import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_grafos/algorithms/arboles/arbol_painter.dart';
import 'package:proyecto_grafos/algorithms/arboles/float_ingreso_valor.dart';
import 'arbol.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class ArbolesBinariosScreen extends StatefulWidget {
  @override
  _ArbolesBinariosScreenState createState() => _ArbolesBinariosScreenState();
}

class _ArbolesBinariosScreenState extends State<ArbolesBinariosScreen> {
  Arbol objArbol = Arbol();
  final _textFieldController = TextEditingController();

  late ArbolPainter _painter;
  @override
  void initState() {
    super.initState();
    _painter = ArbolPainter(objArbol);
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  listToTree(int order, List<int> list1, List<int> list2) {
    List<List<String>> matrix = List.generate(
        list1.length + 1, (_) => List.filled(list2.length + 1, "0"));
    if (order == 1) {
      for (int i = 1, k = 0; i <= list1.length; i++, k++) {
        int li1 = list1[k];
        int li2 = list2[k];
        matrix[0][i] = "$li1";
        matrix[i][0] = "$li2";
      }
    }
    if (order == 2) {
      for (int i = 1, k = list2.length - 1; i <= list1.length; i++, k--) {
        int li1 = list1[k];
        int li2 = list2[k];
        matrix[0][i] = "$li1";
        matrix[i][0] = "$li2";
      }
    }
    for (int i = 1; i <= list1.length; i++) {
      for (int j = 1; j <= list2.length; j++) {
        if (matrix[0][i] == matrix[j][0]) {
          matrix[i][j] = "*";
        }
      }
    }
    objArbol.resetArbol();
    for (int i = 1; i <= list1.length; i++) {
      for (int j = 1; j <= list2.length; j++) {
        if (matrix[i][j] == "*") {
          objArbol.insertarNodo(int.parse(matrix[j][0]));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Graficador de Árboles Binarios'),
      //   backgroundColor: Color(0xff3282b8),
      //   actions: <Widget>[
      //     ElevatedButton(
      //       onPressed: () {
      //         setState(() {
      //           _ingresoListaDialog(context);
      //           setState(() {});
      //         });
      //       },
      //       child: Text(
      //         "Ingrese las listas",
      //         style: TextStyle(color: Colors.white, fontSize: 15),
      //       ),
      //     ),
      //     SpeedDial(
      //       animatedIcon: AnimatedIcons.menu_home,
      //       mini: true,
      //       childrenButtonSize: const Size(50.0, 50.0),
      //       children: [
      //         SpeedDialChild(
      //           child: Icon(Icons.linear_scale),
      //           label: 'InOrder',
      //           onTap: () {
      //             _showDialogIn();
      //           },
      //         ),
      //         SpeedDialChild(
      //           child: Icon(Icons.linear_scale),
      //           label: 'PosOrder',
      //           onTap: () {
      //             _showDialogPost();
      //           },
      //         ),
      //         SpeedDialChild(
      //           child: Icon(Icons.linear_scale),
      //           label: 'PreOrder',
      //           onTap: () {
      //             _showDialogPre();
      //           },
      //         ),
      //       ],
      //     ),
      //   ],
      // ),

appBar: AppBar(
  leading: IconButton(
    icon: Icon(Icons.arrow_back),
    onPressed: () {
      Navigator.of(this.context).pop();
    },
  ),
  title: Text(
    'Graficador de Árboles Binarios',
    style: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w100,
      fontFamily: 'Roboto',
    ),
  ),
  actions: [
    PopupMenuButton<String>(
      icon: Icon(Icons.more_vert, color: Colors.white,), // Icono de tres puntos
      onSelected: (String choice) {
        // Función para manejar la opción seleccionada
        if (choice == 'inOrder') {
          _showDialogIn();
        } else if (choice == 'postOrder') {
          _showDialogPost();
        } else if (choice == 'preOrder') {
          _showDialogPre();
        }
      },
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem<String>(
            value: 'inOrder',
            child: Text('Calcular In Order'),
          ),
          PopupMenuItem<String>(
            value: 'postOrder',
            child: Text('Calcular Post Order'),
          ),
          PopupMenuItem<String>(
            value: 'preOrder',
            child: Text('Calcular Pre Order'),
          ),
        ];
      },
    ),
  ],
  backgroundColor: Color.fromARGB(255, 5, 56, 14),
  elevation: 5,
),


      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showIngresoValorDialog(context, (int valor) {
            setState(() {
              objArbol.insertarNodo(valor);
              _painter = ArbolPainter(objArbol);
            });
          });
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 5, 56, 14),

      ),
      body: Container(
        color: Color.fromARGB(
            255, 240, 243, 222), // Cambia este valor al color deseado
        child: CustomPaint(
          painter: _painter,
          size: Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height),
        ),
      ),
    );
  }

  void _showDialogIn() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('InOrder'),
          content: Text(objArbol.inOrder(objArbol.raiz)),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDialogPost() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('PostOrder'),
          content: Text(objArbol.postOrder(objArbol.raiz)),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDialogPre() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('PreOrder'),
          content: Text(objArbol.preOrder(objArbol.raiz)),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _ingresoListaDialog(context) {
    TextEditingController text1Controller = TextEditingController();
    TextEditingController text2Controller = TextEditingController();
    TextEditingController text3Controller = TextEditingController();

    int selectedOption = 1;

    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setStatem) {
            return AlertDialog(
              title: const Text("Ingrese las listas (Separada por comas)"),
              content: Form(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: text1Controller,
                    decoration: const InputDecoration(
                      labelText: 'Numero de Elementos',
                    ),
                  ),
                  TextField(
                    controller: text2Controller,
                    decoration: const InputDecoration(
                      labelText: 'InOrden',
                    ),
                  ),
                  TextField(
                    controller: text3Controller,
                    decoration: const InputDecoration(
                      labelText: 'Lista a Elección',
                    ),
                  ),
                  RadioListTile(
                    title: const Text('PreOrder'),
                    value: 1,
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setStatem(() {
                        selectedOption = value!;
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text('PostOrder'),
                    value: 2,
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setStatem(() {
                        selectedOption = value!;
                      });
                    },
                  ),
                ],
              )),
              actions: [
                TextButton(
                  onPressed: () {
                    String text1 = text1Controller.text;
                    String text3 = text2Controller.text;
                    String text2 = text3Controller.text;

                    text1 = text1.isEmpty ? "." : text1;

                    List<int> list2 = text2
                        .split(',')
                        .map((str) => int.parse(str.trim()))
                        .toList();
                    List<int> list3 = text3
                        .split(',')
                        .map((str) => int.parse(str.trim()))
                        .toList();

                    int numberOfElements = int.parse(text1);
                    if (list2.length != numberOfElements ||
                        list3.length != numberOfElements) {
                      print(
                          "Las listas deben tener $numberOfElements elementos cada una.");
                      return;
                    }

                    if (list2.toSet().length != list2.length ||
                        list3.toSet().length != list3.length) {
                      print(
                          "Los números en las listas deben ser únicos y no deben repetirse.");
                      return;
                    }

                    if (!list2.toSet().containsAll(list3.toSet())) {
                      print(
                          "Todos los elementos en 'Lista a Elección' deben estar presentes en 'InOrden'.");
                      return;
                    }

                    listToTree(selectedOption, list2, list3);

                    setState(() {});
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {});
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancelar'),
                ),
              ],
            );
          });
        });
  }
}
