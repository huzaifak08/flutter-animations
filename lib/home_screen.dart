import 'package:flutter/material.dart';

enum CircleSide { left, right }

extension ToPath on CircleSide {
  Path toPath(Size size) {
    final path = Path();

    late Offset offset;
    late bool clockwise;

    switch (this) {
      // Cut half circle (D) but arc at left

      case CircleSide.left:
        // First move to max end at x-axis
        path.moveTo(size.width, 0);

        // Cut it from max-x to max-y
        offset = Offset(size.width, size.height);

        // and move in anti-clockwise arc
        clockwise = false;

        break;

      case CircleSide.right:
        // Cut half circle (D)

        // No need to move anywhere just start cutting
        offset = Offset(0, size.height);
        clockwise = true;
        break;
    }

    path.arcToPoint(
      offset,
      radius: Radius.elliptical(size.width / 2, size.height / 2), // Diameter/2
      clockwise: clockwise,
    );

    path.close();
    return path;
  }
}

class HalfCircleClipper extends CustomClipper<Path> {
  final CircleSide side;
  const HalfCircleClipper({required this.side});

  @override
  Path getClip(Size size) => side.toPath(size);

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipPath(
              clipper: const HalfCircleClipper(side: CircleSide.left),
              child: Container(
                color: const Color(0xff0057b7),
                height: 100,
                width: 100,
              ),
            ),
            ClipPath(
              clipper: const HalfCircleClipper(side: CircleSide.right),
              child: Container(
                color: const Color(0xffffd700),
                height: 100,
                width: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
