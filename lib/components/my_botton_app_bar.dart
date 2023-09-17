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
      color: Colors.lightBlue.shade900,
      elevation: 8, // Agregamos una sombra
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 1; i <= 6; i++)
            Expanded(
              child: InkWell(
                onTap: () {
                  onTap(i);
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: _getBorderRadiusForMode(i),
                    color: modo == i ? Colors.white : Colors.transparent,
                    boxShadow: modo == i
                        ? [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ]
                        : null, // Agregamos sombra cuando está seleccionado
                  ),
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: _getBorderRadiusForMode(i),
                      color: modo == i ? Colors.white : Colors.lightBlue.shade900,
                    ),
                    child: Icon(
                      _getIconForMode(i),
                      size: modo == i ? 40 : 30,
                      color: modo == i ? Colors.green : Colors.red,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  BorderRadius _getBorderRadiusForMode(int mode) {
    switch (mode) {
      case 1:
        return BorderRadius.only(bottomRight: Radius.circular(30), bottomLeft: Radius.circular(30));
      case 2:
        return BorderRadius.only(bottomRight: Radius.circular(30), bottomLeft: Radius.circular(30));
      case 3:
        return BorderRadius.only(bottomRight: Radius.circular(30), bottomLeft: Radius.circular(30));
      case 4:
        return BorderRadius.only(bottomRight: Radius.circular(30), bottomLeft: Radius.circular(30));
      case 5:
        return BorderRadius.only(bottomRight: Radius.circular(30), bottomLeft: Radius.circular(30));
      case 6:
        return BorderRadius.only(bottomRight: Radius.circular(30), bottomLeft: Radius.circular(30));
      default:
        return BorderRadius.zero;
    }
  }

  IconData _getIconForMode(int mode) {
    switch (mode) {
      case 1:
        return Icons.add_circle_outline_sharp;
      case 2:
        return Icons.delete;
      case 3:
        return Icons.move_down_rounded;
      case 4:
        return Icons.linear_scale_outlined;
      case 5:
        return Icons.edit;
      case 6:
        return Icons.wind_power;
      default:
        return Icons.cleaning_services_rounded;
    }
  }

  Color _getColorForMode(int mode) {
    if (mode == 4 && joinModo == 1) {
      return Colors.green;
    } else if (mode == 4 && joinModo == 2) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
}
