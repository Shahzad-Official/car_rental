import 'dart:convert';

import 'package:car_rental/models/car_model.dart';
import 'package:car_rental/views/home/main_screens/car_views/single_car_view.dart';
import 'package:car_rental/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_spacing.dart';
import '../../../../controllers/main_page_controllers/home_page_controller.dart';
import '../../../../main.dart';
import '../../../../models/saved_car_model.dart';
import '../../../../models/user_model.dart';
import '../../../../services/brand_services.dart';
import '../../../../widgets/app_cached_image.dart';

class AllCars extends StatefulWidget {
  final CarModel? carModel;
  final AppBar? appBar;
  final String? brandId;
  const AllCars({
    Key? key,
    this.carModel,
    this.appBar,
    this.brandId,
  }) : super(key: key);

  @override
  State<AllCars> createState() => _AllCarsState();
}

class _AllCarsState extends State<AllCars> {
  final HomePageController _controller = Get.put(HomePageController());
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

  BrandServices services = BrandServices();

  CarModel carsData = CarModel();
  UserData userData = UserData();
  bool isLoading = false;
  getData() async {
    var data = jsonEncode(box.get("userData"));

    userData = UserData.fromJson(jsonDecode(data));
    setState(() {
      isLoading = true;
    });
    if (widget.carModel != null) {
      carsData = widget.carModel!;
    } else {
      await services.getBrandCars(
        widget.brandId.toString(),
      );
      carsData = services.carModel;
    }
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar ??
          AppBar(
            title: const AppText(text: "All Cars"),
          ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : carsData.data == null || carsData.data!.isEmpty
              ? const Center(
                  child: AppText(text: "NO Cars Available"),
                )
              : ListView.builder(
                  itemCount: carsData.data!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Card(
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 10,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          height: 350,
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Get.to(
                                          () => SingleCarView(
                                            carData: carsData,
                                            index: index,
                                            isMyCar: userData.sId == carsData.data![index].creatorId.toString(),
                                          ),
                                        );
                                      },
                                      child: Hero(
                                        tag: "car$index",
                                        child: AppCachedImage(
                                          url: carsData.data![index].thumbnail.toString(),
                                        ),
                                      ),
                                    ),
                                    userData.sId == carsData.data![index].creatorId.toString()
                                        ? const SizedBox()
                                        : Align(
                                            alignment: Alignment.topRight,
                                            child: Obx(
                                              () {
                                                initializeData();
                                                _controller.isSaved[index].value = allSavedCars.any((el) => el.sId == carsData.data![index].sId);
                                                return IconButton(
                                                  onPressed: () {
                                                    if (_controller.isSaved[index].value) {
                                                      _controller.isSaved[index].value = false;
                                                      _controller.unsaved(
                                                        box.get("savedCars"),
                                                        carsData.data![index],
                                                      );
                                                    } else {
                                                      _controller.isSaved[index].value = true;
                                                      _controller.onSaved(index, carsData.data![index]);
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
                                text: carsData.data![index].carname.toString(),
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
                                    text: "RS. ${carsData.data![index].pricePerDay.toString()}",
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
    );
  }
}
