import 'package:attendance_system/core/presentation/themes/app_theme.dart';
import 'package:flutter/material.dart';

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({required this.child, Key? key}) : super(key: key);

  final Widget child;

  @override
  _AnimatedBackgroundState createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Opacity(
        opacity: 0.5,
        child: ClipPath(
          clipper: TopLeftWaveClipper(),
          child: Container(
            color: primaryColorSA,
            height: 200,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

class TopLeftWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var width = size.width;
    var height = size.height;
    var path = Path();

    path.lineTo(0.0, height - 20);
    path.lineTo(width, height / 6);
    path.lineTo(width, 0.0);
    path.close();

    final firstControlPoint = Offset(width / 10, height);
    final firstEndPoint = Offset(width / 3, height - 50);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    /*var secondControlPoint =
    Offset(size.width - (size.width / 3.25), size.height - 65);
    var secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);*/
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
