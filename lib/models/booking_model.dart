class BookingModel {
  List<BookingData>? bookingData;
  int? length;

  BookingModel({this.bookingData, this.length});

  BookingModel.fromJson(Map<String, dynamic> json) {
    if (json['bookingData'] != null) {
      bookingData = <BookingData>[];
      json['bookingData'].forEach((v) {
        bookingData!.add(BookingData.fromJson(v));
      });
    }
    length = json['length'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (bookingData != null) {
      data['bookingData'] = bookingData!.map((v) => v.toJson()).toList();
    }
    data['length'] = length;
    return data;
  }
}

class BookingData {
  String? sId;
  String? carId;
  String? userId;
  String? bookedOn;
  String? expiredOn;
  String? duration;
  String? price;
  UserData? userData;
  CarData? carData;
  BrandData? brandData;
  UserData? ownerData;

  BookingData({this.sId, this.carId, this.userId, this.bookedOn, this.expiredOn, this.duration, this.price, this.userData, this.carData, this.brandData, this.ownerData});

  BookingData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    carId = json['carId'];
    userId = json['userId'];
    bookedOn = json['bookedOn'];
    expiredOn = json['expiredOn'];
    duration = json['duration'];
    price = json['price'];
    userData = json['userData'] != null ? UserData.fromJson(json['userData']) : null;
    carData = json['carData'] != null ? CarData.fromJson(json['carData']) : null;
    brandData = json['brandData'] != null ? BrandData.fromJson(json['brandData']) : null;
    ownerData = json['ownerData'] != null ? UserData.fromJson(json['ownerData']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['carId'] = carId;
    data['userId'] = userId;
    data['bookedOn'] = bookedOn;
    data['expiredOn'] = expiredOn;
    data['duration'] = duration;
    data['price'] = price;
    if (userData != null) {
      data['userData'] = userData!.toJson();
    }
    if (carData != null) {
      data['carData'] = carData!.toJson();
    }
    if (brandData != null) {
      data['brandData'] = brandData!.toJson();
    }
    if (ownerData != null) {
      data['ownerData'] = ownerData!.toJson();
    }
    return data;
  }
}

class UserData {
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

  UserData({this.sId, this.profile, this.firstname, this.lastname, this.email, this.phoneCountry, this.phoneCode, this.phoneNumber, this.password, this.location, this.createdOn, this.isVerified});

  UserData.fromJson(Map<String, dynamic> json) {
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

class CarData {
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

  CarData(
      {this.sId, this.carname, this.thumbnail, this.brandId, this.noOfSeats, this.maxSpeed, this.description, this.pricePerDay, this.priceHalfWeek, this.pricePerWeek, this.creatorId, this.createdOn});

  CarData.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

class BrandData {
  String? sId;
  String? name;
  String? createdOn;
  String? logo;
  String? creatorId;

  BrandData({this.sId, this.name, this.createdOn, this.logo, this.creatorId});

  BrandData.fromJson(Map<String, dynamic> json) {
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
