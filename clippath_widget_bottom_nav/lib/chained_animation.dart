import 'dart:math' show pi;

import 'package:flutter/material.dart';

class ChainedAnimation extends StatefulWidget {
  const ChainedAnimation({super.key});

  @override
  State<ChainedAnimation> createState() => _ChainedAnimationState();
}

extension on VoidCallback {
  Future<void> delayed(Duration duration) => Future.delayed(duration, this);
}

class _ChainedAnimationState extends State<ChainedAnimation>
    with TickerProviderStateMixin {
  late AnimationController _counterClockwiseAnimationController;
  late Animation<double> _counterAnimation;

  late AnimationController _flipController;
  late Animation<double> _flipAnimation;

  @override
  void initState() {
    // TODO: implement initState

    _counterClockwiseAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _counterAnimation = Tween<double>(begin: 0, end: -(pi / 2)).animate(
      CurvedAnimation(
        parent: _counterClockwiseAnimationController,
        curve: Curves.bounceOut,
      ),
    );

    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _flipAnimation = Tween<double>(begin: 0, end: pi).animate(
      CurvedAnimation(parent: _flipController, curve: Curves.bounceOut),
    );

    _counterClockwiseAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _flipAnimation = Tween<double>(
          begin: _flipAnimation.value,
          end: _flipAnimation.value + pi,
        ).animate(
          CurvedAnimation(parent: _flipController, curve: Curves.bounceOut),
        );
        _flipController
          ..reset()
          ..forward();
      }
    });

    _flipController.addStatusListener((status) {
      print(_counterAnimation.value);
      if (status == AnimationStatus.completed) {
        _counterAnimation = Tween<double>(
          begin: _counterAnimation.value,
          end: -pi, // or we can set as - 180
        ).animate(
          CurvedAnimation(
            parent: _counterClockwiseAnimationController,
            curve: Curves.bounceOut,
          ),
        );
        _counterClockwiseAnimationController
          ..reset()
          ..forward();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _counterClockwiseAnimationController.dispose();
    _flipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _counterClockwiseAnimationController
      ..reset()
      ..forward.delayed(Duration(seconds: 1));
    return Scaffold(
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _counterClockwiseAnimationController,
          builder: (context, child) {
            return Transform(
              alignment: Alignment.center,
              transform:
                  Matrix4.identity()..rotateZ(
                    _counterAnimation.value,
                  ), // how will bw the animation happen
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _flipController,
                    builder: (context, child) {
                      return Transform(
                        alignment: Alignment.centerRight,
                        transform:
                            Matrix4.identity()..rotateY(_flipAnimation.value),
                        child: ClipPath(
                          clipper: HalfCircleClipper(
                            side: CircleSide.left,
                          ), // make the widget for ui
                          child: Container(
                            height: 200,
                            width: 200,
                            color: Colors.blue,
                          ),
                        ),
                      );
                    },
                  ),
                  AnimatedBuilder(
                    animation: _flipController,
                    builder: (context, child) {
                      return Transform(
                        alignment: Alignment.centerLeft,
                        transform:
                            Matrix4.identity()..rotateY(_flipAnimation.value),
                        child: ClipPath(
                          clipper: HalfCircleClipper(
                            side: CircleSide.right,
                          ), // make the widget for ui
                          child: Container(
                            height: 200,
                            width: 200,
                            color: Colors.yellow,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

enum CircleSide { left, right }

extension ToPath on CircleSide {
  Path toPath(Size size) {
    final path = Path();

    late Offset offset;
    late bool clockWise;

    switch (this) {
      case CircleSide.left:
        path.moveTo(size.width, 0);
        offset = Offset(size.width, size.height);
        clockWise = false;
        break;
      case CircleSide.right:
        path.moveTo(0, 0);
        offset = Offset(0, size.height);
        clockWise = true;
        break;
    }

    path.arcToPoint(
      offset,
      radius: Radius.elliptical(size.width / 2, size.height / 2),
      clockwise: clockWise,
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
