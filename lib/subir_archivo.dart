import 'dart:convert';
import 'dart:html'
    as html; // Para interactuar con el sistema de archivos del cliente.
import 'package:flutter/material.dart';
import 'package:proyecto_grafos/classes/modelo_arista.dart';
import 'package:proyecto_grafos/classes/modelo_nodo.dart';
import 'package:proyecto_grafos/matriz.dart';

import 'data.dart';

Future<void> subirArchivo(BuildContext context) async {
  final html.InputElement input = html.InputElement()
    ..type = 'file'
    ..accept = 'application/json'; // Limita la selección de archivos a JSON
  input.click(); // Abre el cuadro de diálogo de selección de archivos

  await input.onChange.first; // Espera hasta que se seleccione un archivo

  final html.File file = input.files!.first;
  final html.FileReader reader = html.FileReader();

  reader.readAsText(file);

  await reader.onLoad.first; // Espera hasta que se lea el archivo

  final String content = reader.result as String;

  try {
    final Map<String, dynamic> jsonData = jsonDecode(content);

    // creando isntancia de ModeloNodo:
    vNodo = [];
    for (var item in jsonData['vNodo']) {
      vNodo.add(ModeloNodo.fromJson(item));
    }

    vUniones = [];
    for (var item in jsonData['vUniones']) {
      ModeloArista a = ModeloArista(
          item['idNodoInicial'],
          item['idNodoFinal'],
          item['xinicio'],
          item['yinicio'],
          item['xfinal'],
          item['yfinal'],
          item['peso'],
          item['ida'],
          item['dirigido']);
      print(a);
      vUniones.add(a);
    }

    values = [];
    for (var item in jsonData['values']) {
      print(item);
      values.add(item);
    }

    // crear la matrioz matrixTrueFalse de tamaño jsonData['matrixTrueFalse']:
    matrixTrueFalse = List.generate(
        jsonData['matrixTrueFalse'].length,
        (i) => List.generate(jsonData['matrixTrueFalse'].length, (j) => 0,
            growable: true),
        growable: true);

    for (int i = 0; i < jsonData['matrixTrueFalse'].length; i++) {
      for (int j = 0; j < jsonData['matrixTrueFalse'].length; j++) {
        if (jsonData['matrixTrueFalse'][i][j] == 1) {
          matrixTrueFalse[i][j] = 1;
        } else {
          matrixTrueFalse[i][j] = 0;
        }
      }
    }

    matrixArists = List.generate(
        jsonData['matrixArists'].length,
        (i) => List.generate(jsonData['matrixArists'].length, (j) => 0,
            growable: true),
        growable: true);

    for (int i = 0; i < jsonData['matrixArists'].length; i++) {
      for (int j = 0; j < jsonData['matrixArists'].length; j++) {
        matrixArists[i][j] = jsonData['matrixArists'][i][j];
      }
    }

    xinicial = jsonData['xinicial'];
    xfinal = jsonData['xfinal'];
    yinicial = jsonData['yinicial'];
    yfinal = jsonData['yfinal'];
    idInicial = jsonData['idInicial'];

    joinModo = jsonData['joinModo'];

    nodoInicial = ModeloNodo.fromJson(jsonData['nodoInicial']);

    setState() {}

    // Realiza la asignación de datos necesaria

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Archivo Cargado'),
          content: Text(
              'El archivo JSON se ha cargado con éxito y los datos se han asignado a las variables.'),
          //content: Text(vUniones.toString()),
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
          content: Text('Error al cargar el archivo JSON: $e'),
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
