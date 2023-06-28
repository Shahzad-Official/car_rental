import 'package:car_rental/constants/api_constants.dart';
import 'package:car_rental/constants/app_spacing.dart';
import 'package:car_rental/models/booking_model.dart';
import 'package:car_rental/services/url_launcher_services.dart';
import 'package:car_rental/utils/date_utils.dart';

import 'package:car_rental/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BookingDetails extends StatelessWidget {
  final BookingData bookingData;
  const BookingDetails({
    Key? key,
    required this.bookingData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText(text: "Booking Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
        ),
        child: ListView(
          children: [
            AppSpacing.heightSpace20,
            const AppText(
              text: "Booking Details",
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
            Card(
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 10,
              child: Column(
                children: [
                  AppSpacing.heightSpace10,
                  // AppCachedImage(
                  //   height: 200,
                  //   width: 300,
                  //   url: bookingData.carData!.thumbnail.toString(),
                  // ),
                  SizedBox(
                    height: 200,
                    width: 200,
                    child: Image.network(
                      "${ApiConstants.baseUrl}/${bookingData.carData!.thumbnail!}",
                      cacheHeight: 500,
                      cacheWidth: 500,
                      fit: BoxFit.fill,
                    ),
                  ),
                  ListTile(
                    visualDensity: const VisualDensity(vertical: -3),
                    title: const AppText(text: "Car Name"),
                    trailing: AppText(
                      text: "${bookingData.carData!.carname}",
                    ),
                  ),
                  ListTile(
                    visualDensity: const VisualDensity(vertical: -3),
                    title: const AppText(text: "Booked Price"),
                    trailing: AppText(
                      text: "RS. ${bookingData.price}",
                    ),
                  ),
                  ListTile(
                    visualDensity: const VisualDensity(vertical: -3),
                    title: const AppText(text: "Booked Date"),
                    trailing: AppText(
                      text: DateUtil.formatDate(
                        "dd MMM yyyy",
                        date: bookingData.bookedOn!,
                      ),
                    ),
                  ),
                  ListTile(
                    visualDensity: const VisualDensity(vertical: -3),
                    title: const AppText(text: "Expiry Date"),
                    trailing: AppText(
                      text: DateUtil.formatDate(
                        "dd MMM yyyy",
                        date: bookingData.expiredOn!,
                      ),
                    ),
                  ),
                  ListTile(
                    visualDensity: const VisualDensity(vertical: -3),
                    title: const AppText(text: "No of Seats"),
                    trailing: AppText(
                      text: bookingData.carData!.noOfSeats.toString(),
                    ),
                  ),
                  ListTile(
                    visualDensity: const VisualDensity(vertical: -3),
                    title: const AppText(text: "Max Speed"),
                    trailing: AppText(
                      text: bookingData.carData!.maxSpeed.toString(),
                    ),
                  ),
                  ListTile(
                    visualDensity: const VisualDensity(vertical: -3),
                    title: const AppText(text: "Brand Name"),
                    trailing: AppText(
                      text: "${bookingData.brandData!.name}",
                    ),
                  ),
                  ListTile(
                    title: const AppText(text: "Brand Logo"),
                    trailing: SizedBox(
                      height: 55,
                      width: 55,
                      child: Image.network(
                        "${ApiConstants.baseUrl}/${bookingData.brandData!.logo}",
                        cacheHeight: 500,
                        cacheWidth: 500,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  AppSpacing.heightSpace10,
                ],
              ),
            ),
            AppSpacing.heightSpace20,
            Card(
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 10,
              child: AppSpacing.heightSpace10,
            ),
            AppSpacing.heightSpace20,
            const AppText(
              text: "Owner Details",
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
            Card(
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 10,
              child: Column(
                children: [
                  AppSpacing.heightSpace10,
                  SizedBox(
                    height: 200,
                    width: 200,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(200),
                      child: Image.network(
                        "${ApiConstants.baseUrl}/${bookingData.ownerData!.profile!}",
                        cacheHeight: 500,
                        cacheWidth: 500,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  ListTile(
                    visualDensity: const VisualDensity(vertical: -3),
                    title: const AppText(text: "Name"),
                    trailing: AppText(
                      text: "${bookingData.ownerData!.firstname} ${bookingData.ownerData!.lastname}",
                    ),
                  ),
                  ListTile(
                    visualDensity: const VisualDensity(vertical: -3),
                    title: const AppText(text: "Email"),
                    trailing: AppText(
                      text: "${bookingData.ownerData!.email}",
                    ),
                  ),
                  ListTile(
                    visualDensity: const VisualDensity(vertical: -3),
                    title: const AppText(text: "Status"),
                    trailing: AppText(
                      text: bookingData.ownerData!.isVerified! ? "Verified" : "Not verified",
                      color: bookingData.ownerData!.isVerified! ? Colors.blue : null,
                    ),
                  ),
                  ListTile(
                    visualDensity: const VisualDensity(vertical: -3),
                    title: const AppText(text: "Phone Number"),
                    trailing: AppText(
                      text: "${bookingData.ownerData!.phoneCode}${bookingData.ownerData!.phoneNumber}",
                    ),
                  ),
                  AppSpacing.heightSpace10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () async {
                          await UrlLauncherServices.sendSms("${bookingData.ownerData!.phoneCode}${bookingData.ownerData!.phoneNumber}");
                        },
                        icon: SvgPicture.asset(
                          "assets/icons/sms.svg",
                          height: 50,
                          width: 50,
                          // ignore: deprecated_member_use
                          color: Theme.of(context).bottomNavigationBarTheme.selectedIconTheme!.color,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          await UrlLauncherServices.callUser("${bookingData.ownerData!.phoneCode}${bookingData.ownerData!.phoneNumber}").then((value) {
                            debugPrint("$value");
                          }).catchError((err) {
                            print(err);
                          });
                        },
                        icon: SvgPicture.asset(
                          "assets/icons/call.svg",
                          height: 50,
                          width: 50,
                          // ignore: deprecated_member_use
                          color: Theme.of(context).bottomNavigationBarTheme.selectedIconTheme!.color,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          await UrlLauncherServices.sendEmail(
                            bookingData.ownerData!.email.toString(),
                          );
                        },
                        icon: SvgPicture.asset(
                          "assets/icons/email.svg",
                          height: 50,
                          width: 50,
                        ),
                      ),
                    ],
                  ),
                  AppSpacing.heightSpace10,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
