import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../classes/modelo_arista.dart';

class Union extends CustomPainter {
  List<ModeloArista> vUniones;
  Union(this.vUniones);

_msg(double x, double y, String msg, Canvas canvas) {
  final TextSpan span = TextSpan(
    style: TextStyle(
      color: Colors.deepPurpleAccent,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    text: msg,
  );

  final TextPainter tp = TextPainter(
    text: span,
    textAlign: TextAlign.left,
    textDirection: TextDirection.ltr,
  );

  tp.layout();

  final double textWidth = tp.width;
  final double textHeight = tp.height;
  final double padding = 10.0; // Espacio de relleno alrededor del texto

  final Rect rect = Rect.fromPoints(
    Offset(x, y),
    Offset(x + textWidth + 2 * padding, y + textHeight + 2 * padding),
  );

  final Paint paint = Paint()
    ..color = Colors.lightBlue.shade100 // Color de fondo celeste claro
    ..style = PaintingStyle.fill;

  final double borderRadius = (textHeight + 2 * padding) / 2.0; // Bordes redondeados basados en la altura del texto

  canvas.drawRRect(
    RRect.fromRectAndRadius(rect, Radius.circular(borderRadius)),
    paint,
  );

  tp.paint(canvas, Offset(x + padding, y + padding)); // Aplicar relleno al texto
}



  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.grey.shade600
      ..strokeWidth = 2;

    Paint paint2 = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.grey.shade600
      ..strokeWidth = 2;

    for (var nodo in vUniones) {
      if (nodo.ida == true) {

        //EN CASO DE LOOP: 
        if (nodo.xinicio == nodo.xfinal && nodo.yinicio == nodo.yfinal) {
  double centerX = nodo.xinicio;
  double centerY = nodo.yinicio;
  double controlX1 = centerX + 100; // Ajusta la posición de los puntos de control
  double controlY1 = centerY - 170;
  double controlX2 = centerX - 100;
  double controlY2 = centerY - 30;

  Paint paint = Paint()
    ..style = PaintingStyle.stroke // Establece el estilo en stroke
    ..color = Colors.grey.shade700
    ..strokeWidth = 2;

  Path path = Path();
  path.moveTo(centerX, centerY);
  path.cubicTo(
    controlX1,
    controlY1,
    controlX2,
    controlY2,
    centerX,
    centerY,
  );

  canvas.drawPath(path, paint);

  if(nodo.dirigido){
      double angle = atan2(centerY - controlY1, centerX - controlX1);
          double arrowX = centerX - 30 * cos(angle);
          double arrowY = centerY - 30 * sin(angle);

          Paint arrowPaint = Paint()
    ..style = PaintingStyle.fill 
    ..color = Colors.grey.shade600;

          Path arrowPath = Path();
          
          arrowPath.moveTo(
              centerX - 30 * cos(angle), centerY - 30 * sin(angle));
          arrowPath.lineTo(arrowX + (-15) * cos(angle + pi / 6),
              arrowY + (-15) * sin(angle + pi / 6));
          arrowPath.lineTo(arrowX + (-15) * cos(angle - pi / 6),
              arrowY + (-15) * sin(angle - pi / 6));
          arrowPath.close();
          canvas.drawPath(arrowPath, arrowPaint);

          
  }

  double textX = centerX + 0; // Ajusta la posición X según tus preferencias
  double textY = centerY - 110; // Ajusta la posición Y según tus preferencias

  _msg(textX, textY, nodo.peso, canvas);
}

else {
          canvas.drawLine(Offset(nodo.xinicio, nodo.yinicio),
              Offset(nodo.xfinal, nodo.yfinal), paint);

          // calculate angle of the line
          double angle =
              atan2(nodo.yfinal - nodo.yinicio, nodo.xfinal - nodo.xinicio);

          // calculate coordinates of the arrow tip
          double arrowLength = 60;
          double arrowX = nodo.xfinal - arrowLength * cos(angle);
          double arrowY = nodo.yfinal - arrowLength * sin(angle);

          // draw the arrow

          if (nodo.dirigido == true) {
            Path path = Path();
            path.moveTo(
                nodo.xfinal - 30 * cos(angle), nodo.yfinal - 30 * sin(angle));
            path.lineTo(arrowX + 15 * cos(angle + pi / 6),
                arrowY + 15 * sin(angle + pi / 6));
            path.lineTo(arrowX + 15 * cos(angle - pi / 6),
                arrowY + 15 * sin(angle - pi / 6));
            path.close();
            canvas.drawPath(path, paint);
          }

          _msg((nodo.xfinal + nodo.xinicio) / 2,
              (nodo.yinicio + nodo.yfinal) / 2, nodo.peso, canvas);
        }
      } else {

        

        Path path = Path();
        path.moveTo(nodo.xinicio, nodo.yinicio);
        path.arcToPoint(
          Offset(nodo.xfinal, nodo.yfinal),
          radius: const Radius.circular(50),
          clockwise: true,
        );

        double angle =
            atan2(nodo.yfinal - nodo.yinicio, nodo.xfinal - nodo.xinicio) +
                pi * (17 / 40);

        double arrowLength = 60;
        double arrowX = nodo.xfinal - arrowLength * cos(angle);
        double arrowY = nodo.yfinal - arrowLength * sin(angle);

        canvas.drawPath(path, paint2);

        if (nodo.dirigido == true) {
          Path arrowPath = Path();
          arrowPath.moveTo(
              nodo.xfinal - 30 * cos(angle), nodo.yfinal - 30 * sin(angle));
          arrowPath.lineTo(arrowX + 15 * cos(angle + pi / 6),
              arrowY + 15 * sin(angle + pi / 6));
          arrowPath.lineTo(arrowX + 15 * cos(angle - pi / 6),
              arrowY + 15 * sin(angle - pi / 6));
          arrowPath.close();
          canvas.drawPath(arrowPath, paint);
        }

        // draw the line and arrow

        PathMetrics pathMetrics = path.computeMetrics();
        PathMetric pathMetric = pathMetrics.elementAt(0);
        Tangent tangent =
            pathMetric.getTangentForOffset(pathMetric.length / 2)!;
        Offset arrowPoint = tangent.position;
        double angle2 = tangent.angle;

        // draw the text
        _msg(arrowPoint.dx - 30 * cos(angle), arrowPoint.dy - 30 * sin(angle2),
            nodo.peso, canvas);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
