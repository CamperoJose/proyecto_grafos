import 'package:flutter/material.dart';

import '../../../matriz.dart';

void main() => runApp(MaterialApp(home: MatrixView()));

class MatrixView extends StatelessWidget {
  List<List<String>> textValues =
  List.generate(matrixArists.length, (_) => List.filled(values.length, ''));
  List<List<TextEditingController>> textControllers =
  List.generate(matrixArists.length, (_) => List.filled(values.length, TextEditingController()));

  @override
  Widget build(BuildContext context) {
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
                showMinimizeAlertDialog(context, textControllers);
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
                ...values.map((value) {
                  return _TableCell(value, isHeader: true);
                }),
                _TableCell('', isHeader: true),
              ],
            ),
            ...matrix.asMap().entries.map((entry) {
              int rowIndex = entry.key;
              List<int> rowValues = entry.value;

              return TableRow(
                children: [
                  _TableCell(values[rowIndex], isHeader: true),
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
                  _AddTextCell(textControllers[rowIndex][values.length - 1]),
                ],
              );
            }).toList(),
            TableRow(
              children: [
                _TableCell('', isHeader: true),
                ...values.map((value) {
                  return _AddTextCell(textControllers[matrix.length - 1][values.indexOf(value)]);
                }),
                _TableCell('', isHeader: true),
              ],
            ),
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

class _AddTextCell extends StatelessWidget {
  final TextEditingController controller;

  _AddTextCell(this.controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      alignment: Alignment.center,
      color: Colors.white,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.all(0),
        ),
      ),
    );
  }
}

void showMinimizeAlertDialog(BuildContext context, List<List<TextEditingController>> textControllers) {
  List<List<String>> textData = [];

  for (int rowIndex = 0; rowIndex < textControllers.length; rowIndex++) {
    List<String> rowData = [];
    for (int columnIndex = 0; columnIndex < textControllers[rowIndex].length; columnIndex++) {
      String value = textControllers[rowIndex][columnIndex].text;
      rowData.add(value);
    }
    textData.add(rowData);
  }

  AlertDialog alertDialog = AlertDialog(
    title: Text('Datos de TextFields'),
    content: Column(
      children: textData.map((rowData) {
        return Row(
          children: rowData.map((value) {
            return Expanded(
              child: Text(value),
            );
          }).toList(),
        );
      }).toList(),
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

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alertDialog;
    },
  );
}
