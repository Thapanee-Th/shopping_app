import 'package:get/get.dart';
import 'package:shopping_app/src/app/cart/cart_view.dart';
import 'package:shopping_app/src/app/home/home_view.dart';

final routes = [
  GetPage(
    name: homeView,
    page: () => HomeView(),
  ),
  GetPage(
    name: cartView,
    page: () => CartView(),
  ),
];
