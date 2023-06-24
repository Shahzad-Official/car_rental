import 'dart:ui' as ui;
import 'package:car_rental/controllers/booking_controller.dart';
import 'package:car_rental/models/car_model.dart';
import 'package:car_rental/widgets/app_button.dart';
import 'package:car_rental/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../constants/app_spacing.dart';
import '../../../../widgets/app_cached_image.dart';

class SingleCarView extends StatelessWidget {
  final CarModel? carData;
  final List<SingleCarModel>? savedCarData;
  final int index;
  final bool isMyCar;
  const SingleCarView({
    Key? key,
    this.carData,
    required this.index,
    this.savedCarData,
    this.isMyCar = false,
  }) : super(key: key);
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  Future<BitmapDescriptor> createIcon() async {
    Uint8List unit8list = await getBytesFromAsset(
      "assets/images/car_map.png",
      70,
    );
    return BitmapDescriptor.fromBytes(unit8list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const AppText(
          text: "Car Details",
        ),
      ),
      body: Padding(
        padding: AppSpacing.defaultPadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: "car$index",
                child: Card(
                  elevation: 10,
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    margin: const EdgeInsets.all(15),
                    height: 300,
                    width: double.maxFinite,
                    child: AppCachedImage(
                      url: carData == null ? savedCarData![index].thumbnail.toString() : carData!.data![index].thumbnail.toString(),
                    ),
                  ),
                ),
              ),
              AppSpacing.heightSpace20,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/meter.svg",
                        height: 50,
                        width: 50,
                        // ignore: deprecated_member_use
                        color: Theme.of(context).bottomNavigationBarTheme.selectedIconTheme!.color,
                      ),
                      AppSpacing.heightSpace10,
                      AppText(
                        text: "${carData == null ? savedCarData![index].maxSpeed.toString() : carData!.data![index].maxSpeed.toString()} KMH",
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/seats.svg",
                        height: 50,
                        width: 50,
                        // ignore: deprecated_member_use
                        color: Theme.of(context).bottomNavigationBarTheme.selectedIconTheme!.color,
                      ),
                      AppSpacing.heightSpace10,
                      AppText(
                        text: carData == null ? savedCarData![index].noOfSeats.toString() : carData!.data![index].noOfSeats.toString(),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ],
              ),
              AppSpacing.heightSpace20,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppText(
                    text: "Car Description : ",
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  AppSpacing.heightSpace5,
                  AppText(
                    lineHeight: 1.3,
                    text: carData == null ? savedCarData![index].description.toString() : carData!.data![index].description.toString(),
                  ),
                ],
              ),
              AppSpacing.heightSpace5,
              const AppText(
                text: "Car Location",
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
              Card(
                elevation: 5,
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  height: 300,
                  width: double.maxFinite,
                  child: FutureBuilder<BitmapDescriptor>(
                      future: createIcon(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return GoogleMap(
                            markers: {
                              Marker(
                                markerId: const MarkerId("1"),
                                icon: snapshot.data!,
                                position: LatLng(
                                    carData == null
                                        ? double.parse(savedCarData![index].creator!.location!.latitude.toString())
                                        : double.parse(carData!.data![index].creator!.location!.latitude.toString()),
                                    carData == null
                                        ? double.parse(savedCarData![index].creator!.location!.longitude.toString())
                                        : double.parse(carData!.data![index].creator!.location!.longitude.toString())),
                              ),
                            },
                            initialCameraPosition: CameraPosition(
                              zoom: 14,
                              target: LatLng(
                                  carData == null
                                      ? double.parse(savedCarData![index].creator!.location!.latitude.toString())
                                      : double.parse(carData!.data![index].creator!.location!.latitude.toString()),
                                  carData == null
                                      ? double.parse(savedCarData![index].creator!.location!.longitude.toString())
                                      : double.parse(carData!.data![index].creator!.location!.longitude.toString())),
                            ),
                          );
                        }
                      }),
                ),
              ),
              AppSpacing.heightSpace20,
              Card(
                elevation: 5,
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
                child: ListTile(
                  onTap: isMyCar
                      ? null
                      : () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                shape: BeveledRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                icon: const Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppText(
                                      text: "Rent a Car for 1 day.",
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    CloseButton(),
                                  ],
                                ),
                                actions: [
                                  GetBuilder<BookingController>(
                                    init: BookingController(),
                                    initState: (_) {},
                                    builder: (_) {
                                      return AppButton(
                                        isLoading: _.isLoading,
                                        onTap: () async {
                                          await _.bookNow(
                                            carId: carData == null ? savedCarData![index].sId.toString() : carData!.data![index].sId.toString(),
                                            days: 1,
                                          );
                                        },
                                        text: "Rent Now",
                                      );
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                  title: const AppText(
                    text: "Rent For 1 day",
                  ),
                  subtitle: AppText(
                    text: "RS.${carData == null ? savedCarData![index].pricePerDay.toString() : carData!.data![index].pricePerDay.toString()}",
                    lineHeight: 2,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).bottomNavigationBarTheme.selectedIconTheme!.color,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Theme.of(context).bottomNavigationBarTheme.selectedIconTheme!.color,
                  ),
                ),
              ),
              AppSpacing.heightSpace20,
              Card(
                elevation: 5,
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
                child: ListTile(
                  onTap: isMyCar
                      ? null
                      : () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                shape: BeveledRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                icon: const Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppText(
                                      text: "Rent a Car for 3 days.",
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    CloseButton(),
                                  ],
                                ),
                                actions: [
                                  GetBuilder<BookingController>(
                                    init: BookingController(),
                                    initState: (_) {},
                                    builder: (_) {
                                      return AppButton(
                                        isLoading: _.isLoading,
                                        onTap: () async {
                                          await _.bookNow(
                                            carId: carData == null ? savedCarData![index].sId.toString() : carData!.data![index].sId.toString(),
                                            days: 3,
                                          );
                                        },
                                        text: "Rent Now",
                                      );
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                  title: const AppText(
                    text: "Rent For 3 days",
                  ),
                  subtitle: AppText(
                    text: "RS.${carData == null ? savedCarData![index].priceHalfWeek.toString() : carData!.data![index].priceHalfWeek.toString()}",
                    lineHeight: 2,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).bottomNavigationBarTheme.selectedIconTheme!.color,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Theme.of(context).bottomNavigationBarTheme.selectedIconTheme!.color,
                  ),
                ),
              ),
              AppSpacing.heightSpace20,
              Card(
                elevation: 5,
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
                child: ListTile(
                  onTap: isMyCar
                      ? null
                      : () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                shape: BeveledRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                icon: const Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppText(
                                      text: "Rent a Car for a week.",
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    CloseButton(),
                                  ],
                                ),
                                actions: [
                                  GetBuilder<BookingController>(
                                    init: BookingController(),
                                    initState: (_) {},
                                    builder: (_) {
                                      return AppButton(
                                        isLoading: _.isLoading,
                                        onTap: () async {
                                          await _.bookNow(
                                            carId: carData == null ? savedCarData![index].sId.toString() : carData!.data![index].sId.toString(),
                                            days: 7,
                                          );
                                        },
                                        text: "Rent Now",
                                      );
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                  title: const AppText(
                    text: "Rent For a week",
                  ),
                  subtitle: AppText(
                    text: "RS.${carData == null ? savedCarData![index].pricePerWeek.toString() : carData!.data![index].pricePerWeek.toString()}",
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).bottomNavigationBarTheme.selectedIconTheme!.color,
                    lineHeight: 2,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Theme.of(context).bottomNavigationBarTheme.selectedIconTheme!.color,
                  ),
                ),
              ),
              AppSpacing.heightSpace20,
            ],
          ),
        ),
      ),
    );
  }
}
