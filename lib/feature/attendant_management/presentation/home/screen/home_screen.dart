import 'package:attendance_system/core/presentation/themes/app_theme.dart';
import 'package:attendance_system/core/presentation/utils/date_formatter.dart';
import 'package:attendance_system/feature/attendant_management/presentation/home/getx/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slide_to_act/slide_to_act.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 18,
            ),
            Container(
              margin: const EdgeInsets.only(top: 50),
              child: const Text(
                'Today\'s status',
                style: TextStyle(fontSize: 23, color:Colors.black54,),
              ),
            ),
            const SizedBox(height: 38,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StreamBuilder(
                    stream: Stream.periodic(const Duration(seconds: 1)),
                    builder: (context, snapshot) {
                      return Text(
                        DateFormatter().formattedTimeA(DateTime.now()),
                        style:  TextStyle(
                          color: primaryColorSA,
                          fontSize: 35,
                        ),
                      );
                    },),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateFormatter().toStringFormattedDateB(DateTime.now()),
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: primaryColorSA,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: primaryColorSA.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],

                ),
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.history_rounded,
                          color: Colors.white),
                          const SizedBox(height: 5,),
                          Obx(
                            () => Text(
                              controller.checkIn.value,
                              style:  TextStyle(
                                color: secondaryColorS1,
                                fontSize: 26,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const Text(
                            'Check in',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20, fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                         const Icon(Icons.update_rounded,
                         color: Colors.white,),
                          const SizedBox(height: 5,),
                          Obx(
                            () => Text(
                              controller.checkOut.value,
                              style:  TextStyle(
                                color: secondaryColorS1,
                                fontSize: 26,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const Text(
                            'Check out',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20, fontWeight: FontWeight.w300,),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            SizedBox(
              width: width,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: width/6,
                    child: Icon(
                      Icons.location_on_outlined,
                      size: 40,
                      color: secondaryColorS2,
                    ),
                  ),
                  Expanded(
                    child: Obx(() => Text(
                      controller.location.value ==
                          '' ? 'Last seen': controller.location.value, style: const TextStyle(
                        fontSize: 20,
                      color: Colors.black54,
                      ),),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: Obx(
                () => controller.checkOut.value == '--/--'
                    ? _buildSlideToCheckInOrOut()
                    : const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'You have completed the day!',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
              ),
            ),
            IconButton(
                onPressed: () {
                  controller.signOut();
                },
                icon: const Icon(Icons.exit_to_app))
          ],
        ),
      ),
    );
  }



  Widget _buildSlideToCheckInOrOut() {
    GlobalKey<SlideActionState> slideActionStateKey = GlobalKey();
    return Builder(
      builder: (BuildContext context) {
        return Obx(
          () => SlideAction(
            text: controller.checkIn.value == '--/--'
                ? 'Slide to Check in'
                : 'Slide to Check out',
            key: slideActionStateKey,

            innerColor: primaryColorSA,
            outerColor: Colors.white,
            onSubmit: () {
              //  debugPrint(DateFormatter().formattedTimeB(DateTime.now()));
              slideActionStateKey.currentState!.reset();
              controller.getCurrentPosition();
              controller.createCheckInOrCheckOut();
            },
          ),
        );
      },
    );
  }


}
