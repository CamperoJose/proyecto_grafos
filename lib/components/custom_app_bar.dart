import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext context;

  CustomAppBar({required this.context});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back), // Icono de flecha de retroceso
        onPressed: () {
          Navigator.of(this.context).pop(); // Utiliza el context proporcionado para la navegación
        },
      ),
      title: Text(
        'Graficador de Grafos - Los Iluminati',
        style: TextStyle(
          fontSize: 20, // Tamaño de fuente reducido
          fontWeight: FontWeight.w100,
          fontFamily: 'Roboto',
        ),
      ),
      backgroundColor: Colors.lightBlue.shade900,
      elevation: 5,
    );
  }
}
