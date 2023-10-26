import 'package:flutter/material.dart';
import 'package:proyecto_grafos/algorithms/compete/custome_button.dart';
import 'package:proyecto_grafos/algorithms/jhonson.dart';
import 'package:proyecto_grafos/algorithms/jhonson/jhonson2.dart';
import 'package:proyecto_grafos/algorithms/jhonson/jhonson_view.dart';
import 'package:proyecto_grafos/data.dart';
import 'package:proyecto_grafos/matriz.dart';

class CustomAppBarCompete extends StatelessWidget
    implements PreferredSizeWidget {
  final BuildContext context;

  CustomAppBarCompete({required this.context});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(this.context).pop();
        },
      ),
      title: const Text(
        'Algoritmo de compete',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w100,
          fontFamily: 'Roboto',
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 102, 0, 0),
      elevation: 5,
      actions: <Widget>[
        PopupMenuButton<String>(
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Algoritmos',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          itemBuilder: (BuildContext context) {
            return {'Calcular Centroide'}.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
          onSelected: (String choice) {
            if (choice == 'Calcular Centroide') {
              valoresx.add(valoresx[0]);
              valoresy.add(valoresy[0]);

              //calculando centroide con un ciclo while con el algoritmo de compete:
              while (!sonIguales()) {
                print("valores de x: $valoresx");
                print("valores de y: $valoresy");

                double prevX = valoresx[1];
                double prevY = valoresy[1];

                for (int j = 0; j < valoresx.length - 1; j++) {
                  double variableX = -1;
                  double variableY = -1;
                  variableX = (valoresx[j] + valoresx[j + 1]) / 2;
                  //valoresx[j] = round(variableX, 5);
                  //redondear a 5 decimales:
                  valoresx[j] = double.parse((variableX).toStringAsFixed(5));
                  variableY = (valoresy[j] + valoresy[j + 1]) / 2;
                  valoresy[j] = double.parse((variableY).toStringAsFixed(5));
                }

                //para el ultimon nodo:
                double variableX = -1;
                double variableY = -1;
                variableX = (valoresx[valoresx.length - 1] + prevX) / 2;
                valoresx[valoresx.length - 1] =
                    double.parse((variableX).toStringAsFixed(5));
                variableY = (valoresy[valoresy.length - 1] + prevY) / 2;
                valoresy[valoresy.length - 1] =
                    double.parse((variableY).toStringAsFixed(5));
              }
              print("valores de x: $valoresx");
              print("valores de y: $valoresy");

              //mostrar valores de las listas valoresx y valoresy en un alert dialog:
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ), // Borde redondeado
                    elevation: 5,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Valores del Centroide',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20), // Espaciado
                          SingleChildScrollView(
                            child: DataTable(
                              headingTextStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              columns:
                                  List.generate(valoresx.length * 2, (index) {
                                return DataColumn(
                                  label: Text(index.isEven
                                      ? 'x${index ~/ 2 + 1}'
                                      : 'y${index ~/ 2 + 1}'),
                                );
                              }),
                              rows: [
                                DataRow(
                                  cells: List.generate(valoresx.length * 2,
                                      (index) {
                                    return DataCell(
                                      Text(
                                        index.isEven
                                            ? '${valoresx[index ~/ 2]}'
                                            : '${valoresy[index ~/ 2]}',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                                // ... Agrega más filas si es necesario
                              ],
                            ),
                          ),
                          SizedBox(height: 20), // Espaciado
                          CustomButton(),

                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ],
    );
  }

  bool sonIguales() {
    bool ans = true;
    for (int k0 = 0; k0 < valoresx.length - 1; k0++) {
      if (valoresx[k0] != valoresx[k0 + 1]) {
        ans = false;
        break;
      }
      if (valoresy[k0] != valoresy[k0 + 1]) {
        ans = false;
        break;
      }
    }
    return ans;
  }
}
