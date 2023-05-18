class CarModel {
  String? message;
  List<SingleCarModel>? data;

  CarModel({message, data});

  CarModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <SingleCarModel>[];
      json['data'].forEach((v) {
        data!.add(SingleCarModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['message'] = message;
    data['data'] = this.data!.map((v) => v.toJson()).toList();
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

  SingleCarModel(
      {sId,
      carname,
      thumbnail,
      brandId,
      noOfSeats,
      maxSpeed,
      description,
      pricePerDay,
      priceHalfWeek,
      pricePerWeek,
      creatorId,
      createdOn});

  SingleCarModel.fromJson(Map json) {
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
    final Map<String, dynamic> data = {};
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
