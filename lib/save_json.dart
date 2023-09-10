import 'dart:html' as html;
import 'dart:typed_data';
import 'dart:convert'; // Importa 'dart:convert'
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:proyecto_grafos/matriz.dart';

Future<void> crearArchivoEnCarpeta(String filename, dynamic contenido, context) async {
  try {
    final jsonString = jsonEncode(contenido); // Convierte el objeto JSON a una cadena JSON

    final bytes = Uint8List.fromList(utf8.encode(jsonString)); // Convierte la cadena JSON en bytes UTF-8

    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);

    final anchor = html.AnchorElement(href: url)
      ..target = 'webdownload'
      ..download = filename
      ..click();

    html.Url.revokeObjectUrl(url);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Archivo Guardado'),
          //content: Text('El archivo $filename se ha guardado con éxito en la carpeta de descargas.'),
          content: Text(vUniones.toString()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Aceptar'),
            ),
          ],
        );
      },
    );
  } catch (e) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Error al guardar el archivo: $e'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }
}
