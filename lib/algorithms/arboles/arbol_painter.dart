import 'package:flutter/material.dart';
import 'nodo.dart';
import 'arbol.dart';

class ArbolPainter extends CustomPainter {
  Arbol objArbol = Arbol();
  static final double diametro = 25;
  static final double radio = diametro / 2;
  static final double ancho = 60; // Aumentamos el ancho para espacio adicional

  ArbolPainter(Arbol obj) {
    this.objArbol = obj;
  }

  @override
  void paint(Canvas canvas, Size size) {
    pintar(canvas, size.width / 2, 50, objArbol.raiz);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  void pintar(Canvas canvas, double x, double y, Nodo? n) {
    if (n == null) {
      return;
    }

    final circlePaint = Paint()
      ..color = Colors.purple.shade400
      ..style = PaintingStyle.fill;

    final linePaint = Paint()
      ..color = Colors.grey.shade600
      ..strokeWidth = 2.0; // Aumentamos el grosor de las líneas

    final textPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final textStyle = TextStyle(
      color: const Color.fromARGB(255, 255, 255, 255),
      fontSize: 23, // Reducimos el tamaño del texto
      fontWeight: FontWeight.bold,
    );

    final textSpan = TextSpan(
      text: n.dato.toString(),
      style: textStyle,
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    final offsetText = Offset(x - textPainter.width / 2, y - textPainter.height / 2);

    double extra = objArbol.altura(n) * (ancho / 2);

    if (n.izquierda != null) {
      canvas.drawLine(
        Offset(x, y + radio),
        Offset(x - ancho - extra, y + ancho + radio),
        linePaint,
      );
    }

    if (n.derecha != null) {
      canvas.drawLine(
        Offset(x, y + radio),
        Offset(x + ancho + extra, y + ancho + radio),
        linePaint,
      );
    }

    canvas.drawCircle(Offset(x, y), diametro, circlePaint);
    textPainter.paint(canvas, offsetText);

    pintar(canvas, x - ancho - extra, y + ancho + diametro, n.izquierda);
    pintar(canvas, x + ancho + extra, y + ancho + diametro, n.derecha);
  }


  
}
