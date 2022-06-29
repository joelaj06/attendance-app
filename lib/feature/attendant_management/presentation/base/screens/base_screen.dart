import 'package:attendance_system/core/presentation/nav/bottom_nav_icons.dart';
import 'package:attendance_system/core/presentation/nav/bottom_nav_tabs.dart';
import 'package:attendance_system/core/presentation/themes/app_theme.dart';
import 'package:flutter/material.dart';

class BaseScreen extends StatefulWidget {
  BaseScreen({Key? key}) : super(key: key);

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _selectedIndexItem = 1;

  @override
  Widget build(BuildContext context) {
    List<Widget> navBarItemList = [];

    for (var i = 0; i < navIconList.length; i++) {
      navBarItemList.add(
        _buildNavIconContainer(context, navIconList[i], i),
      );
    }
    return Scaffold(
      body: navPages[_selectedIndexItem],
      bottomNavigationBar: Row(children: navBarItemList),
    );
  }

  Widget _buildNavIconContainer(
      BuildContext context, IconData icon, int index) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndexItem = index;
        });
      },
      child: Container(
        height: 60,
        width: width / navIconList.length,
        decoration: index == _selectedIndexItem
            ? BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 4,
                    color: primaryColorS1,
                  ),
                ),
                gradient: LinearGradient(colors: [
                  primaryColorS1.withOpacity(0.2),
                  primaryColorS1.withOpacity(0.010),
                ], begin: Alignment.bottomCenter, end: Alignment.topCenter))
            : const BoxDecoration(),
        child: Icon(
          icon,
          color: index == _selectedIndexItem ? primaryColorS1 : Colors.grey,
        ),
      ),
    );
  }
}
