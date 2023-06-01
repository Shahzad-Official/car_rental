import 'package:car_rental/models/car_model.dart';
import 'package:car_rental/widgets/app_button.dart';
import 'package:car_rental/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: BackButton(
          color: Theme.of(context).iconTheme.color,
        ),
        elevation: 0,
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
                                  AppButton(
                                    onTap: () {},
                                    text: "Rent Now",
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
                                  AppButton(
                                    onTap: () {},
                                    text: "Rent Now",
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
                                  AppButton(
                                    onTap: () {},
                                    text: "Rent Now",
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
