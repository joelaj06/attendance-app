import 'package:attendance_system/core/presentation/widgets/animated_background.dart';
import 'package:flutter/material.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AnimatedBackground(
        child: Center(
          child: Text(
            'Profile'
          ),
        ),
      ),
    );
  }
}
