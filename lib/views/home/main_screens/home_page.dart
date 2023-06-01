import 'dart:convert';

import 'package:car_rental/constants/app_colors.dart';
import 'package:car_rental/constants/app_spacing.dart';
import 'package:car_rental/controllers/main_page_controllers/home_page_controller.dart';
import 'package:car_rental/main.dart';
import 'package:car_rental/models/brand_model.dart';
import 'package:car_rental/models/car_model.dart';
import 'package:car_rental/models/saved_car_model.dart';
import 'package:car_rental/views/home/main_screens/brand_views/all_brands_page.dart';
import 'package:car_rental/views/home/main_screens/car_views/all_cars.dart';
import 'package:car_rental/views/home/main_screens/car_views/single_car_view.dart';
import 'package:car_rental/widgets/app_cached_image.dart';
import 'package:car_rental/widgets/app_logo.dart';
import 'package:car_rental/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  final CarModel carData;
  final BrandModel brandData;
  final bool isLoading;
  const HomePage({
    Key? key,
    required this.brandData,
    required this.carData,
    required this.isLoading,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomePageController _controller = Get.put(HomePageController());
  bool get isLoading => widget.isLoading;
  List<SavedCarModel> allSavedCars = [];
  initializeData() {
    if (box.get("savedCars") != null) {
      allSavedCars.clear();
      var data = jsonEncode(box.get("savedCars"));
      var list = jsonDecode(data);
      for (var i in list) {
        allSavedCars.add(SavedCarModel.fromJson(i));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: Center(
          child: AppLogo(
            height: 120,
            width: 120,
          ),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const AppText(
                        text: "Top Trending Cars",
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(
                            () => AllCars(
                              carModel: widget.carData,
                            ),
                          );
                        },
                        child: const AppText(
                          text: "see all",
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                AppSpacing.heightSpace20,
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    direction: Axis.horizontal,
                    spacing: 20,
                    children: List.generate(
                      widget.carData.data!.length > 4 ? 4 : widget.carData.data!.length,
                      (index) {
                        return Padding(
                          padding: index == 0 ? const EdgeInsets.only(left: 20, bottom: 20) : EdgeInsets.zero,
                          child: Card(
                            shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 10,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              height: 300,
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Stack(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Get.to(
                                              () => SingleCarView(carData: widget.carData, index: index),
                                            );
                                          },
                                          child: Hero(
                                            tag: "car$index",
                                            child: AppCachedImage(
                                              url: widget.carData.data![index].thumbnail.toString(),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Obx(
                                            () {
                                              initializeData();
                                              _controller.isSaved[index].value = allSavedCars.any((el) => el.sId == widget.carData.data![index].sId);
                                              return IconButton(
                                                onPressed: () {
                                                  if (_controller.isSaved[index].value) {
                                                    _controller.isSaved[index].value = false;
                                                    _controller.unsaved(
                                                      box.get("savedCars"),
                                                      widget.carData.data![index],
                                                    );
                                                  } else {
                                                    _controller.isSaved[index].value = true;
                                                    _controller.onSaved(index, widget.carData.data![index]);
                                                  }
                                                },
                                                icon: _controller.isSaved[index].value
                                                    ? const Icon(
                                                        Icons.bookmark_outlined,
                                                        size: 30,
                                                      )
                                                    : const Icon(
                                                        Icons.bookmark_border_rounded,
                                                        size: 30,
                                                      ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  AppSpacing.heightSpace5,
                                  AppText(
                                    text: widget.carData.data![index].carname.toString(),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  AppSpacing.heightSpace10,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const AppText(
                                        text: "Rent Per Day",
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      AppText(
                                        text: "RS. ${widget.carData.data![index].pricePerDay.toString()}",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.primaryColor,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: AppSpacing.defaultPadding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const AppText(
                        text: "Top Trending Brands",
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(
                            () => AllBrandsPage(
                              brands: widget.brandData,
                            ),
                          );
                        },
                        child: const AppText(
                          text: "see all",
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    direction: Axis.horizontal,
                    spacing: 20,
                    children: List.generate(
                      widget.brandData.data!.length,
                      (index) {
                        return Padding(
                          padding: index == 0 ? const EdgeInsets.only(left: 20) : EdgeInsets.zero,
                          child: InkWell(
                            onTap: () {
                              Get.to(
                                () => AllCars(
                                  brandId: widget.brandData.data![index].sId,
                                  appBar: AppBar(
                                    centerTitle: false,
                                    title: SizedBox(
                                      width: double.maxFinite,
                                      child: Row(
                                        children: [
                                          AppCachedImage(
                                            height: 50,
                                            width: 50,
                                            url: widget.brandData.data![index].logo.toString(),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          AppText(
                                            text: widget.brandData.data![index].name.toString(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              shape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 10,
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                height: 170,
                                width: 150,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Hero(
                                          tag: "brand$index",
                                          child: AppCachedImage(
                                            url: widget.brandData.data![index].logo.toString(),
                                          ),
                                        ),
                                      ),
                                    ),
                                    AppSpacing.heightSpace5,
                                    AppText(
                                      text: widget.brandData.data![index].name.toString(),
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    AppSpacing.heightSpace10,
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
