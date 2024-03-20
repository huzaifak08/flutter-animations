import 'dart:math' show pi;

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;

  @override
  void initState() {
    // Controller:

    _controller = AnimationController(
      vsync: this, // Screen refresh dealing
      duration: const Duration(seconds: 1),
    );

    // Animation: Tween means Between: pi = 180 degree
    _animation = Tween<double>(begin: 0.0, end: 2 * pi).animate(_controller);

    _controller.repeat();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => Transform(
          alignment: Alignment.center, // Pivot Point or Grab point
          transform: Matrix4.identity()..rotateY(_animation.value),
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.7),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
