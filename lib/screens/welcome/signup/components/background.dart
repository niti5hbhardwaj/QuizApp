import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: -250,
            right: -170,
            child: SvgPicture.asset(
              "assets/images/signup_top_right.svg",
              width: size.width * 1,
            ),
          ),
          Positioned(
            bottom: -245,
            left: -155,
            child: Transform.rotate(
              angle: 51.1,
              child: SvgPicture.asset(
                "assets/images/signup_bottom_left.svg",
                width: size.width,
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
