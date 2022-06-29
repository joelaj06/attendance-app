import 'package:attendance_system/feature/attendant_management/data/data_source/database_service/database_repository_impl.dart';
import 'package:attendance_system/feature/authentication/data/data_source/auth_controller.dart';
import 'package:attendance_system/feature/authentication/data/model/user_model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../../../core/presentation/utils/date_formatter.dart';

class HomeController extends GetxController {
  RxString checkIn = '--/--'.obs;
  RxString checkOut = '--/--'.obs;
  RxString location = ''.obs;
  RxDouble long = 0.0.obs;
  RxDouble lat = 0.0.obs;

  late Rx<Position> currentPosition;

  // auth controller
  final AuthController _authController = AuthController();

  // user
  UserModel userModel = UserModel();

  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;

  // database repository
  final DatabaseRepositoryImpl _databaseRepositoryImpl =
      DatabaseRepositoryImpl(uid: '');

  @override
  void onInit() {
    debugPrint('home controller onInit');
    super.onInit();
    startLocationService();
    getCurrentPosition();
    getRecords();
  }

  Future getRecords() async {
    try {
      final snap = await _databaseRepositoryImpl.getRecords();
      checkIn(snap['checkIn']);
      checkOut(snap['checkOut']);
      location(snap['location']);
    } catch (e) {
      checkIn('--/--');
      checkOut('--/--');
     // location('');
    }
    debugPrint('record: ${checkIn.value}');
  }

  void createCheckInOrCheckOut() async {
    getCurrentPosition();
    if(checkIn.value == '--/--'){
      checkIn(DateFormatter().formattedTimeC(DateTime.now()));
      checkOut('--/--');
    } else{
      checkOut(DateFormatter().formattedTimeB(DateTime.now()));
    }
    _databaseRepositoryImpl.createCheckInOrCheckOutField(
      location.value,
      checkIn.value,
      checkOut.value,
    );
    await getRecords();
    getRecords();
    debugPrint('Retrieving data from server...');
    debugPrint('==============================');
    debugPrint(checkIn.value);
    debugPrint(checkOut.value);
    debugPrint(location.value);
  }

  void startLocationService() {
    _databaseRepositoryImpl.startLocationService();
  }

  void getCurrentPosition() {
    try {
      Geolocator.getCurrentPosition().then((Position position) async {
        lat(position.latitude);
        long(position.longitude);
        debugPrint(position.longitude.toString());
        debugPrint(position.latitude.toString());
        List<Placemark> placeMarks = await placemarkFromCoordinates(
            position.latitude, position.longitude);
        location(
            '${placeMarks[0].street}, ${placeMarks[0].locality} - ${placeMarks[0].administrativeArea},'
            '${placeMarks[0].postalCode}  ${placeMarks[0].country}');
        debugPrint('loc: ${location.value}');
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void signOut() {
    _authController.signOut();
  }
}
