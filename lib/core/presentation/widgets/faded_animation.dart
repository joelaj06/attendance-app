import 'package:flutter/material.dart';
class AppFadedAnimation extends StatefulWidget {
   AppFadedAnimation({required this.child,
    required this.duration,
    Key? key}) : super(key: key);


  int duration;
  Widget child;
  @override
  _AppFadedAnimationState createState() => _AppFadedAnimationState();
}

class _AppFadedAnimationState extends State<AppFadedAnimation> with
 TickerProviderStateMixin {

  late final AnimationController _animationController =
  AnimationController(
    duration:  Duration(seconds : widget.duration),
    vsync: this,
  );


  late final Animation<double> _animation = CurvedAnimation(
    parent:_animationController,
    curve: Curves.easeIn,
  );


  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0,1),
        end: Offset.zero,
      ).animate(_animationController),
      child: FadeTransition(
        opacity: _animation,
        child: widget.child
      ),
    );
  }
}

