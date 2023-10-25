

import 'package:flutter/material.dart';
import 'package:proyecto_grafos/algorithms/jhonson.dart';
import 'package:proyecto_grafos/algorithms/jhonson/jhonson2.dart';
import 'package:proyecto_grafos/algorithms/jhonson/jhonson_view.dart';
import 'package:proyecto_grafos/matriz.dart';

class CustomAppBarCompete extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext context;

  CustomAppBarCompete({required this.context});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(this.context).pop();
        },
      ),
      title: Text(
        'Algoritmo de compete',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w100,
          fontFamily: 'Roboto',
        ),
      ),
      backgroundColor: Color.fromARGB(255, 102, 0, 0),
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
            return {'Calcular Centroide'}.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
          onSelected: (String choice) {
            if (choice == 'Calcular Centroide') {


            }
          },
        ),
      ],
    );
  }


}
