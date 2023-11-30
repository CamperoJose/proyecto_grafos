import 'package:flutter/material.dart';
import 'package:proyecto_grafos/algorithms/NorthW/Clases%20north/matriz.dart';

class ResultadoPantalla extends StatelessWidget {
  final List<List<int>> solucionMinimizacion;
  final List<List<int>> solucionMaximizacion;
  final double sumaMinimizacion;
  final double sumaMaximizacion;

  ResultadoPantalla({
    required this.solucionMinimizacion,
    required this.solucionMaximizacion,
    required this.sumaMinimizacion,
    required this.sumaMaximizacion,
  });

  @override
  Widget build(BuildContext context) {
    // Ajuste para eliminar la última fila y columna de las soluciones
    List<List<int>> solucionMinimizacionReducida =
        solucionMinimizacion.sublist(0, solucionMinimizacion.length - 1);
    solucionMinimizacionReducida.forEach((row) {
      row.removeLast();
    });

    List<List<int>> solucionMaximizacionReducida =
        solucionMaximizacion.sublist(0, solucionMaximizacion.length - 1);
    solucionMaximizacionReducida.forEach((row) {
      row.removeLast();
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Resultados'),
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Solución óptima minimización
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(
                    "Solución óptima minimización: $solucionMinimizacionReducida con una suma de $sumaMinimizacion",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  // Mostrar iteraciones de minimización con ciclo for:
                  Column(
                    children: solucionMinimizacionReducida
                        .asMap()
                        .entries
                        .map(
                          (entry) => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: entry.value
                                .asMap()
                                .entries
                                .map(
                                  (innerEntry) => (innerEntry.value != 0)
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                                "Desde ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                )),

                                            Container(
                                              padding: EdgeInsets.all(8),
                                              margin: EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.green,
                                              ),
                                              child: Text(
                                                "${values[entry.key]}",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),

                                            Text(
                                                " al ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                )),



                                            Container(
                                              padding: EdgeInsets.all(8),
                                              margin: EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.green,
                                              ),
                                              child: Text(
                                                "${values[innerEntry.key+ solucionMinimizacion.length -1]}",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Text(
                                                " con valor ${innerEntry.value}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                )),

                                            Text(
                                                " \t\t ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                )),
                                          ],
                                        )
                                      : Container(), // Omitir valores cero
                                )
                                .toList(),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Solución óptima maximización
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.orange, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(
                    "Solución óptima maximización: $solucionMaximizacionReducida con una suma de $sumaMaximizacion",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  // Mostrar iteraciones de maximización con ciclo for:
                  Column(
                    children: solucionMaximizacionReducida
                        .asMap()
                        .entries
                        .map(
                          (entry) => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: entry.value
                                .asMap()
                                .entries
                                .map(
                                  (innerEntry) => (innerEntry.value != 0)
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                                "Desde ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                )),

                                            Container(
                                              padding: EdgeInsets.all(8),
                                              margin: EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.red,
                                              ),
                                              child: Text(
                                                "${values[entry.key]}",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),

                                            Text(
                                                " al ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                )),



                                            Container(
                                              padding: EdgeInsets.all(8),
                                              margin: EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.red,
                                              ),
                                              child: Text(
                                                "${values[innerEntry.key+ solucionMinimizacion.length -1]}",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Text(
                                                " con valor ${innerEntry.value}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                )),

                                            Text(
                                                " \t\t ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                )),
                                          ],
                                        )
                                      : Container(), // Omitir valores cero
                                )
                                .toList(),
                          ),
                        )
                        .toList(),

                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
