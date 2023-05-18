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
}
