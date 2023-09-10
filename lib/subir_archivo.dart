import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class SubirArchivoPage extends StatefulWidget {
  @override
  _SubirArchivoPageState createState() => _SubirArchivoPageState();
}

class _SubirArchivoPageState extends State<SubirArchivoPage> {
  List<FileSystemEntity> archivos = [];

  @override
  void initState() {
    super.initState();
    _listarArchivos();
  }

  Future<void> _listarArchivos() async {
    final directory = await getApplicationDocumentsDirectory();
    setState(() {
      archivos = Directory(directory.path).listSync();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Archivos Descargados'),
      ),
      body: archivos.isEmpty
          ? Center(
              child: Text('No hay archivos descargados.'),
            )
          : ListView.builder(
              itemCount: archivos.length,
              itemBuilder: (context, index) {
                final archivo = archivos[index];
                return ListTile(
                  title: Text(archivo.uri.pathSegments.last),
                  onTap: () {
                    // Aquí puedes agregar la lógica para abrir o gestionar el archivo.
                  },
                );
              },
            ),
    );
  }
}
