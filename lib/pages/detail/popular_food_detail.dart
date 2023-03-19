// ignore_for_file: public_member_api_docs, sort_constructors_first
import "package:get/get.dart";
import 'package:flutter/material.dart';

import 'package:food_delivery_app/utills/colors.dart';
import 'package:food_delivery_app/utills/dimensions.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/expandable_text.dart';
import 'package:food_delivery_app/widgets/info_column.dart';

import '../../coltrollers/popular_product_controller.dart';
import '../../utills/app_constants.dart';
import '../home/main_page.dart';

class PopularFoodDetail extends StatelessWidget {
  int pageId;
  PopularFoodDetail({
    Key? key,
    required this.pageId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //to find the controller that get us the data
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];

    print(product.id);
    print(product.name);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //the background image
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.popularPageImageSize,
              decoration:  BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    AppConstants.BASE_URL+AppConstants.UPLOAD_URL+product.img!
                  )
                ),
              ),
            ),
          ),
          // the buttons (transparent ) at the top
          Positioned(
            top: Dimensions.Height30,
            left: Dimensions.Width20,
            right: Dimensions.Width20,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const AppIcon(icon: Icons.arrow_back_ios)),
                  const AppIcon(
                    icon: Icons.shopping_cart_checkout_outlined,
                  ),
                ]),
          ),
          //reusable info coulumn & details
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.popularPageImageSize - 30,
            child: Container(
                padding: EdgeInsets.only(
                    left: Dimensions.Width20,
                    right: Dimensions.Width20,
                    top: Dimensions.Height20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      (Dimensions.radiusSize20),
                    ),
                    topRight: Radius.circular(Dimensions.radiusSize20),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InfoColumn(
                        text:product.name! ,size: Dimensions.fontSize26),
                    SizedBox(
                      height: Dimensions.Height20,
                    ),
                    BigText(
                      text: "Details",
                      size: Dimensions.fontSize26,
                    ),
                    SizedBox(
                      height: Dimensions.Height15,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: ExpandableText(
                          text:
                              product.description! ,
                          size: Dimensions.fontSize16,
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),

      //our cart button and add item
      bottomNavigationBar: Container(
        height: Dimensions.bottomHeightBarSize,
        padding: EdgeInsets.only(
            top: Dimensions.Height30,
            bottom: Dimensions.Height30,
            left: Dimensions.Width20,
            right: Dimensions.Width20),
        decoration: BoxDecoration(
          color: AppColors.buttonBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.radiusSize20 * 2),
            topRight: Radius.circular(Dimensions.radiusSize20 * 2),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //the add and remove button
            Container(
              padding: EdgeInsets.only(
                  top: Dimensions.Height20,
                  bottom: Dimensions.Height20,
                  left: Dimensions.Width20,
                  right: Dimensions.Width20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Dimensions.radiusSize20),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.remove,
                    color: AppColors.signColor,
                  ),
                  SizedBox(
                    width: Dimensions.Width10,
                  ),
                  BigText(text: "0"),
                  SizedBox(
                    width: Dimensions.Width10,
                  ),
                  Icon(
                    Icons.add,
                    color: AppColors.signColor,
                  ),
                ],
              ),
            ),
            //the add to cart Button(
            Container(
              padding: EdgeInsets.only(
                  top: Dimensions.Height20,
                  bottom: Dimensions.Height20,
                  left: Dimensions.Width20,
                  right: Dimensions.Width20),
              decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.circular(Dimensions.radiusSize20),
              ),
              child: BigText(
                text: " \$ ${product.price!} | Add To Cart",
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
