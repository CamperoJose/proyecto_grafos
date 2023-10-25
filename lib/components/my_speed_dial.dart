import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:proyecto_grafos/generar_estructura_json.dart';
import 'package:proyecto_grafos/save_json.dart';
import 'package:proyecto_grafos/subir_archivo.dart';
import 'package:proyecto_grafos/views/matrix_view.dart';
import 'package:url_launcher/url_launcher.dart';

class MySpeedDial extends StatelessWidget {
  MySpeedDial(context);
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.view_list,
      animatedIconTheme: IconThemeData(size: 22.0),
      backgroundColor: Colors.lightBlue.shade900,
      visible: true,
      children: [
        SpeedDialChild(
          child: Icon(Icons.table_chart_outlined),
          backgroundColor: Colors.orange.shade600,
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MatrixView()));
          },
          label: 'Generar Matriz',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.orange.shade600,
        ),
        SpeedDialChild(
          child: Icon(Icons.download_sharp),
          backgroundColor: Colors.red.shade800,
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                String nuevoNombre =
                    ''; // Variable para almacenar el nuevo nombre de archivo.

                return AlertDialog(
                  title: const Text('Ingrese el nombre del archivo:'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        onChanged: (text) {
                          nuevoNombre =
                              text; // Actualizar el nuevo nombre cuando el usuario escriba.
                        },
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    ElevatedButton(
                      child: const Text('Aceptar'),
                      onPressed: () {
                        if (nuevoNombre.isNotEmpty) {
                          crearArchivoEnCarpeta('$nuevoNombre.json',
                              generarEstructuraJson(), context);
                        }
                      },
                    ),
                  ],
                );
              },
            );
          },
          label: 'Descargar Grafo',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.red.shade800,
        ),
        SpeedDialChild(
          child: Icon(Icons.upload),
          backgroundColor: Colors.green.shade500,
          onTap: () {
            subirArchivo(context);
          },
          label: 'Subir Grafo',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.green.shade500,
        ),
        SpeedDialChild(
          child: Icon(Icons.book_sharp),
          backgroundColor: Colors.purple.shade400,
          onTap: () async {
            //leer pdf desde el link https://drive.google.com/file/d/1FJhjMdhmGixprzqlrxElGh0gt0edK_aM/view?usp=sharing:
            const url =
                'https://drive.google.com/file/d/19imkscGGA0olIuq7-ZACbOErM0rvUJnU/view?usp=sharing';
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              throw 'No se pudo abrir el PDF';
            }
          },
          label: 'Manual',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.purple.shade400,
        ),
      ],
    );
  }
}
