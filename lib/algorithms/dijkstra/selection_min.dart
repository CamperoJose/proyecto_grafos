import 'package:flutter/material.dart';
import 'package:proyecto_grafos/algorithms/dijkstra/dijkstra_minimo.dart';
import 'package:proyecto_grafos/algorithms/dijkstra/dijkstra_view.dart';
import 'package:proyecto_grafos/matriz.dart';

class SelectionDialog extends StatefulWidget {
  final List<String> values;
  final String? selectedStartValue;
  final String? selectedEndValue;
  final Function(String?, String?) onSelected;

  SelectionDialog({
    Key? key,
    required this.values,
    this.selectedStartValue,
    this.selectedEndValue,
    required this.onSelected,
  }) : super(key: key);

  @override
  _SelectionDialogState createState() => _SelectionDialogState();
}

class _SelectionDialogState extends State<SelectionDialog> {
  String? localSelectedStartValue;
  String? localSelectedEndValue;

  final Color deepPurpleColor =
      Colors.deepPurple; // Definición del color morado oscuro

  @override
  void initState() {
    super.initState();
    localSelectedStartValue = widget.selectedStartValue;
    localSelectedEndValue = widget.selectedEndValue;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Selecciona un valor de Inicio y otro de Final',
        style: TextStyle(
            color: deepPurpleColor,
            fontWeight: FontWeight.bold), // Uso del color morado oscuro
      ),
      content: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Selecciona el Inicio:',
                      style: TextStyle(color: deepPurpleColor)),
                  ...widget.values.map((String value) {
                    return RadioListTile<String>(
                      title: Text(value),
                      value: value,
                      groupValue: localSelectedStartValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          localSelectedStartValue = newValue;
                        });
                      },
                      activeColor: deepPurpleColor,
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 70,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Selecciona el Final:',
                      style: TextStyle(color: deepPurpleColor)),
                  ...widget.values.map((String value) {
                    return RadioListTile<String>(
                      title: Text(value),
                      value: value,
                      groupValue: localSelectedEndValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          localSelectedEndValue = newValue;
                        });
                      },
                      activeColor: deepPurpleColor,
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancelar', style: TextStyle(color: deepPurpleColor)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          child: Text('Aceptar'),
          style: ElevatedButton.styleFrom(
            primary: deepPurpleColor, // Uso del color morado oscuro
          ),
          onPressed: () {
            print("localSelectedStartValue: $localSelectedStartValue");
            print("localSelectedEndValue: $localSelectedEndValue");

            opKruskal = 1;
            Graph g = Graph();
            auxDijkstra = [];

            for (int i = 0; i < matrixArists.length; i++) {
              for (int j = 0; j < matrixArists.length; j++) {
                if (matrixArists[i][j] != 0) {
                  g.addEdge(values[i], values[j], matrixArists[i][j]);
                }
              }
            }

            auxDijkstra =
                g.dijkstra(localSelectedStartValue!, localSelectedEndValue!);

            //calculo de sumatoria con aux:
            sumaDijkstra = 0;
            for (int i = 0; i < auxDijkstra.length; i++) {
              //posicion de values:
              int pos1 = values.indexOf(auxDijkstra[i][0]);
              int pos2 = values.indexOf(auxDijkstra[i][1]);
              sumaDijkstra = sumaDijkstra + matrixArists[pos1][pos2];
            }

            print("auxDijkstra: $auxDijkstra");

            Navigator.push(context,
                MaterialPageRoute(builder: (context) => DijkstraView()));
          },
        ),
      ],
    );
  }
}
