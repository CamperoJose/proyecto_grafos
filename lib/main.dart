import 'package:flutter/material.dart';
import 'package:proyecto_grafos/home.dart';
import 'package:proyecto_grafos/home_page.dart';

void main() {
  // Esta línea elimina el banner de "DEBUG"
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Graph Concepts',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: Home(),
      home: HomePage(),
    );
  }
  
}

