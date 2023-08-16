import 'package:flutter/material.dart';

import '../matriz.dart';

class MatrixView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Matrices de Adyacencia'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionTitle('Matriz de Adyacencia True/False:'),
            SizedBox(height: 8),
            MatrixTable(matrix: matrixTrueFalse, values: values),
            SizedBox(height: 24),
            _SectionTitle('Matriz de Aristas:'),
            SizedBox(height: 8),
            MatrixTable(matrix: matrixArists, values: values),
          ],
        ),
      ),
    );
  }
}

class MatrixTable extends StatelessWidget {
  final List<List<int>> matrix;
  final List<String> values;

  MatrixTable({required this.matrix, required this.values});

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultColumnWidth: FixedColumnWidth(48),
      border: TableBorder.all(width: 1.0, color: Colors.grey),
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: Colors.blueGrey.withOpacity(0.2),
          ),
          children: [
            TableCell(child: Container()), // Celda vacía en la esquina superior izquierda
            ...values.map((value) {
              return _TableCell(value);
            }).toList(),
          ],
        ),
        ...matrix.asMap().entries.map((entry) {
          int rowIndex = entry.key;
          List<int> rowValues = entry.value;

          return TableRow(
            children: [
              _TableCell(values[rowIndex], isHeader: true),
              ...rowValues.map((value) {
                return _TableCell(value.toString());
              }).toList(),
            ],
          );
        }).toList(),
      ],
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
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}

class _TableCell extends StatelessWidget {
  final String text;
  final bool isHeader;

  _TableCell(this.text, {this.isHeader = false});

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        alignment: isHeader ? Alignment.center : Alignment.centerLeft,
        child: Text(
          text,
          style: TextStyle(fontWeight: isHeader ? FontWeight.bold : FontWeight.normal),
        ),
      ),
    );
  }
}
