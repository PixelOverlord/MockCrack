import 'package:flutter/material.dart';

Widget appInstructionCard({
  required Widget icon,
  required String description,
}) {
  return Container(
    width: 80,
    child: Column(
      children: [
        CircleAvatar(
          radius: 35,
          backgroundColor: Color(0xffdafc94),
          child: icon,
        ),
        SizedBox(height: 10),
        Text(
          description,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

class DottedLinePainter extends CustomPainter {
  final Color color;

  DottedLinePainter({super.repaint, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.5)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    const dashWidth = 5;
    const dashSpace = 5;
    double startX = 0;
    final endX = size.width;

    while (startX < endX) {
      canvas.drawLine(
        Offset(startX, size.height / 2),
        Offset(startX + dashWidth, size.height / 2),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
