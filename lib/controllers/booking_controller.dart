import 'package:car_rental/services/booking_services.dart';
import 'package:get/get.dart';

class BookingController extends GetxController {
  final BookingServices _services = BookingServices();
  bool isLoading = false;
  bookNow({
    required String carId,
    required int days,
  }) async {
    isLoading = true;
    update();
    await _services.makeBooking(
      carId: carId,
      bookedOn: DateTime.now().toString(),
      duration: days.toString(),
      expiredOn: DateTime.now()
          .add(
            Duration(
              days: days,
            ),
          )
          .toString(),
    );
    isLoading = false;
    update();
  }
}
