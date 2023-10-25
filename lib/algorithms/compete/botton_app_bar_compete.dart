import 'package:flutter/material.dart';

class MyBottomAppBar extends StatelessWidget {
  final int modo;
  final int joinModo;
  final Function(int) onTap;

  MyBottomAppBar({
    required this.modo,
    required this.joinModo,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: const Color.fromARGB(255, 102, 0, 0),
      elevation: 8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildIconButton(Icons.add_circle_outline_sharp, "Agregar Nodo", 1),

        ],
      ),
    );
  }

  Widget buildIconButton(IconData icon, String label, int newMode) {
    return InkWell(
      onTap: () {
        onTap(newMode);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 30,
            color: modo == newMode ? Colors.green : Colors.white,
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: modo == newMode ? Colors.green : Colors.white,
            ),
          ),
        ],
     ),
    );
  }
}
