import 'package:attendance_system/core/presentation/themes/app_theme.dart';
import 'package:attendance_system/core/presentation/utils/app_date_picker.dart';
import 'package:attendance_system/core/presentation/utils/date_formatter.dart';
import 'package:attendance_system/core/presentation/widgets/exceptionIndicators/no_content_found.dart';
import 'package:attendance_system/core/presentation/widgets/faded_animation.dart';
import 'package:attendance_system/feature/attendant_management/data/model/user_action.dart';
import 'package:attendance_system/feature/attendant_management/presentation/history/getx/history_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../../core/presentation/widgets/animation_column.dart';

class HistoryScreen extends GetView<HistoryController> {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfffafafa),
        elevation: 0.0,
        title: const Center(
          child: Text(
            'Attendance',
            style: TextStyle(
              fontSize: 25,
              color: Colors.black87,
            ),
          ),
        ),
        actions: const <Widget>[

        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top:8),
                  child:  Obx(() => Text(
                         controller.month.value,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                  ),

                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.only(top: 35),
                  child: GestureDetector(
                    onTap: () async {
                      final month =
                      await AppDatePicker().showMonthYearDatePicker(context);
                      if (month != null) {
                        controller.onMonthSelected( DateFormatter().dateFormatterMonth(month));
                        controller.onYearSelected(DateFormatter().dateFormatterYear(month));
                        controller.onMonthYearSelected(month);
                        controller.checkCurrentDate();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: primaryColorSA.withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                 Obx(() => Text(
                                    controller.year.value,
                                    style:  TextStyle(
                                      color: primaryColorSA,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                ),
                                 ),
                               const SizedBox(width: 4,),
                                 Icon(FontAwesomeIcons.calendarDays,
                                size: 20,
                                color: primaryColorSA,),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Obx(() => SizedBox(
                  child: controller.isCurrentDate.value
                      ? _buildAttendanceHistoryList(context) : const NoContentFound(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendanceHistoryList(BuildContext context) {
    return StreamBuilder<List<UserAction>>(
        stream: controller.getCheckInCheckOutHistory(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return const NoContentFound();
            }
            final userActionList = snapshot.data;
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: userActionList!.length,
              itemBuilder: (context, int index) {
                final userAction = userActionList[index];
                controller.timestamp = userAction.timeStamp!;
                debugPrint(controller.timestamp.toDate().toString());
                debugPrint(userAction.timeStamp!.toDate().toString());
                debugPrint(DateFormatter()
                    .dateFormatterADay(userAction.timeStamp!.toDate()));
                final day = DateFormatter()
                    .dateFormatterADay(userAction.timeStamp!.toDate());
                final date = DateFormatter()
                    .dateFormatterADate(userAction.timeStamp!.toDate());
                return _buildAttendanceHistoryCard(context, userAction, day , date);
              },
            );
          } else {
            return const SizedBox.shrink();
          }
        });

  }


  Widget _buildAttendanceHistoryCard(BuildContext context, UserAction userAction,
      String day, String date){
    String now = DateFormatter().formattedDateB(DateTime.now());
    Duration workHours = const Duration();
    if(userAction.checkOut != '--/--'){
      DateTime checkOutDate = DateTime.parse('$now ${userAction.checkOut}');
      DateTime checkInDate = DateTime.parse('$now ${userAction.checkIn}');
      workHours = checkOutDate.difference(checkInDate);
    }
    return Obx(() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: controller.isCurrentDate.value ?
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.white,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(
                    0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment:
                    MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          //  vertical: 28,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xffc1c5c2),
                            borderRadius: BorderRadius.circular(4),

                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Center(
                              child: Column(
                                children: [
                                  Text(
                                    date,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,),
                                  ),
                                  Text(
                                    day.toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.history_rounded,
                            color: primaryColorSA,),
                          const SizedBox(height: 5,),
                          Text(
                            userAction.checkIn.toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Text('Checked in',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black54,
                            ),),
                        ],
                      ),
                      Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.update_rounded,
                              color: primaryColorSA),
                          const SizedBox(height: 5,),
                          Text(
                            userAction.checkOut.toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Text('Checked Out',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black54,
                            ),),
                        ],
                      ),
                      Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.timelapse,
                              color: primaryColorSA),
                          const SizedBox(height: 5,),
                          Text(
                            DateFormatter().formatDurationHM(workHours),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Text('Work Hours',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black54,
                            ),),
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: primaryColorSA,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(3.0),
                            child: Text('Loc:',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),),
                          ),
                        ),
                        const SizedBox(width: 6,),
                        Flexible(
                          child: Text(userAction.locationUrl ?? 'No Location found.',
                            style:  TextStyle(
                                fontSize: 14,
                                color: secondaryColorS3
                            ),),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )
            : const SizedBox.shrink()),
    );
  }
}
