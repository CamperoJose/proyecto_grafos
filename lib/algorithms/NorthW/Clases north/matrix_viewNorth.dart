import 'package:flutter/material.dart';
import 'package:proyecto_grafos/algorithms/NorthW/Clases%20north/matriz.dart';

void main() => runApp(MaterialApp(home: MatrixView()));

class MatrixView extends StatelessWidget {
  List<String> textValuesColumns = List.generate(values.length, (index) => "",);
  List<String> textValuesRow = List.generate(values.length, (index) => "",);

  List<List<String>> textValues = List.generate(values.length, (_) => List.filled(values.length, ''));
  List<List<TextEditingController>> textControllers = List.generate(values.length, (_) => List.filled(values.length, TextEditingController()));
  List<List<int>> matrix = List.generate(values.length, (_) => List.filled(values.length, 0));
  List<String> letras= values;

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
                print('Matriz reducida:$values');
                _showMinimizeAlertDialog(context, values);
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
void _showMinimizeAlertDialog(BuildContext context, List<String> values) {
  if (values.length % 2 != 0) {
    AlertDialog errorDialog = AlertDialog(
      title: Text('Error'),
      content: Text('La lista no tiene un número par de elementos.'),
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
        return errorDialog;
      },
    );
    return;
  }

  List<TextEditingController> textControllers = List.generate(values.length, (index) => TextEditingController());

  AlertDialog alertDialog = AlertDialog(
    title: Text('Lista Distributiva'),
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < values.length ; i++)
          Row(
            children: [
              Text('${values[i]} => '),
              Expanded(
                child: TextField(
                  controller: textControllers[i],
                  keyboardType: TextInputType.text,
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
          print('Matriz reducida:$textControllers');
          // Aquí puedes acceder a los valores ingresados en los campos de texto y realizar el cálculo necesario.
          for (int i = 0; i < values.length ; i++) {
            String startNode = values[i];
            String endNode = textControllers[i].text;
            // Realiza el cálculo o procesamiento de los datos según tus necesidades.
            // Puedes mostrar los resultados en otro AlertDialog o de la manera que desees.
          }
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

List<Widget> _generateDistributiveList(List<String> values) {
  List<Widget> distributiveList = [];
  int halfLength = values.length ~/ 2;

  for (int i = 0; i < halfLength; i++) {
    for (int j = halfLength; j < values.length; j++) {
      distributiveList.add(Text('${values[i]} => ${values[j]}'));
    }
  }

  return distributiveList;
}



//edicion 1




