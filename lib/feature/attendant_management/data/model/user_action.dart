import 'package:cloud_firestore/cloud_firestore.dart';

class UserAction {
  String? checkIn;
  String? checkOut;
  String? locationUrl;
  Timestamp? timeStamp;

  UserAction({this.checkIn, this.checkOut, this.locationUrl, this.timeStamp});

  UserAction.fromJson(Map<String, dynamic> json) {
    checkIn = json['checkIn'];
    checkOut = json['checkOut'];
    locationUrl = json['location'];
    timeStamp = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['checkIn'] = checkIn;
    data['checkOut'] = checkOut;
    data['location'] = locationUrl;
    data['date'] = timeStamp;
    return data;
  }
}
