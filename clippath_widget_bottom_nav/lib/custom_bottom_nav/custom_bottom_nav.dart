import 'package:flutter/material.dart';

class CustomBottomNav extends StatefulWidget {
  const CustomBottomNav({super.key});

  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav>
    with SingleTickerProviderStateMixin {
  late AnimationController _curveAnimationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    // TODO: implement initState

    _curveAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation = Tween<Offset>(begin: Offset.zero, end: Offset(5, 0)).animate(
      CurvedAnimation(parent: _curveAnimationController, curve: Curves.linear),
    );
    super.initState();
  }

  setAnimation(double offsetPosition) {
    _animation = Tween<Offset>(
      begin: _animation.value,
      end: Offset(offsetPosition, 0),
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
          height: 100,
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
                      SlideTransition(
                        position: _animation,
                        child: ClipPath(
                          clipper: HalfCircleClipper(
                            position: CurvePosition.top,
                          ),
                          child: Container(
                            height: 40,
                            width: 60,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SlideTransition(
                        position: _animation,
                        child: ClipPath(
                          clipper: HalfCircleClipper(
                            position: CurvePosition.bottom,
                          ),
                          child: Container(
                            height: 40,
                            width: 60,
                            color: Colors.white,
                          ),
                        ),
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

                    Icon(Icons.home),
                    Icon(Icons.favorite),
                    InkWell(
                      onTap: () {
                        setAnimation(5);
                      },
                      child: Icon(Icons.person),
                    ),
                    Icon(Icons.person),
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

    switch (this) {
      case CurvePosition.top:
        path.moveTo(10, 0);
        offset = Offset(size.width, 0);
        clockWise = false;
        break;
      case CurvePosition.bottom:
        path.moveTo(10, size.height);
        offset = Offset(size.width, size.height);
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
  final CurvePosition position;

  const HalfCircleClipper({required this.position});

  @override
  Path getClip(Size size) => position.toPath(size);

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
