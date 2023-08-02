import 'dart:convert';

import 'package:car_rental/constants/app_spacing.dart';
import 'package:car_rental/main.dart';
import 'package:car_rental/models/car_model.dart';
import 'package:car_rental/views/home/main_screens/car_views/single_car_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../controllers/main_page_controllers/home_page_controller.dart';
import '../../../models/booking_model.dart';
import '../../../models/saved_car_model.dart';
import '../../../widgets/app_cached_image.dart';
import '../../../widgets/app_text.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({Key? key}) : super(key: key);

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  final HomePageController _controller = Get.put(HomePageController());
  List<SavedCarModel> allSavedCars = [];
  UserData userData = UserData();
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

  List<SingleCarModel> allCars = [];
  bool isLoading = false;
  getData() async {
    var data = jsonEncode(box.get("userData"));

    userData = UserData.fromJson(jsonDecode(data));
    allCars.clear();
    setState(() {
      isLoading = true;
    });
    if (box.get("savedCars") != null) {
      List list = await box.get("savedCars");

      for (var i in list) {
        allCars.add(SingleCarModel.fromJson(jsonDecode(jsonEncode(i))));
      }
    } else {
      allCars = [];
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText(text: "My Saved Cars"),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : allCars.isEmpty
              ? const Center(
                  child: AppText(
                    text: "No saved cars available!",
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                )
              : Center(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: allCars.length,
                    itemBuilder: (context, index) {
                      if (userData.sId == allCars[index].creatorId) {
                        return const Center(
                          child: AppText(
                            text: "No saved cars available!",
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      }
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
                                      InkWell(
                                        onTap: () {
                                          Get.to(
                                            () => SingleCarView(
                                              index: index,
                                              savedCarData: allCars,
                                            ),
                                          );
                                        },
                                        child: Hero(
                                          tag: "car$index",
                                          child: AppCachedImage(
                                            url: allCars[index].thumbnail.toString(),
                                          ),
                                        ),
                                      ),
                                      userData.sId == allCars[index].creatorId.toString()
                                          ? const SizedBox()
                                          : Align(
                                              alignment: Alignment.topRight,
                                              child: Obx(
                                                () {
                                                  initializeData();
                                                  _controller.isSaved[index].value = allSavedCars.any((el) => el.sId == allCars[index].sId);
                                                  return IconButton(
                                                    onPressed: () {
                                                      if (_controller.isSaved[index].value) {
                                                        _controller.isSaved[index].value = false;
                                                        _controller.unsaved(
                                                          box.get("savedCars"),
                                                          allCars[index],
                                                        );
                                                        allCars.removeAt(index);
                                                        setState(() {});
                                                      } else {
                                                        _controller.isSaved[index].value = true;
                                                        _controller.onSaved(index, allCars[index]);
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
                                  text: allCars[index].carname.toString(),
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
                                      text: "RS. ${allCars[index].pricePerDay.toString()}",
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
    );
  }
}
