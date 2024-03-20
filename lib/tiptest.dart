import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stack Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StackDemo(),
    );
  }
}

class StackDemo extends StatelessWidget {
  const StackDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stack Demo'),
      ),
      body: Center(
        child: Stack(
          fit: StackFit.loose,
          clipBehavior: Clip.none,
          children: [
            Image.asset(
              'assets/images/header-background.png',
              width: 300,
              height: 300,
              fit: BoxFit.fill,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: CustomPaint(
                size: const Size(300, 300),
                painter: TrianglePainter(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width*0.75, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}