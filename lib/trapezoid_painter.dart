import 'package:flutter/material.dart';
// import 'dart:math' as math;

// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Stack Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const StackDemo(),
//     );
//   }
// }
//
// class StackDemo extends StatelessWidget {
//   const StackDemo({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Stack Demo'),
//       ),
//       body: Center(
//         child: Stack(
//           fit: StackFit.loose,
//           clipBehavior: Clip.none,
//           children: [
//             Image.asset(
//               'assets/images/header-background.png',
//               width: 300,
//               height: 300,
//               fit: BoxFit.fill,
//             ),
//             Positioned(
//               bottom: 0,
//               left: 0,
//               right: 0,
//               child: CustomPaint(
//                 size: const Size(300, 300),
//                 painter: TrianglePainter(),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

enum LocationType{
  relative,
  absolute
}

class TrapezoidPainter extends CustomPainter {

  final Axis axis;
  final double topStart, topEnd, bottomStart, bottomEnd;
  final Color color;
  final LocationType locationType;

  const TrapezoidPainter({
    this.axis = Axis.horizontal,
    this.locationType = LocationType.relative,
    this.topStart = 0,
    this.topEnd = 1,
    this.bottomStart = 0,
    this.bottomEnd = 1,
    this.color = Colors.cyan
  });
  
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    if(locationType == LocationType.relative) {
      if (axis == Axis.horizontal) {
        path.moveTo(size.width * topStart, 0);
        path.lineTo(size.width * topEnd, 0);
        path.lineTo(size.width * bottomEnd, size.height);
        path.lineTo(size.width * bottomStart, size.height);
      } else {
        path.moveTo(0, size.height * bottomStart);
        path.lineTo(0, size.height * bottomEnd);
        path.lineTo(size.width, size.height * topEnd);
        path.lineTo(size.width, size.height * topStart);
      }
    }else{
      if (axis == Axis.horizontal) {
        path.moveTo(topStart, 0);
        path.lineTo(topEnd, 0);
        path.lineTo(bottomEnd, size.height);
        path.lineTo(bottomStart, size.height);
      } else {
        path.moveTo(bottomStart, 0);
        path.lineTo(bottomEnd, 0);
        path.lineTo(topEnd, size.height);
        path.lineTo(topStart, size.height);
      }
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}