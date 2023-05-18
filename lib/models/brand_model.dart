class BrandModel {
  String? message;
  List<Data>? data;

  BrandModel({message, data});

  BrandModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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

class Data {
  String? sId;
  String? name;
  String? createdOn;
  String? logo;
  String? creatorId;

  Data({sId, name, createdOn, logo, creatorId});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    createdOn = json['createdOn'];
    logo = json['logo'];
    creatorId = json['creatorId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['name'] = name;
    data['createdOn'] = createdOn;
    data['logo'] = logo;
    data['creatorId'] = creatorId;
    return data;
  }
}
