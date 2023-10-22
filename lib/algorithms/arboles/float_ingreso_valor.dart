
import 'package:flutter/material.dart';

void showIngresoValorDialog(BuildContext context, Function(int) onValorIngresado) {
  TextEditingController valorController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255), // Fondo con un tono azul grisáceo
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        title: Text(
          "Ingresa un Valor",
          style: TextStyle(
            color: const Color.fromARGB(255, 0, 0, 0), // Texto en color blanco
            fontSize: 24.0,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: valorController,
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.black), // Texto en color negro
              decoration: InputDecoration(
                hintText: "Escribe un número",
                hintStyle: TextStyle(color: Colors.grey), // Texto de sugerencia en gris
              ),
            ),
          ],
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              String valorIngresado = valorController.text;
              if (valorIngresado.isNotEmpty) {
                onValorIngresado(int.parse(valorIngresado));
                valorController.clear();
              }
              Navigator.of(context).pop();
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.green), // Botón en verde
            ),
            child: Text(
              "Aceptar",
              style: TextStyle(
                color: Colors.white, // Texto en color blanco
                fontSize: 18.0,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              primary: Colors.red, // Texto en rojo
            ),
            child: Text(
              "Cancelar",
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ),
        ],
      );
    },
  );
}
