import 'package:attendance_system/core/presentation/widgets/exceptionIndicators/exception_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {

   late Position currentPosition;
  Location location = Location();
  late LocationData _locationData;

  Future<void> initialize() async{
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if(!serviceEnabled){
      serviceEnabled = await location.requestService();
      if(!serviceEnabled){
        return;
      }
    }
    permissionGranted = await location.hasPermission();
    if(permissionGranted == PermissionStatus.denied){
      permissionGranted = await location.requestPermission();
      if(permissionGranted != PermissionStatus.granted){
        return;
      }
    }

  }

  Future<double?> getLatitude() async{
    _locationData = await location.getLocation();
  //  debugPrint('From location service...');
  //  debugPrint(_locationData.latitude.toString());
    return _locationData.latitude;
  }

  Future<double?> getLongitude() async{
    _locationData = await location.getLocation();
   // debugPrint('From location service...');
  //  debugPrint(_locationData.longitude.toString());
    return _locationData.longitude;
  }

  Future<double?> getLongitude1() async{
    await getLatitude();
    _locationData = await location.getLocation();
   // debugPrint('From location service...');
  //  debugPrint(_locationData.longitude.toString());
    return _locationData.latitude;
  }


  Future<void> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled){
      Geolocator.requestPermission();
      if(serviceEnabled){
        return;
      }
      return Future.error('Location services are disabled');
    }
     permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      Geolocator.requestPermission();
      ExceptionIndicator().showInfo(title: 'Location', message:
      'Location permission are denied',);
      return Future.error('Location permissions are denied');
    }

    if(permission == LocationPermission.deniedForever) {
      ExceptionIndicator().showInfo(title: 'Location',
        message: 'Location permission are permanently denied',);
      return Future.error('Location permission are permanently denied');
    }

  //  Geolocator.requestPermission();

  }

  void getCurrentPosition(){
    try{
      Geolocator.getCurrentPosition().then((Position position) {
        currentPosition = position;
      });
    }catch(e){

      debugPrint(e.toString());
    }

  }
}