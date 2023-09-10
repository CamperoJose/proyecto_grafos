import 'dart:html' as html; // Importa 'dart:html' con un alias
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

Future<void> crearArchivoEnCarpeta(String filename, String contenido, context) async {
  try {
    final bytes = Uint8List.fromList(contenido.codeUnits);

    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);

    final anchor = html.AnchorElement(href: url)
      ..target = 'webdownload' // Utiliza un atributo target para que se abra en una nueva ventana
      ..download = filename
      ..click();

    html.Url.revokeObjectUrl(url);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Archivo Guardado'),
          content: Text('El archivo $filename se ha guardado con éxito en la carpeta de descargas.'),
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