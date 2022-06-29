import 'package:attendance_system/feature/attendant_management/presentation/history/screen/history_screen.dart';
import 'package:attendance_system/feature/attendant_management/presentation/profile/screen/profile_screen.dart';
import 'package:flutter/material.dart';

import 'package:attendance_system/feature/attendant_management/presentation/home/screen/home_screen.dart';

final List<Widget> navPages = <Widget>[
  const HistoryScreen(),
  const HomeScreen(),
  const ProfileScreen(),
];