class UserModel {
  String? message;
  UserData? data;
  String? token;

  UserModel({this.message, this.data, this.token});

  UserModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class UserData {
  Location? location;
  String? sId;
  String? profile;
  String? firstname;
  String? lastname;
  String? email;
  String? phoneCountry;
  String? phoneCode;
  String? phoneNumber;
  String? password;
  String? createdOn;
  bool? isVerified;

  UserData({this.location, this.sId, this.profile, this.firstname, this.lastname, this.email, this.phoneCountry, this.phoneCode, this.phoneNumber, this.password, this.createdOn, this.isVerified});

  UserData.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
    sId = json['_id'];
    profile = json['profile'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    phoneCountry = json['phoneCountry'];
    phoneCode = json['phoneCode'];
    phoneNumber = json['phoneNumber'];
    password = json['password'];
    createdOn = json['createdOn'];
    isVerified = json['isVerified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['_id'] = sId;
    data['profile'] = profile;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['email'] = email;
    data['phoneCountry'] = phoneCountry;
    data['phoneCode'] = phoneCode;
    data['phoneNumber'] = phoneNumber;
    data['password'] = password;
    data['createdOn'] = createdOn;
    data['isVerified'] = isVerified;
    return data;
  }
}

class Location {
  String? address;
  String? latitude;
  String? longitude;

  Location({this.address, this.latitude, this.longitude});

  Location.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}
