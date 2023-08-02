import 'package:car_rental/models/car_model.dart';
import 'package:get/get.dart';

import '../../main.dart';

class HomePageController extends GetxController {
  List<RxBool> isSaved = List.generate(100000, (index) => false.obs);
  onSaved(int index, SingleCarModel data) {
    if (isSaved[index].value) {
      Map carData = {
        "_id": data.sId,
        "carname": data.carname,
        "thumbnail": data.thumbnail,
        "brandId": data.brandId,
        "noOfSeats": data.noOfSeats,
        "maxSpeed": data.maxSpeed,
        "description": data.description,
        "pricePerDay": data.pricePerDay,
        "priceHalfWeek": data.priceHalfWeek,
        "pricePerWeek": data.pricePerWeek,
        "creator": {
          "email": data.creator!.email,
          "firstname": data.creator!.firstname,
          "lastname": data.creator!.lastname,
          "location": {
            "latitude": data.creator?.location?.latitude,
            "longitude": data.creator?.location?.longitude,
            "address": data.creator?.location?.address,
          },
          "phoneCode": data.creator!.phoneCode,
          "phoneCountry": data.creator!.phoneCountry,
          "phoneNumber": data.creator!.phoneNumber,
          "profile": data.creator!.profile,
          "sId": data.creator!.sId,
          "isVerified": data.creator!.isVerified,
          "createdOn": data.creator!.createdOn,
        },
        "creatorId": data.creatorId,
        "createdOn": data.createdOn,
      };
      List list = [];

      if (box.get("savedCars") == null || box.get("savedCars").length == 0) {
        list.add(carData);

        box.put("savedCars", list);
      } else {
        list = box.get("savedCars");
        list.add(carData);

        box.put("savedCars", list);
      }
    }
  }

  unsaved(List allSavedCars, SingleCarModel carData) {
    var data = allSavedCars
        .where(
          (element) => element["_id"] == carData.sId,
        )
        .first;

    allSavedCars.remove(data);
    box.put("savedCars", allSavedCars);
  }
}
