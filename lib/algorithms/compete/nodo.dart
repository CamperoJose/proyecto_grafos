import 'package:flutter/material.dart';
import '../../classes/modelo_nodo.dart';

class Nodo extends CustomPainter {
  List<ModeloNodo> vNodo;
  Nodo(this.vNodo);
  double valx = 0;
  double valy = 0;
  int sizen = 0;

  _drawNode(Canvas canvas, Paint paint, double x, double y, double radius) {
    paint.color = Colors.purple.shade900;
    canvas.drawCircle(Offset(x, y), radius, paint);
  }

  _drawText(Canvas canvas, String text, double x, double y, double nodeWidth) {
    TextSpan span = TextSpan(
      style: TextStyle(
        color: Colors.black,
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
      text: text,
    );
    TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    tp.layout();

    double scaleFactor = 1.0;
    if (tp.width > nodeWidth) {
      scaleFactor = nodeWidth / tp.width;
    }

    if (scaleFactor < 1.0) {
      tp.text = TextSpan(
        text: text.length < 11 ? text : text.substring(0, 9) + '...',
        style: TextStyle(
          color: Colors.black,
          fontSize: 25 * scaleFactor,
          fontWeight: FontWeight.bold,
        ),
      );
      tp.layout();
    }

    if(text=="centroide"){
      canvas.drawCircle(
        Offset(x, y), nodeWidth / 2, Paint()..color = Color.fromARGB(255, 7, 172, 227));
    tp.paint(canvas, Offset(x - tp.width / 2, y - tp.height / 2));


    }else{
      canvas.drawCircle(
        Offset(x, y), nodeWidth / 2, Paint()..color = Colors.purple.shade400);
    tp.paint(canvas, Offset(x - tp.width / 2, y - tp.height / 2));
    }

    
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (var nodo in vNodo) {
      double nodeWidth = nodo.radio * 2;
      valx = valx + nodo.x;
      valy = valy + nodo.y;
      sizen = sizen + 1;
      _drawText(canvas, nodo.mensaje, nodo.x, nodo.y, nodeWidth);
    }

    if(sizen>1){
      _drawText(canvas, "centroide", valx/sizen, valy/sizen, 80);
    }

    

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
