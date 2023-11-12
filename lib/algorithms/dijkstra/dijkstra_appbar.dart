import 'package:flutter/material.dart';
import 'package:proyecto_grafos/algorithms/dijkstra/selection_max.dart';
import 'package:proyecto_grafos/algorithms/dijkstra/selection_min.dart';
import 'package:proyecto_grafos/matriz.dart';
// Importa otros paquetes si son necesarios

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final BuildContext context;

  CustomAppBar({required this.context});

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  String? selectedStartValue;
  String? selectedEndValue;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(widget.context).pop();
        },
      ),
      title: Text(
        'Algoritmo de Dijkstra',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: 'Roboto',
          letterSpacing: 1.5,
        ),
      ),
      backgroundColor: Color.fromARGB(255, 66, 96, 5),
      elevation: 5,
      actions: <Widget>[
        PopupMenuButton<String>(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Algoritmos',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          itemBuilder: (BuildContext context) {
            return {'Minimizar Dijkstra', 'Maximizar Dijkstra'}
                .map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
          onSelected: (String choice) {
            if (choice == 'Minimizar Dijkstra') {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SelectionDialog(
                    values: values,
                    selectedStartValue:
                        selectedStartValue, // Valor de inicio previamente seleccionado
                    selectedEndValue:
                        selectedEndValue, // Valor de final previamente seleccionado
                    onSelected: (String? newStartValue, String? newEndValue) {
                      setState(() {
                        selectedStartValue =
                            newStartValue; // Actualiza el valor de inicio seleccionado
                        selectedEndValue =
                            newEndValue; // Actualiza el valor de final seleccionado
                      });
                    },
                  );
                },
              );

            } else if (choice == 'Maximizar Dijkstra') {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SelectionDialog2(
                    values: values,
                    selectedStartValue:
                        selectedStartValue, // Valor de inicio previamente seleccionado
                    selectedEndValue:
                        selectedEndValue, // Valor de final previamente seleccionado
                    onSelected: (String? newStartValue, String? newEndValue) {
                      setState(() {
                        selectedStartValue =
                            newStartValue; // Actualiza el valor de inicio seleccionado
                        selectedEndValue =
                            newEndValue; // Actualiza el valor de final seleccionado
                      });
                    },
                  );
                },
              );
            } 
          },
        ),
      ],
    );
  }
}
