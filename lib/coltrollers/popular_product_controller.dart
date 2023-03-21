import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/api/repository/popular_product_repo.dart';
import '../models/popular_model.dart';
import '../utills/colors.dart';
import 'cart_controller.dart';

class PopularProductController extends GetxController {
  final PopularPoductRepo popularPoductRepo;
  PopularProductController({required this.popularPoductRepo});

  late CartController _cart;

  List<ProductModal> _popularProductList = [];
  List<ProductModal> get popularProductList => _popularProductList;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  Future<void> getPopularProductList() async {
    Response response = await popularPoductRepo.getPopularProductList();
    // if (response.statusCode == 200) {
    //   _popularProductList = [];
    //   // create a model to accept the data from json
    //   // _popularProductList.addAll();
    //   update(); //is like setState for Getx
    // } else {}

    if (response.statusCode == 200) {
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      //  Map rawData = jsonDecode(response.body);
      // _popularProductList.addAll(Product.fromJson(rawData).products);
      //print(_popularProductList);
      _isLoaded = true;
      update();
    } else {
      print("could ont get products, : from controller");
    }
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
      // print("Indremented$_quantity");
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update(); //to build the UI everytime there is an update in quantity
  }

  int checkQuantity(int quantity) {
    if (quantity < 0) {
      Get.snackbar(
        "Sorry",
        "You can't reduce more",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
        overlayBlur: 1,
      );
      return 0;
    } else if (quantity > 30) {
      Get.snackbar(
        "Sorry",
        "You can't Add more",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
        overlayBlur: 1,

      );
      return 30;
    } else {
      return quantity;
    }
  }

  void initProduct(CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    //TODO: get from storage _inCartItems
  }

  void addItem(ProductModal product) {
    if (_quantity > 0) {
      _cart.addItem(product, _quantity);
    }else{
       Get.snackbar(
        "Sorry",
        "Can't add null value to cart",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
        overlayBlur: 1,
      );
    }
  }
}
