import 'package:attendance_system/core/presentation/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppLoadingBox extends StatelessWidget {
  const AppLoadingBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitChasingDots(
      color: secondaryColorS2,
      size: 80,
    );
  }
}




class AppLoadingTransparentBox extends StatelessWidget {
  const AppLoadingTransparentBox({
    Key? key,
    required this.child,
    this.backgroundColor,
    this.loaderColor,
    this.loaderSize,
    this.loadingProgress,
    this.loading = false,
  }) : super(key: key);

  final Widget child;
  final bool loading;
  final Color? backgroundColor;
  final double? loadingProgress;
  final Color? loaderColor;
  final double? loaderSize;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      curve: Curves.ease,
      duration: const Duration(milliseconds: 1300),
      tween: Tween<double>(begin: 0.0, end: 1.0),
      builder: (_, double animationValue, Widget? __) {
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            child,
            Positioned.fill(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: DecoratedBox(
                  key: ValueKey<bool>(loading),
                  decoration: BoxDecoration(
                    color: backgroundColor ??
                        primaryColorS3.withOpacity(.70),
                  ),
                  child: !loading
                      ? const SizedBox()
                      : Stack(
                    children: <Widget>[
                      Center(
                        child: SpinKitPulse(
                          color: secondaryColorS2,
                          size: 300,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

