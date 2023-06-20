import 'package:car_rental/constants/app_colors.dart';
import 'package:car_rental/constants/app_spacing.dart';
import 'package:car_rental/controllers/profile_page_controllers/upload_car_controller.dart';
import 'package:car_rental/services/brand_services.dart';
import 'package:car_rental/widgets/app_button.dart';
import 'package:car_rental/widgets/app_cached_image.dart';
import 'package:car_rental/widgets/app_field.dart';
import 'package:car_rental/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CreateCar extends StatefulWidget {
  const CreateCar({Key? key}) : super(key: key);

  @override
  State<CreateCar> createState() => _CreateCarState();
}

class _CreateCarState extends State<CreateCar> {
  final UploadCarController _controller = Get.put(UploadCarController());
  bool brandsLoading = false;
  final BrandServices _brandServices = BrandServices();
  getData() async {
    setState(() {
      brandsLoading = true;
    });
    await _brandServices.getAllBrands();
    setState(() {
      brandsLoading = false;
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
        title: const AppText(text: "Upload a Car"),
      ),
      body: Padding(
        padding: AppSpacing.defaultPadding,
        child: ListView(
          children: [
            Center(
              child: Card(
                elevation: 10,
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: GetBuilder<UploadCarController>(
                  init: UploadCarController(),
                  builder: (_) {
                    return InkWell(
                      onTap: () async {
                        await _.pickImage();
                      },
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          image: _.carThumbnail == null
                              ? null
                              : DecorationImage(
                                  image: FileImage(_.carThumbnail!),
                                ),
                        ),
                        child: _.carThumbnail != null
                            ? null
                            : Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/upload.svg",
                                      height: 50,
                                      width: 50,
                                      // ignore: deprecated_member_use
                                      color: Theme.of(context).bottomNavigationBarTheme.selectedIconTheme!.color,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    AppText(
                                      fontSize: 20,
                                      text: "Upload car thumbnail",
                                      color: Theme.of(context).bottomNavigationBarTheme.selectedIconTheme!.color,
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
            AppSpacing.heightSpace20,
            AppField(
              controller: _controller.carName,
              hintText: "Car Name",
            ),
            AppSpacing.heightSpace20,
            brandsLoading
                ? const SpinKitThreeBounce(
                    color: AppColors.primaryColor,
                    size: 20,
                  )
                : AppDropdownField(
                    items: _brandServices.brandModel.data!
                        .map(
                          (e) => DropdownMenuItem(
                            value: e.sId,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText(
                                  text: e.name.toString(),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                AppCachedImage(
                                  height: 30,
                                  width: 30,
                                  url: e.logo.toString(),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      _controller.brandId.text = value;
                    },
                    hintText: "Select Brand",
                  ),
            AppSpacing.heightSpace20,
            AppField(
              controller: _controller.noOfSeats,
              hintText: "No of seats",
              inputType: TextInputType.number,
            ),
            AppSpacing.heightSpace20,
            AppField(
              controller: _controller.maxSpeed,
              hintText: "Car Maximum Speed",
              inputType: TextInputType.number,
            ),
            AppSpacing.heightSpace20,
            AppField(
              controller: _controller.pricePerDay,
              hintText: "Price per day",
              inputType: TextInputType.number,
            ),
            AppSpacing.heightSpace20,
            AppField(
              controller: _controller.priceHalfWeek,
              hintText: "Price for half week",
              inputType: TextInputType.number,
            ),
            AppSpacing.heightSpace20,
            AppField(
              controller: _controller.pricePerWeek,
              hintText: "Price for week",
              inputType: TextInputType.number,
            ),
            AppSpacing.heightSpace20,
            AppField(
              controller: _controller.description,
              hintText: "Car About",
              maxLength: 250,
              maxLines: 10,
            ),
            AppSpacing.heightSpace20,
            GetBuilder<UploadCarController>(
              init: UploadCarController(),
              initState: (_) {},
              builder: (_) {
                return AppButton(
                  isLoading: _.isLoading,
                  onTap: () async {
                    await _.uploadCarData(context);
                  },
                  text: "Create",
                );
              },
            ),
            AppSpacing.heightSpace20,
          ],
        ),
      ),
    );
  }
}
