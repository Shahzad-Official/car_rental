import 'package:car_rental/constants/app_spacing.dart';
import 'package:car_rental/main.dart';
import 'package:car_rental/models/car_model.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../widgets/app_cached_image.dart';
import '../../../widgets/app_text.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({Key? key}) : super(key: key);

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  List<SingleCarModel> allCars = [];
  bool isLoading = false;
  getData() async {
    allCars.clear();
    setState(() {
      isLoading = true;
    });
    if (box.get("savedCars") != null) {
      List list = await box.get("savedCars");
      for (var i in list) {
        allCars.add(SingleCarModel.fromJson(i));
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
              : ListView.builder(
                  itemCount: allCars.length,
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
                                child: AppCachedImage(
                                  url: allCars[index].thumbnail.toString(),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const AppText(
                                    text: "Rent Per Day",
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  AppText(
                                    text:
                                        "RS. ${allCars[index].pricePerDay.toString()}",
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
