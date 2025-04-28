import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class CustomBottomNav extends StatefulWidget {
  const CustomBottomNav({super.key});

  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav>
    with SingleTickerProviderStateMixin {
  late AnimationController _curveAnimationController;
  late Animation<Offset> _animation;
  late Animation<Offset> _prevAnimation;
  late StylishBottomBar bottomNavigationBar;

  @override
  void initState() {
    // TODO: implement initState

    _curveAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation = Tween<Offset>(begin: Offset.zero, end: Offset(.9, 0)).animate(
      CurvedAnimation(parent: _curveAnimationController, curve: Curves.linear),
    );
    _prevAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(1.9, 0),
    ).animate(
      CurvedAnimation(parent: _curveAnimationController, curve: Curves.linear),
    );
    super.initState();
  }

  setAnimation(double offsetPosition) {
    var position = offsetPosition;
    Offset frontOffset = Offset(0, 0);
    Offset backOffset = Offset(0, 0);

    switch (position) {
      case 1:
        frontOffset = Offset(-0.3, 0);
        backOffset = Offset(.3, 0);
        break;
      case 2:
        frontOffset = Offset(.8, 0);
        backOffset = Offset(1.4, 0);
        break;
      case 3:
        frontOffset = Offset(1.4, 0);
        backOffset = Offset(2, 0);
        break;
      case 4:
        frontOffset = Offset(2, 0);
        backOffset = Offset(2.6, 0);
        break;
      case 5:
        frontOffset = Offset(2.6, 0);
        backOffset = Offset(3.2, 0);
        break;
    }
    _animation = Tween<Offset>(
      begin: _animation.value,
      end: frontOffset,
    ).animate(
      CurvedAnimation(parent: _curveAnimationController, curve: Curves.linear),
    );
    _prevAnimation = Tween<Offset>(
      begin: _prevAnimation.value,
      end: backOffset,
    ).animate(
      CurvedAnimation(parent: _curveAnimationController, curve: Curves.linear),
    );
    _curveAnimationController
      ..reset()
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 80,
          width: 400,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              AnimatedBuilder(
                animation: _curveAnimationController,
                builder: (context, child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SlideTransition(
                            position: _animation,
                            child: ClipPath(
                              clipper: HalfCircleClipper(
                                position: CurvePosition.top,
                              ),
                              child: Container(
                                height: 40,
                                width: 80,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SlideTransition(
                            position: _prevAnimation,
                            child: ClipPath(
                              clipper: HalfCircleClipper(
                                position: CurvePosition.top,
                              ),
                              child: Container(
                                height: 40,
                                width: 80,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SlideTransition(
                            position: _animation,
                            child: ClipPath(
                              clipper: HalfCircleClipper(
                                position: CurvePosition.bottom,
                              ),
                              child: Container(
                                height: 40,
                                width: 80,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SlideTransition(
                            position: _prevAnimation,
                            child: ClipPath(
                              clipper: HalfCircleClipper(
                                position: CurvePosition.bottom,
                              ),
                              child: Container(
                                height: 40,
                                width: 80,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
              Positioned(
                top: 0,
                bottom: 0,
                right: 0,
                left: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    InkWell(
                      onTap: () {
                        setAnimation(1);
                      },
                      child: Icon(Icons.home),
                    ),

                    InkWell(
                      onTap: () {
                        setAnimation(2);
                      },
                      child: Icon(Icons.home),
                    ),
                    InkWell(
                      onTap: () {
                        setAnimation(3);
                      },
                      child: Icon(Icons.favorite),
                    ),
                    InkWell(
                      onTap: () {
                        setAnimation(4);
                      },
                      child: Icon(Icons.person),
                    ),
                    InkWell(
                      onTap: () {
                        setAnimation(5);
                      },
                      child: Icon(Icons.person),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum CurvePosition { top, bottom }

extension ToPath on CurvePosition {
  Path toPath(Size size) {
    final path = Path();

    late Offset offset;
    late bool clockWise;

    Offset firstControlPoint;
    Offset firstEndPoint;

    var width = size.width;
    var height = size.height;

    switch (this) {
      case CurvePosition.top:
        path.moveTo(0, 0);
        path.conicTo(width, height * 1.5, width * 1, -height / 2, .5);
        clockWise = false;

        break;
      case CurvePosition.bottom:
        path.moveTo(0, size.height);

        // path.conicTo(0, 0, 0, height / 2, width);
        // path.conicTo(width * .7, -height * .5, width * 1, height / 1, .5);

        path.quadraticBezierTo(
          size.width * .5,
          size.height * 0.3,
          size.width,
          size.height,
        );
        clockWise = true;

        break;
    }
    // path.quadraticBezierTo(
    //   size.width * .5,
    //   size.height * 0.3,
    //   size.width,
    //   size.height,
    // );

    // path.arcToPoint(
    //   offset,
    //   radius: Radius.elliptical((size.width / 2) - 0, size.height / 2),
    //   // radius: Radius.circular(size.width - ((size.width / 2) + 10)),
    //   clockwise: clockWise,
    //   rotation: 1,
    // );
    // path.relativeArcToPoint(
    //   offset,
    //   radius: Radius.elliptical((size.width / 2) - 0, size.height / 2),
    //   clockwise: clockWise,
    //   rotation: 1.5,
    // );
    path.close();
    return path;
  }
}

class HalfCircleClipper extends CustomClipper<Path> {
  final CurvePosition position;

  const HalfCircleClipper({required this.position});

  @override
  Path getClip(Size size) => position.toPath(size);

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
