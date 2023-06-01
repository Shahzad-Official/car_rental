import 'package:car_rental/services/car_services.dart';
import 'package:car_rental/views/home/main_screens/car_views/single_car_view.dart';
import 'package:car_rental/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_spacing.dart';
import '../../../../widgets/app_cached_image.dart';

class MyCars extends StatefulWidget {
  const MyCars({Key? key}) : super(key: key);

  @override
  State<MyCars> createState() => _MyCarsState();
}

class _MyCarsState extends State<MyCars> {
  final CarServices _carServices = CarServices();
  bool isLoading = false;
  getData() async {
    setState(() {
      isLoading = true;
    });
    await _carServices.getMyCars();
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
        title: const AppText(text: "My Cars Collections"),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _carServices.carModel.data == null || _carServices.carModel.data!.isEmpty
              ? const Center(
                  child: AppText(
                    text: "No cars available!",
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                )
              : ListView.builder(
                  itemCount: _carServices.carModel.data!.length,
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
                                child: InkWell(
                                  onTap: () {
                                    Get.to(
                                      () => SingleCarView(
                                        isMyCar: true,
                                        index: index,
                                        carData: _carServices.carModel,
                                      ),
                                    );
                                  },
                                  child: Hero(
                                    tag: "car$index",
                                    child: AppCachedImage(
                                      url: _carServices.carModel.data![index].thumbnail.toString(),
                                    ),
                                  ),
                                ),
                              ),
                              AppSpacing.heightSpace5,
                              AppText(
                                text: _carServices.carModel.data![index].carname.toString(),
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
                                    text: "RS. ${_carServices.carModel.data![index].pricePerDay.toString()}",
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
