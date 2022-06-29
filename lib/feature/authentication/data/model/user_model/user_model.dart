class UserModel {
  String? uid;
  String? firstName;
  String? lastName;
  String? imgUrl;
  String? gender;
  String? userId;
  String? phoneNumber;
  double? longitude;
  double? latitude;

  UserModel(
      {this.uid,
        this.firstName,
        this.lastName,
        this.imgUrl,
        this.gender,
        this.userId,
        this.phoneNumber,
        this.longitude,
        this.latitude});

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    imgUrl = json['imgUrl'];
    gender = json['gender'];
    userId = json['userId'];
    phoneNumber = json['phoneNumber'];
    longitude = json['longitude'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['imgUrl'] = imgUrl;
    data['gender'] = gender;
    data['userId'] = userId;
    data['phoneNumber'] = phoneNumber;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    return data;
  }
}
