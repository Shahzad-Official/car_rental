import 'package:car_rental/models/brand_model.dart';
import 'package:car_rental/views/home/main_screens/car_views/all_cars.dart';
import 'package:car_rental/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../../../constants/app_spacing.dart';
import '../../../../widgets/app_cached_image.dart';

class AllBrandsPage extends StatelessWidget {
  final BrandModel brands;
  const AllBrandsPage({
    Key? key,
    required this.brands,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText(text: "All Brands"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          itemCount: brands.data!.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Get.to(
                  () => AllCars(
                    brandId: brands.data![index].sId,
                    appBar: AppBar(
                      centerTitle: false,
                      title: SizedBox(
                        width: double.maxFinite,
                        child: Row(
                          children: [
                            Hero(
                              tag: "brand$index",
                              child: AppCachedImage(
                                height: 50,
                                width: 50,
                                url: brands.data![index].logo.toString(),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            AppText(
                              text: brands.data![index].name.toString(),
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
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Hero(
                            tag: "brand$index",
                            child: AppCachedImage(
                              url: brands.data![index].logo.toString(),
                            ),
                          ),
                        ),
                      ),
                      AppSpacing.heightSpace5,
                      AppText(
                        text: brands.data![index].name.toString(),
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                      AppSpacing.heightSpace10,
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
