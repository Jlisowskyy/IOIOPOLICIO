import 'dart:math';

import 'package:flutter/material.dart';

class PokerTablePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final tablePaint = Paint()
      ..color = Colors.green[700]!
      ..style = PaintingStyle.fill;

    final tableBorderPaint = Paint()
      ..color = Colors.brown
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    final chipPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    final tableRect = Rect.fromLTWH(
      size.width * 0.1,
      size.height * 0.2,
      size.width * 0.8,
      size.height * 0.6,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(tableRect, const Radius.circular(30)),
      tablePaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(tableRect, const Radius.circular(30)),
      tableBorderPaint,
    );

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      50,
      chipPaint,
    );

    const chipRadius = 15.0;
    for (int i = 0; i < 8; i++) {
      final angle = (i * 45) * pi / 180;
      final x = size.width / 2 + 80 * cos(angle);
      final y = size.height / 2 + 80 * sin(angle);
      canvas.drawCircle(Offset(x, y), chipRadius, chipPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
