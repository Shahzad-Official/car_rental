class CarModel {
  String? message;
  List<SingleCarModel>? data;
  int? length;

  CarModel({this.message, this.data, this.length});

  CarModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <SingleCarModel>[];
      json['data'].forEach((v) {
        data!.add(SingleCarModel.fromJson(v));
      });
    }
    length = json['length'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['length'] = length;
    return data;
  }
}

class SingleCarModel {
  String? sId;
  String? carname;
  String? thumbnail;
  String? brandId;
  String? noOfSeats;
  String? maxSpeed;
  String? description;
  String? pricePerDay;
  String? priceHalfWeek;
  String? pricePerWeek;
  String? creatorId;
  String? createdOn;
  Creator? creator;
  Brand? brand;

  SingleCarModel(
      {this.sId,
      this.carname,
      this.thumbnail,
      this.brandId,
      this.noOfSeats,
      this.maxSpeed,
      this.description,
      this.pricePerDay,
      this.priceHalfWeek,
      this.pricePerWeek,
      this.creatorId,
      this.createdOn,
      this.creator,
      this.brand});

  SingleCarModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    carname = json['carname'];
    thumbnail = json['thumbnail'];
    brandId = json['brandId'];
    noOfSeats = json['noOfSeats'];
    maxSpeed = json['maxSpeed'];
    description = json['description'];
    pricePerDay = json['pricePerDay'];
    priceHalfWeek = json['priceHalfWeek'];
    pricePerWeek = json['pricePerWeek'];
    creatorId = json['creatorId'];
    createdOn = json['createdOn'];
    creator = json['creator'] != null ? Creator.fromJson(json['creator']) : null;
    brand = json['brand'] != null ? Brand.fromJson(json['brand']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['carname'] = carname;
    data['thumbnail'] = thumbnail;
    data['brandId'] = brandId;
    data['noOfSeats'] = noOfSeats;
    data['maxSpeed'] = maxSpeed;
    data['description'] = description;
    data['pricePerDay'] = pricePerDay;
    data['priceHalfWeek'] = priceHalfWeek;
    data['pricePerWeek'] = pricePerWeek;
    data['creatorId'] = creatorId;
    data['createdOn'] = createdOn;
    if (creator != null) {
      data['creator'] = creator!.toJson();
    }
    if (brand != null) {
      data['brand'] = brand!.toJson();
    }
    return data;
  }
}

class Creator {
  String? sId;
  String? profile;
  String? firstname;
  String? lastname;
  String? email;
  String? phoneCountry;
  String? phoneCode;
  String? phoneNumber;
  String? password;
  Location? location;
  String? createdOn;
  bool? isVerified;

  Creator({this.sId, this.profile, this.firstname, this.lastname, this.email, this.phoneCountry, this.phoneCode, this.phoneNumber, this.password, this.location, this.createdOn, this.isVerified});

  Creator.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    profile = json['profile'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    phoneCountry = json['phoneCountry'];
    phoneCode = json['phoneCode'];
    phoneNumber = json['phoneNumber'];
    password = json['password'];
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
    createdOn = json['createdOn'];
    isVerified = json['isVerified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['profile'] = profile;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['email'] = email;
    data['phoneCountry'] = phoneCountry;
    data['phoneCode'] = phoneCode;
    data['phoneNumber'] = phoneNumber;
    data['password'] = password;
    if (location != null) {
      data['location'] = location!.toJson();
    }
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

class Brand {
  String? sId;
  String? name;
  String? createdOn;
  String? logo;
  String? creatorId;

  Brand({this.sId, this.name, this.createdOn, this.logo, this.creatorId});

  Brand.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    createdOn = json['createdOn'];
    logo = json['logo'];
    creatorId = json['creatorId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['createdOn'] = createdOn;
    data['logo'] = logo;
    data['creatorId'] = creatorId;
    return data;
  }
}
