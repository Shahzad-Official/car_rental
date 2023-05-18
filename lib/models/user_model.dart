class UserModel {
  String? message;
  UserData? data;
  String? token;

  UserModel({message, data, token});

  UserModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['message'] = message;
    data['data'] = this.data!.toJson();
    data['token'] = token;
    return data;
  }
}

class UserData {
  String? sId;
  String? profile;
  String? firstname;
  String? lastname;
  String? email;
  String? password;
  String? createdOn;
  String? phoneCode;
  String? phoneNumber;
  String? phoneCountry;

  UserData(
      {sId,
      profile,
      firstname,
      lastname,
      email,
      password,
      createdOn,
      phoneCode,
      phoneNumber,
      phoneCountry});

  UserData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    profile = json['profile'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    password = json['password'];
    createdOn = json['createdOn'];
    phoneCode = json['phoneCode'];
    phoneNumber = json['phoneNumber'];
    phoneCountry = json['phoneCountry'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['profile'] = profile;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['email'] = email;
    data['password'] = password;
    data['createdOn'] = createdOn;
    data['phoneCode'] = phoneCode;
    data['phoneNumber'] = phoneNumber;
    data['phoneCountry'] = phoneCountry;
    return data;
  }
}
