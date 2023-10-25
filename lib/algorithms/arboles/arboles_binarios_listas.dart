import 'package:flutter/material.dart';
import 'package:proyecto_grafos/algorithms/arboles/arbol_painter.dart';
import 'package:proyecto_grafos/algorithms/arboles/float_ingreso_valor.dart';
import 'package:proyecto_grafos/components/my_alert_error_dialog.dart';
import 'arbol.dart';

class ArbolesBinariosScreenListas extends StatefulWidget {
  @override
  _ArbolesBinariosScreenListasState createState() =>
      _ArbolesBinariosScreenListasState();
}

class _ArbolesBinariosScreenListasState
    extends State<ArbolesBinariosScreenListas> {
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
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ), // Icono de tres puntos
            onSelected: (String choice) {
              // Función para manejar la opción seleccionada
              if (choice == 'inOrder') {
                _showInOrderDialog();
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
          _ingresoListaDialog(context);
        },
        child: Icon(Icons.list),
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

  void _showInOrderDialog() {
    final TextStyle titleStyle = TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      color: Colors.purple.shade900, // Cambia el color del título
    );

    final TextStyle contentStyle = TextStyle(
      fontSize: 20.0,
      color: Colors.black,
    );

    final TextStyle cancelButtonStyle = TextStyle(
      color: Colors.red,
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white, // Cambia el fondo del diálogo
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          title: Text('In Order', style: titleStyle),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "{ ${objArbol.inOrder(objArbol.raiz)} }",
                style: contentStyle,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cerrar', style: cancelButtonStyle),
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
    final TextStyle titleStyle = TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      color: Colors.purple.shade900, // Cambia el color del título
    );

    final TextStyle contentStyle = TextStyle(
      fontSize: 20.0,
      color: Colors.black,
    );

    final TextStyle cancelButtonStyle = TextStyle(
      color: Colors.red,
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white, // Cambia el fondo del diálogo
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          title: Text('Post Order', style: titleStyle),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "{ ${objArbol.postOrder(objArbol.raiz)} }",
                style: contentStyle,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cerrar', style: cancelButtonStyle),
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
    final TextStyle titleStyle = TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      color: Colors.purple.shade900, // Cambia el color del título
    );

    final TextStyle contentStyle = TextStyle(
      fontSize: 20.0,
      color: Colors.black,
    );

    final TextStyle cancelButtonStyle = TextStyle(
      color: Colors.red,
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white, // Cambia el fondo del diálogo
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          title: Text('Pre Order', style: titleStyle),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "{ ${objArbol.preOrder(objArbol.raiz)} }",
                style: contentStyle,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cerrar', style: cancelButtonStyle),
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
    TextEditingController text2Controller = TextEditingController();
    TextEditingController text3Controller = TextEditingController();

    int selectedOption = 1;

    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setStatem) {
            return AlertDialog(
                      backgroundColor: const Color.fromARGB(255, 255, 255, 255), // Fondo con un tono azul grisáceo
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
              title: const Text("INGRESAR LISTAS", style: TextStyle(
            color: const Color.fromARGB(255, 0, 0, 0), // Texto en color blanco
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            decorationStyle: TextDecorationStyle.wavy,


          ),),
            
              content: Form(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Valores separados por comma y sin espacios", style: TextStyle(color: Colors.green.shade900, fontSize: 16.0),),
                  SizedBox(height: 20,),                  TextField(
                    controller: text2Controller,
                    style: TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      hintText: 'Lista In Order',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                  TextField(
                    controller: text3Controller,
                    style: TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      hintText: 'Lista Pre Order',
                      hintStyle: TextStyle(color: Colors.grey),
                      //color de borde:
                    ),
                  ),
                ],
              )),
              actions: [
                TextButton(
                  onPressed: () {
                    //text1 tiene que ser la cantidad de comas en las listas:
                    String text1 =
                        text2Controller.text.split(",").length.toString();
                    String textn =
                        text3Controller.text.split(",").length.toString();

                    if (text1 != textn) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return MyAlertErrorDialog(
                            title: 'Tamaño de listas no coinciden',
                            content:
                                'Tanto la lista In Order como la lista Pre Order deben tener el mismo tamaño.',
                          );
                        },
                      );
                    }

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



                    if (list2.toSet().length != list2.length ||
                        list3.toSet().length != list3.length) {
                          showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return MyAlertErrorDialog(
                            title: 'Números repetidos',
                            content:
                                'En las listas no deben haber números repetidos.',
                          );
                        },
                      );
                    }
                    listToTree(selectedOption, list2, list3);
                    setState(() {
                      _painter = ArbolPainter(objArbol);
                    });
                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.green), // Botón en verde
            ),
            child: Text(
              "Aceptar",
              style: TextStyle(
                color: Colors.white, // Texto en color blanco
                fontSize: 18.0,
              ),
            ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {});
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
              primary: Colors.red, // Texto en rojo
            ),
            child: Text(
              "Cancelar",
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
                ),
              ],
            );
          });
        });
  }
}
