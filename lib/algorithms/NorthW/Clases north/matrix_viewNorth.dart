import 'dart:math';

import 'package:flutter/material.dart';
import 'package:proyecto_grafos/algorithms/NorthW/Clases%20north/matriz.dart';

import '../norwnew.dart';

void main() => runApp(MaterialApp(home: MatrixView()));

class MatrixView extends StatelessWidget {
  List<String> textValuesColumns = List.generate(values.length, (index) => "",);
  List<String> textValuesRow = List.generate(values.length, (index) => "",);

  List<List<String>> textValues = List.generate(values.length, (_) => List.filled(values.length, ''));
  List<List<TextEditingController>> textControllers = List.generate(values.length, (_) => List.filled(values.length, TextEditingController()));
  List<List<int>> matrix = List.generate(values.length, (_) => List.filled(values.length, 0));
  List<String> letras= values;
  List<String> rows = [];  // Definir la lista de filas aquí
  List<String> columns = [];  // Definir la lista de columnas aquí

  @override
  Widget build(BuildContext context) {



    List<String> rows = [];
    List<String> columns = [];
    List<List<int>> reducedMatrix = [];


    // Encuentra las filas con datos no nulos
    for (int row = 0; row < matrix.length; row++) {
      bool hasData = matrix[row].any((value) => value != 0);
      if (hasData) {
        rows.add(values[row]);
      }
    }

    // Encuentra las columnas con datos no nulos
    for (int col = 0; col < matrix[0].length; col++) {
      bool hasData = matrix.any((row) => row[col] != 0);
      if (hasData) {
        columns.add(values[col]);

      }
    }
    // Redefine reducedMatrix con solo las filas y columnas con datos no nulos
    reducedMatrix = matrix
        .where((row) => row.any((value) => value != 0))
        .map((row) => row.where((value) => value != 0).toList())
        .toList();


    return Scaffold(
      appBar: AppBar(
        title: Text('Matrices de Adyacencia'),
        backgroundColor: Colors.lightBlue.shade900,
        actions: <Widget>[
          PopupMenuButton<String>(
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Calcular NorthWest',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            itemBuilder: (BuildContext context) {
              return {'Minimizar'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
            onSelected: (String choice) {
              if (choice == 'Minimizar') {

                _showMinimizeAlertDialog(context, values,matrixArists);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionTitle('Matriz de Aristas:'),
            const SizedBox(height: 16),
            _MatrixWidget(matrix: matrixArists, values: values, textControllers: textControllers),
          ],
        ),
      ),
    );
  }
}

class _MatrixWidget extends StatelessWidget {
  final List<List<int>> matrix;
  final List<String> values;
  final List<List<TextEditingController>> textControllers;


  _MatrixWidget({
  required this.matrix,
  required this.values,
  required this.textControllers,
});

  @override
  Widget build(BuildContext context) {
    List<Color> columnColors = [Colors.blueGrey.withOpacity(0.2), Colors.white];
    int currentColumnColorIndex = 0;

    // Obtén la lista de filas y columnas con datos no nulos
    List<String> rows = [];
    List<String> columns = [];
    List<List<int>> reducedMatrix = [];


    // Encuentra las filas con datos no nulos
    for (int row = 0; row < matrix.length; row++) {
      bool hasData = matrix[row].any((value) => value != 0);
      if (hasData) {
        rows.add(values[row]);
      }
    }

    // Encuentra las columnas con datos no nulos
    for (int col = 0; col < matrix[0].length; col++) {
      bool hasData = matrix.any((row) => row[col] != 0);
      if (hasData) {
        columns.add(values[col]);

      }
    }
    // Redefine reducedMatrix con solo las filas y columnas con datos no nulos
    reducedMatrix = matrix
        .where((row) => row.any((value) => value != 0))
        .map((row) => row.where((value) => value != 0).toList())
        .toList();





    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1.0, color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Table(
          defaultColumnWidth: FixedColumnWidth(80),
          children: [
            TableRow(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              children: [
                _TableCell(''),
                ...columns.map((value) {
                  return _TableCell(value, isHeader: true);
                }),
              ],
            ),
            ...reducedMatrix.asMap().entries.map((entry) {
              int rowIndex = entry.key;
              List<int> rowValues = entry.value;

              return TableRow(
                children: [
                  _TableCell(rows[rowIndex], isHeader: true),
                  ...rowValues.asMap().entries.map((entry) {
                    int value = entry.value;

                    currentColumnColorIndex =
                        (currentColumnColorIndex + 1) % columnColors.length;

                    return _TableCell(
                      value.toString(),
                      isBold: value != 0,
                      backgroundColor: columnColors[currentColumnColorIndex],
                    );
                  }).toList(),
                ],
              );
            }).toList(),
          ],
        ),
      ),

    );

  }



}

class _SectionTitle extends StatelessWidget {
  final String title;

  _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}

class _TableCell extends StatelessWidget {
  final String text;
  final bool isHeader;
  final bool isBold;
  final Color? backgroundColor;

  _TableCell(this.text, {this.isHeader = false, this.isBold = false, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      alignment: Alignment.center,
      color: backgroundColor,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: isBold ? FontWeight.bold : isHeader ? FontWeight.bold : FontWeight.normal,
          color: isBold ? Colors.purple : isHeader ? Colors.black : Colors.grey.shade600,
          fontSize: isBold ? 16 : 14,
        ),
      ),
    );
  }
}
void _showMinimizeAlertDialog(BuildContext context, List<String> values,List<List<int>> matrixFull) {
  Norwest northwest = Norwest();
  List<TextEditingController> textControllers = List.generate(values.length, (index) => TextEditingController());
  List<int> costos = [];

  AlertDialog alertDialog = AlertDialog(
    title: Text('Lista Distributiva'),
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // (oferta)
        for (int i = 0; i < matrixArists.length; i++)
          if (matrixArists[i].any((value) => value != 0))
            Row(
              children: [
                Text('${values[i]} => '),
                Expanded(
                  child: TextField(
                    controller: textControllers[i],
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),

        // (demanda)
        for (int col = 0; col < matrixArists[0].length; col++)
          if (matrixArists.any((row) => row[col] != 0))
            Row(
              children: [
                Text('${values[col]} => '),
                Expanded(
                  child: TextField(
                    controller: textControllers[col],
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
      ],
    ),
    actions: <Widget>[
      TextButton(
        child: Text('Calcular'),
        onPressed: () {
          List<int> oferta = []; // Lista para almacenar la oferta
          List<int> demanda = []; // Lista para almacenar la demanda
          //print('$textControllers');

          for (int col = 0; col < matrixArists[0].length; col++)
            if (matrixArists.any((row) => row[col] != 0)) {
              String endNode = textControllers[col].text;
              int value = int.tryParse(endNode) ?? 0;
              demanda.add(value);
            }
          for (int i = 0; i < matrixArists.length; i++)
            if (matrixArists[i].any((value) => value != 0)) {
              String endNode = textControllers[i].text;
              int value = int.tryParse(endNode) ??
                  0; // Valor ingresado en el campo de texto
              oferta.add(value); // Es demanda
            }

          // Ahora tienes las listas 'oferta' y 'demanda' con los valores correspondientes.
          print('Oferta: $oferta');
          print('Demanda: $demanda');

          //List<String> ofertaS = oferta.map((value) => value.toString()).toList();
          //List<String> demandaS = demanda.map((value) => value.toString()).toList();

          // Filtrar la matriz para eliminar los elementos iguales a 0
          /*List<List<int>> matrizFiltrada = matrixFull.map((fila) {
            return fila.where((elemento) => elemento != 0).toList();
          }).toList();

       // Imprimir la matriz original y la matriz filtrada
          print('Matriz Original: $matrixFull');
          print('Matriz Filtrada: $matrizFiltrada');*/


          /*List<List<String>> matrixAristsStrings = matrixFull
              .map((row) => row.map((value) => value.toString()).toList())
              .toList();*/
          //print('Matriz Original: $matrixFull');



          List<String> rows = [];
          List<String> columns = [];
          List<List<int>> reducedMatrix = [];
          // Encuentra las filas con datos no nulos
          for (int row = 0; row < matrixFull.length; row++) {
            bool hasData = matrixFull[row].any((value) => value != 0);
            if (hasData) {
              rows.add(values[row]);
            }
          }
          // Encuentra las columnas con datos no nulos
          for (int col = 0; col < matrixFull[0].length; col++) {
            bool hasData = matrixFull.any((row) => row[col] != 0);
            if (hasData) {
              columns.add(values[col]);
            }
          }
          // Redefine reducedMatrix con solo las filas y columnas con datos no nulos
          reducedMatrix = matrixFull
              .where((row) => row.any((value) => value != 0))
              .map((row) => row.where((value) => value != 0).toList())
              .toList();
          print('Matriz Original: $reducedMatrix');

          ResultadoNorwest resultado = northwest.calcNorwest(reducedMatrix, oferta, demanda);
          List<List<int>> matrizResultado = resultado.matriz;
          int sumatoria = resultado.sumatoria;
          //print('Matriz: $resultado');

          AlertDialog resultDialog = AlertDialog(
            title: Text('Resultado de Norwest'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Mostrar la matriz resultante
                ...matrizResultado.map((row) {
                  return Row(
                    children: row.map((cell) {
                      return Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Text('$cell\t'),
                      );
                    }).toList(),
                  );
                }).toList(),

                // Mostrar el costo total
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text('Costo Total: $sumatoria'),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Cerrar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
;
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return resultDialog;
            },
          );

        },
      ),
      TextButton(
        child: Text('Cerrar'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alertDialog;
    },
  );
}
