import 'package:flutter/material.dart';
import 'package:proyecto_grafos/algorithms/NorthW/Clases%20north/modelo_aristaN.dart';

import 'package:proyecto_grafos/algorithms/NorthW/norwest.dart';
import 'Clases north/matriz.dart';
import 'Clases north/modelo_nodoN.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext context;


  CustomAppBar({required this.context});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  List<String> demanda = [];
  List<String> oferta = [];
  List<ModeloAristaN> vLineas = [];

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
        'Graficador de Grafos - Algoritmo NorthWest',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w100,
          fontFamily: 'Roboto',
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 11, 171, 236),
      elevation: 5,
    );
  }











}









