import 'package:attendance_system/core/presentation/themes/app_theme.dart';
import 'package:flutter/material.dart';

class AppTabBar extends StatefulWidget{
   AppTabBar({required this.tabList,
     required this.tabBody,
     Key? key}) : super(key: key);

  List<Tab> tabList = <Tab>[];

  List<Widget> tabBody = <Widget>[];

  @override
  _AppTabBarState createState() => _AppTabBarState();
}

class _AppTabBarState extends State<AppTabBar> with TickerProviderStateMixin {


  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: widget.tabList.length);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: TabBar(
            labelPadding: const EdgeInsets.symmetric(horizontal: 20),
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.label,
            indicator: CircleTabIndicator(color: primaryColorS1, radius: 4),
            controller: _tabController,
            tabs: widget.tabList,
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(top:8.0, right: 20, left: 20),
            child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: double.maxFinite,
              child: TabBarView(
                controller: _tabController,
                children: widget.tabBody,
              )
            ),
          ),
        )
      ],
    );
  }
}

class CircleTabIndicator extends Decoration{
  const CircleTabIndicator({required this.color, required this.radius});
  final Color color;
  final double radius;
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(radius: radius, color: color);
  }

}

class _CirclePainter extends BoxPainter {
  _CirclePainter({required this.radius, required this.color});
  final Color color;
  double radius;
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint _paint = Paint();
    _paint.color =  color;
    _paint.isAntiAlias = true;
     final Offset circleOffset = Offset(
         configuration.size!.width/2 -radius/2, configuration.size!.height - radius
         );
    canvas.drawCircle(offset + circleOffset, radius, _paint);
  }

}

