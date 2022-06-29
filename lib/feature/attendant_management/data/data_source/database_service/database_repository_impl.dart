import 'package:attendance_system/core/presentation/utils/date_formatter.dart';
import 'package:attendance_system/feature/attendant_management/data/data_source/database_service/database_collections.dart';
import 'package:attendance_system/feature/attendant_management/data/data_source/database_service/database_repository.dart';
import 'package:attendance_system/feature/attendant_management/data/data_source/location_service/location_service.dart';
import 'package:attendance_system/feature/attendant_management/data/model/user_action.dart';
import 'package:attendance_system/feature/attendant_management/presentation/home/getx/home_controller.dart';
import 'package:attendance_system/feature/authentication/data/data_source/auth_controller.dart';
import 'package:attendance_system/feature/authentication/data/model/user_model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';

class DatabaseRepositoryImpl implements DatabaseRepository {

  DatabaseRepositoryImpl({required this.uid});
  final CollectionReference _userCollectionReference =
      FirebaseFirestore.instance.collection(DatabaseCollection.user);

  final AuthController _authController = AuthController();


  final LocationService _locationService = LocationService();
  String? uid;

  double long = 0.0;
  double lat = 0.0;




  @override
  Future updateUserDetails(
    String? firstName,
    String? lastName,
    String? gender,
    String? phoneNumber,
    String? imgUrl,
    String? userId
  ) async{
    return _userCollectionReference.doc(uid).set(
      {
        'firstName': firstName,
        'lastName': lastName,
        'gender': gender,
        'phoneNumber': phoneNumber,
        'imgUrl':imgUrl,
        'userId': userId,
      }
    );
  }

  @override
  Future<UserModel?> getUserDetail() async{
    String? uid = await _authController.getCurrentUserUid();
    final docUser = _userCollectionReference.doc(uid);
    final snapshot = await docUser.get();
    if(snapshot.exists){
      return UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
    }
    return null;
  }

  @override
  Future createCheckInOrCheckOutField(String location, String checkIn, String checkOut) async{

    String? uid = await _authController.getCurrentUserUid();
    //if no field is found, create check in
    try{
      debugPrint('trying...');
      final currentDateSnapshot = await _userCollectionReference.doc(uid)
          .collection(DatabaseCollection.records)
          .doc(DateFormatter().toStringFormattedDate(DateTime.now()))
          .get();
      final checkInFromSnap = currentDateSnapshot['checkIn'];
      debugPrint('uid: $uid');
      final docUser = _userCollectionReference.doc(uid);
      final recordCollection = docUser.collection(DatabaseCollection.records);
      final docDate =
      recordCollection.doc(DateFormatter().toStringFormattedDate(DateTime.now()));
      return docDate.update({
        'date': Timestamp.now(),
        'checkIn': checkInFromSnap,
        'checkOut': checkOut,
        'location': location,

      });
    }catch(e){

       debugPrint('catching...');
       debugPrint('uid: $uid');
           _userCollectionReference.doc(uid)
          .collection(DatabaseCollection.records)
          .doc(DateFormatter().toStringFormattedDate(DateTime.now())).set({
             'date': Timestamp.now(),
             'checkIn': checkIn,
             'checkOut': '--/--',
             'location': location,
           });
    }
  }

  @override
  Future getRecords() async {
  //  HomeController _homeController = Get.find();
    String? uid = await _authController.getCurrentUserUid();
      final snap = await _userCollectionReference.doc(uid)
          .collection(DatabaseCollection.records)
          .doc(DateFormatter().toStringFormattedDate(DateTime.now()))
          .get();
      debugPrint('checked in: ${snap['checkIn']}');
      debugPrint('checked out: ${snap['checkOut']}');
      return snap;
    //  _homeController.getCheckedInDataFromDbRepo(snap['checkIn'], snap['checkOut']);
    //  checkIn = snap['checkIn'];
    //  checkOut = snap['checkOut'];

  }

  @override
  Stream<List<UserAction>> getCheckInOrCheckOutHistory(String uid)  {
  //  final String uid =  await _authController.getCurrentUserUid();
    return _userCollectionReference.doc(uid).collection(DatabaseCollection.records)
        .snapshots().map((event) => event.docs.map((doc) =>
        UserAction.fromJson(doc.data())).toList());
  }

  @override
  void startLocationService() async{
    _locationService.determinePosition();
    /*_locationService.getCurrentPosition();

    debugPrint(_locationService.currentPosition.longitude.toString());
    long = _locationService.currentPosition.longitude;
    lat = _locationService.currentPosition.latitude;*/


   /* UserModel userModel = UserModel();
    _locationService.initialize();
    debugPrint('starting service...');*/
  /*  _locationService.getLatitude().then((value) {
     userModel.latitude = value;
     debugPrint('lat: ${value.toString()}');
     UserModel(
       latitude: value
     );
    });*/
/*
    debugPrint('running service');
    userModel.latitude = await _locationService.getLongitude1();
    userModel.longitude = await _locationService.getLongitude();
    debugPrint('service complete');
    debugPrint(userModel.longitude.toString());
    debugPrint(userModel.latitude.toString());*/

  }





}
