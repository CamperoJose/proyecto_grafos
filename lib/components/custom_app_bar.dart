import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'GraphDesigner',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
      ),
      backgroundColor: Colors.pink.shade900,
      elevation: 8,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 20),
          child: PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'generateMatrix') {
                // Agrega la funcionalidad para "Generar matriz" aquí
              } else if (value == 'goToMenu') {
                // Agrega la funcionalidad para "Volver al menú" aquí
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'generateMatrix',
                  child: Text('Generar matriz'),
                ),
                PopupMenuItem<String>(
                  value: 'goToMenu',
                  child: Text('Volver al menú'),
                ),
              ];
            },
          ),
        ),
      ],
    );
  }
}